// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.28.1
// 	protoc        (unknown)
// source: api/networking/v1/cloud_map.proto

package networkingv1

import (
	v1 "github.com/protomesh/protomesh/proto/api/types/v1"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type ListInstanceSetsFromCloudMap struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *ListInstanceSetsFromCloudMap) Reset() {
	*x = ListInstanceSetsFromCloudMap{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_networking_v1_cloud_map_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ListInstanceSetsFromCloudMap) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListInstanceSetsFromCloudMap) ProtoMessage() {}

func (x *ListInstanceSetsFromCloudMap) ProtoReflect() protoreflect.Message {
	mi := &file_api_networking_v1_cloud_map_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListInstanceSetsFromCloudMap.ProtoReflect.Descriptor instead.
func (*ListInstanceSetsFromCloudMap) Descriptor() ([]byte, []int) {
	return file_api_networking_v1_cloud_map_proto_rawDescGZIP(), []int{0}
}

type ListInstanceSetsFromCloudMap_Input struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	NamespaceId       string `protobuf:"bytes,1,opt,name=namespace_id,json=namespaceId,proto3" json:"namespace_id,omitempty"`
	ServicePortTagKey string `protobuf:"bytes,2,opt,name=service_port_tag_key,json=servicePortTagKey,proto3" json:"service_port_tag_key,omitempty"`
	NextToken         string `protobuf:"bytes,3,opt,name=next_token,json=nextToken,proto3" json:"next_token,omitempty"`
}

func (x *ListInstanceSetsFromCloudMap_Input) Reset() {
	*x = ListInstanceSetsFromCloudMap_Input{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_networking_v1_cloud_map_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ListInstanceSetsFromCloudMap_Input) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListInstanceSetsFromCloudMap_Input) ProtoMessage() {}

func (x *ListInstanceSetsFromCloudMap_Input) ProtoReflect() protoreflect.Message {
	mi := &file_api_networking_v1_cloud_map_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListInstanceSetsFromCloudMap_Input.ProtoReflect.Descriptor instead.
func (*ListInstanceSetsFromCloudMap_Input) Descriptor() ([]byte, []int) {
	return file_api_networking_v1_cloud_map_proto_rawDescGZIP(), []int{0, 0}
}

func (x *ListInstanceSetsFromCloudMap_Input) GetNamespaceId() string {
	if x != nil {
		return x.NamespaceId
	}
	return ""
}

func (x *ListInstanceSetsFromCloudMap_Input) GetServicePortTagKey() string {
	if x != nil {
		return x.ServicePortTagKey
	}
	return ""
}

func (x *ListInstanceSetsFromCloudMap_Input) GetNextToken() string {
	if x != nil {
		return x.NextToken
	}
	return ""
}

type ListInstanceSetsFromCloudMap_Output struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	InstanceSets []*v1.InstanceSet `protobuf:"bytes,1,rep,name=instance_sets,json=instanceSets,proto3" json:"instance_sets,omitempty"`
	NextToken    string            `protobuf:"bytes,2,opt,name=next_token,json=nextToken,proto3" json:"next_token,omitempty"`
}

func (x *ListInstanceSetsFromCloudMap_Output) Reset() {
	*x = ListInstanceSetsFromCloudMap_Output{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_networking_v1_cloud_map_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ListInstanceSetsFromCloudMap_Output) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListInstanceSetsFromCloudMap_Output) ProtoMessage() {}

