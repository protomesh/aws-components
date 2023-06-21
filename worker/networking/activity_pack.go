package networking

import (
	"github.com/aws/aws-sdk-go-v2/service/servicediscovery"
	"github.com/protomesh/go-app"
	"go.temporal.io/sdk/activity"
	"go.temporal.io/sdk/worker"
)

type ActivityPackDependency interface {
	GetTemporalWorker() worker.Worker
	GetAwsServiceDiscoveryClient() *servicediscovery.Client
}

type ActivityPack[D ActivityPackDependency] struct {
	*app.Injector[D]
}

func (ap *ActivityPack[D]) Register() {

	w := ap.Dependency().GetTemporalWorker()

	w.RegisterActivityWithOptions(
		ap.ListInstanceSetsFromCloudMap,
		activity.RegisterOptions{
			Name: "AWS_ListInstanceSetsFromCloudMap",
		},
	)

}
