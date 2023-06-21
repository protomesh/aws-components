package main

import (
	"flag"
	"os"

	"github.com/aws/aws-sdk-go-v2/service/servicediscovery"
	"github.com/protomesh/aws-components/worker/networking"
	"github.com/protomesh/go-app"

	awsprovider "github.com/protomesh/protomesh/provider/aws"
	temporalprovider "github.com/protomesh/protomesh/provider/temporal"

	"go.temporal.io/sdk/worker"
)

type root struct {
	*app.Injector[*root]

	Aws *awsprovider.AwsBuilder[*root] `config:"aws"`

	Temporal *temporalprovider.TemporalBuilder[*root] `config:"temporal"`
	worker   worker.Worker

	WorkerTaskQueue app.Config `config:"worker.task.queue,str" default:"aws" usage:"Temporal task queue to register activities and workflows"`

	Networking *networking.ActivityPack[*root] `config:"networking"`
}

func newRoot() *root {
	return &root{}
}

func (r *root) Dependency() *root {
	return r
}

func (r *root) GetAwsServiceDiscoveryClient() *servicediscovery.Client {
	return servicediscovery.NewFromConfig(r.Aws.AwsConfig)
}

func (r *root) GetTemporalWorker() worker.Worker {
	return r.worker
}

var opts = &app.AppOptions{
	FlagSet: flag.CommandLine,
	Print:   os.Getenv("PRINT_CONFIG") == "true",
}

func main() {

	deps := newRoot()

	workerApp := app.NewApp(deps, opts)
	defer workerApp.Close()

	log := workerApp.Log()

	deps.Aws.Initialize()

	temporalClient := deps.Temporal.GetTemporalClient()
	defer temporalClient.Close()

	workerOpts := worker.Options{
		WorkflowPanicPolicy:         worker.BlockWorkflow,
		DisableRegistrationAliasing: true,
	}

	deps.worker = worker.New(
		temporalClient,
		deps.WorkerTaskQueue.StringVal(),
		workerOpts,
	)

	deps.Networking.Register()

	deps.worker.Start()
	defer deps.worker.Stop()

	log.Info("Worker is running")

	app.WaitInterruption()

}
