package main

import (
	"bytes"
	"log"
	"time"

	"github.com/aliyun/aliyun-oss-go-sdk/oss"
)

func main() {
	client, err := oss.New("yourEndpoint", "yourAccessKeyId", "yourAccessKeySecret")
	if err != nil {
		log.Fatalf("Error: %v", err)
	}

	bucketName := "example_bucket"
	bucket, err := client.Bucket(bucketName)
	if err != nil {
		log.Fatalf("Error: %v", err)
	}

	objectName := "example_object.txt"
	expires := time.Date(2049, time.January, 10, 23, 0, 0, 0, time.UTC)
	objectOptions := []oss.Option{
		oss.MetadataDirective(oss.MetaReplace),
		oss.Expires(expires),
		// 指定该Object被下载时的网页缓存行为。
		// oss.CacheControl("no-cache"),
		// 指定该Object被下载时的名称。
		// oss.ContentDisposition("attachment;filename=FileName.txt"),
		// 指定该Object的内容编码格式。
		// oss.ContentEncoding("gzip"),
		// 指定对返回的Key进行编码，目前支持URL编码。
		// oss.EncodingType("url"),
		// 指定Object的存储类型。
		// oss.ObjectStorageClass(oss.StorageStandard),
	}
	objectAcl := oss.ObjectACL(oss.ACLPublicRead)

	// 步骤1：初始化一个分片上传事件，并指定存储类型为标准存储。
	initiateUpload, _ := bucket.InitiateMultipartUpload(objectName, objectOptions...)

	// 步骤2：上传分片。

	chunks := [][]byte{
		[]byte("test multiple upload, "),
		[]byte("via bytes reader, "),
		[]byte("with array of bytes array"),
	}

	var parts []oss.UploadPart
	for index, chunk := range chunks {
		part, err := bucket.UploadPart(initiateUpload, bytes.NewReader(chunk), int64(len(chunk)), index)
		if err != nil {
			log.Fatalf("Error: %v", err)
		}
		parts = append(parts, part)
	}

	// 步骤3：完成分片上传，指定文件读写权限为公共读。
	completeUpload, err := bucket.CompleteMultipartUpload(initiateUpload, parts, objectAcl)
	if err != nil {
		log.Fatalf("Error: %v", err)
	}

	log.Printf("completed: %v", completeUpload)
}
