package networking

import (
	"context"
	"strconv"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/servicediscovery"
	"github.com/aws/aws-sdk-go-v2/service/servicediscovery/types"
	networkingv1 "github.com/protomesh/aws-components/proto/api/networking/v1"
	typesv1 "github.com/protomesh/protomesh/proto/api/types/v1"
)

func (ap *ActivityPack[D]) ListInstanceSetsFromCloudMap(ctx context.Context, input *networkingv1.ListInstanceSetsFromCloudMap_Input) (*networkingv1.ListInstanceSetsFromCloudMap_Output, error) {

	cloudMapClient := ap.Dependency().GetAwsServiceDiscoveryClient()

	listServicesInput := &servicediscovery.ListServicesInput{
		Filters: []types.ServiceFilter{
			{
				Name:      types.ServiceFilterNameNamespaceId,
				Condition: types.FilterConditionEq,
				Values:    []string{input.NamespaceId},
			},
		},
		MaxResults: aws.Int32(25),
	}

	if len(input.NextToken) > 0 {
		listServicesInput.NextToken = aws.String(input.NextToken)
	}

	listServices, err := cloudMapClient.ListServices(ctx, listServicesInput)
	if err != nil {
		return nil, err
	}

	output := &networkingv1.ListInstanceSetsFromCloudMap_Output{
		NextToken:    aws.ToString(listServices.NextToken),
		InstanceSets: []*typesv1.InstanceSet{},
	}

	for _, service := range listServices.Services {

		listTags, err := cloudMapClient.ListTagsForResource(ctx, &servicediscovery.ListTagsForResourceInput{
			ResourceARN: service.Arn,
		})
		if err != nil {
			return nil, err
		}

		tags := make(map[string]string)

		for _, tag := range listTags.Tags {
			tags[aws.ToString(tag.Key)] = aws.ToString(tag.Value)
		}

		port, err := strconv.ParseInt(tags["port"], 10, 32)
		if err != nil {
			return nil, err
		}

		listInstancesPages := servicediscovery.NewListInstancesPaginator(cloudMapClient, &servicediscovery.ListInstancesInput{
			ServiceId: service.Id,
		})

		instanceSet := &typesv1.InstanceSet{
			Instances:         []*typesv1.InstanceSet_Instance{},
			MatchServiceNames: []string{aws.ToString(service.Name)},
		}

		output.InstanceSets = append(output.InstanceSets, instanceSet)

		for listInstancesPages.HasMorePages() {

			listInstancesOutput, err := listInstancesPages.NextPage(ctx)
			if err != nil {
				return nil, err
			}

			for _, instance := range listInstancesOutput.Instances {

				instanceSet.Instances = append(instanceSet.Instances, &typesv1.InstanceSet_Instance{
					Hostname:          aws.ToString(instance.Id),
					Address:           instance.Attributes["AWS_INSTANCE_IPV4"],
					Port:              int32(port),
					TransportProtocol: typesv1.TransportProtocol_TRANSPORT_PROTOCOL_TCP,
					Region:            instance.Attributes["AWS_INSTANCE_REGION"],
					Zone:              instance.Attributes["AVAILABILITY_ZONE"],
				})

			}

		}

	}

	return output, nil

}