func (x *ListInstanceSetsFromCloudMap_Output) ProtoReflect() protoreflect.Message {
	mi := &file_api_networking_v1_cloud_map_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListInstanceSetsFromCloudMap_Output.ProtoReflect.Descriptor instead.
func (*ListInstanceSetsFromCloudMap_Output) Descriptor() ([]byte, []int) {
	return file_api_networking_v1_cloud_map_proto_rawDescGZIP(), []int{0, 1}
}

func (x *ListInstanceSetsFromCloudMap_Output) GetInstanceSets() []*v1.InstanceSet {
	if x != nil {
		return x.InstanceSets
	}
	return nil
}

func (x *ListInstanceSetsFromCloudMap_Output) GetNextToken() string {
	if x != nil {
		return x.NextToken
	}
	return ""
}

var File_api_networking_v1_cloud_map_proto protoreflect.FileDescriptor

var file_api_networking_v1_cloud_map_proto_rawDesc = []byte{
	0x0a, 0x21, 0x61, 0x70, 0x69, 0x2f, 0x6e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67,
	0x2f, 0x76, 0x31, 0x2f, 0x63, 0x6c, 0x6f, 0x75, 0x64, 0x5f, 0x6d, 0x61, 0x70, 0x2e, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x12, 0x1b, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x2e, 0x61,
	0x77, 0x73, 0x2e, 0x6e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x2e, 0x76, 0x31,
	0x1a, 0x1d, 0x61, 0x70, 0x69, 0x2f, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2f, 0x76, 0x31, 0x2f, 0x6e,
	0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22,
	0x89, 0x02, 0x0a, 0x1c, 0x4c, 0x69, 0x73, 0x74, 0x49, 0x6e, 0x73, 0x74, 0x61, 0x6e, 0x63, 0x65,
	0x53, 0x65, 0x74, 0x73, 0x46, 0x72, 0x6f, 0x6d, 0x43, 0x6c, 0x6f, 0x75, 0x64, 0x4d, 0x61, 0x70,
	0x1a, 0x7a, 0x0a, 0x05, 0x49, 0x6e, 0x70, 0x75, 0x74, 0x12, 0x21, 0x0a, 0x0c, 0x6e, 0x61, 0x6d,
	0x65, 0x73, 0x70, 0x61, 0x63, 0x65, 0x5f, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x0b, 0x6e, 0x61, 0x6d, 0x65, 0x73, 0x70, 0x61, 0x63, 0x65, 0x49, 0x64, 0x12, 0x2f, 0x0a, 0x14,
	0x73, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x5f, 0x70, 0x6f, 0x72, 0x74, 0x5f, 0x74, 0x61, 0x67,
	0x5f, 0x6b, 0x65, 0x79, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x11, 0x73, 0x65, 0x72, 0x76,
	0x69, 0x63, 0x65, 0x50, 0x6f, 0x72, 0x74, 0x54, 0x61, 0x67, 0x4b, 0x65, 0x79, 0x12, 0x1d, 0x0a,
	0x0a, 0x6e, 0x65, 0x78, 0x74, 0x5f, 0x74, 0x6f, 0x6b, 0x65, 0x6e, 0x18, 0x03, 0x20, 0x01, 0x28,
	0x09, 0x52, 0x09, 0x6e, 0x65, 0x78, 0x74, 0x54, 0x6f, 0x6b, 0x65, 0x6e, 0x1a, 0x6d, 0x0a, 0x06,
	0x4f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x12, 0x44, 0x0a, 0x0d, 0x69, 0x6e, 0x73, 0x74, 0x61, 0x6e,
	0x63, 0x65, 0x5f, 0x73, 0x65, 0x74, 0x73, 0x18, 0x01, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x1f, 0x2e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x2e, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2e,
	0x76, 0x31, 0x2e, 0x49, 0x6e, 0x73, 0x74, 0x61, 0x6e, 0x63, 0x65, 0x53, 0x65, 0x74, 0x52, 0x0c,
	0x69, 0x6e, 0x73, 0x74, 0x61, 0x6e, 0x63, 0x65, 0x53, 0x65, 0x74, 0x73, 0x12, 0x1d, 0x0a, 0x0a,
	0x6e, 0x65, 0x78, 0x74, 0x5f, 0x74, 0x6f, 0x6b, 0x65, 0x6e, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x09, 0x6e, 0x65, 0x78, 0x74, 0x54, 0x6f, 0x6b, 0x65, 0x6e, 0x42, 0x89, 0x02, 0x0a, 0x1f,
	0x63, 0x6f, 0x6d, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x2e, 0x61, 0x77,
	0x73, 0x2e, 0x6e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x2e, 0x76, 0x31, 0x42,
	0x0d, 0x43, 0x6c, 0x6f, 0x75, 0x64, 0x4d, 0x61, 0x70, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x50, 0x01,
	0x5a, 0x48, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x70, 0x72, 0x6f,
	0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x2f, 0x61, 0x77, 0x73, 0x2d, 0x63, 0x6f, 0x6d, 0x70, 0x6f,
	0x6e, 0x65, 0x6e, 0x74, 0x73, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x2f, 0x61, 0x70, 0x69, 0x2f,
	0x6e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x2f, 0x76, 0x31, 0x3b, 0x6e, 0x65,
	0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x76, 0x31, 0xa2, 0x02, 0x03, 0x50, 0x41, 0x4e,
	0xaa, 0x02, 0x1b, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x2e, 0x41, 0x77, 0x73,
	0x2e, 0x4e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x2e, 0x56, 0x31, 0xca, 0x02,
	0x1b, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x5c, 0x41, 0x77, 0x73, 0x5c, 0x4e,
	0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x5c, 0x56, 0x31, 0xe2, 0x02, 0x27, 0x50,
	0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65, 0x73, 0x68, 0x5c, 0x41, 0x77, 0x73, 0x5c, 0x4e, 0x65, 0x74,
	0x77, 0x6f, 0x72, 0x6b, 0x69, 0x6e, 0x67, 0x5c, 0x56, 0x31, 0x5c, 0x47, 0x50, 0x42, 0x4d, 0x65,
	0x74, 0x61, 0x64, 0x61, 0x74, 0x61, 0xea, 0x02, 0x1e, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x6d, 0x65,
	0x73, 0x68, 0x3a, 0x3a, 0x41, 0x77, 0x73, 0x3a, 0x3a, 0x4e, 0x65, 0x74, 0x77, 0x6f, 0x72, 0x6b,
	0x69, 0x6e, 0x67, 0x3a, 0x3a, 0x56, 0x31, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_api_networking_v1_cloud_map_proto_rawDescOnce sync.Once
	file_api_networking_v1_cloud_map_proto_rawDescData = file_api_networking_v1_cloud_map_proto_rawDesc
)

func file_api_networking_v1_cloud_map_proto_rawDescGZIP() []byte {
	file_api_networking_v1_cloud_map_proto_rawDescOnce.Do(func() {
		file_api_networking_v1_cloud_map_proto_rawDescData = protoimpl.X.CompressGZIP(file_api_networking_v1_cloud_map_proto_rawDescData)
	})
	return file_api_networking_v1_cloud_map_proto_rawDescData
}

var file_api_networking_v1_cloud_map_proto_msgTypes = make([]protoimpl.MessageInfo, 3)
var file_api_networking_v1_cloud_map_proto_goTypes = []interface{}{
	(*ListInstanceSetsFromCloudMap)(nil),        // 0: protomesh.aws.networking.v1.ListInstanceSetsFromCloudMap
	(*ListInstanceSetsFromCloudMap_Input)(nil),  // 1: protomesh.aws.networking.v1.ListInstanceSetsFromCloudMap.Input
	(*ListInstanceSetsFromCloudMap_Output)(nil), // 2: protomesh.aws.networking.v1.ListInstanceSetsFromCloudMap.Output
	(*v1.InstanceSet)(nil),                      // 3: protomesh.types.v1.InstanceSet
}
var file_api_networking_v1_cloud_map_proto_depIdxs = []int32{
	3, // 0: protomesh.aws.networking.v1.ListInstanceSetsFromCloudMap.Output.instance_sets:type_name -> protomesh.types.v1.InstanceSet
	1, // [1:1] is the sub-list for method output_type
	1, // [1:1] is the sub-list for method input_type
	1, // [1:1] is the sub-list for extension type_name
	1, // [1:1] is the sub-list for extension extendee
	0, // [0:1] is the sub-list for field type_name
}

func init() { file_api_networking_v1_cloud_map_proto_init() }
func file_api_networking_v1_cloud_map_proto_init() {
	if File_api_networking_v1_cloud_map_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_api_networking_v1_cloud_map_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ListInstanceSetsFromCloudMap); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_networking_v1_cloud_map_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ListInstanceSetsFromCloudMap_Input); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_networking_v1_cloud_map_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ListInstanceSetsFromCloudMap_Output); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_api_networking_v1_cloud_map_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   3,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_api_networking_v1_cloud_map_proto_goTypes,
		DependencyIndexes: file_api_networking_v1_cloud_map_proto_depIdxs,
		MessageInfos:      file_api_networking_v1_cloud_map_proto_msgTypes,
	}.Build()
	File_api_networking_v1_cloud_map_proto = out.File
	file_api_networking_v1_cloud_map_proto_rawDesc = nil
	file_api_networking_v1_cloud_map_proto_goTypes = nil
	file_api_networking_v1_cloud_map_proto_depIdxs = nil
}