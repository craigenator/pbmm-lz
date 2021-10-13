## Copyright 2019 Google LLC

# Copyright 2021 Google LLC. This software is provided as is, without
# warranty or representation for any use or purpose. Your use of it is
# subject to your agreement with Google.

## Publishes multiple messages to a Pub/Sub topic with an error handler.

## Function name:  bq-table-stream-update

import sys
from concurrent import futures
from google.cloud import storage
from google.cloud import pubsub_v1

def ps_post(event, context):
    ## Developer TODO: update values
    project_id = "project_id"
    topic_id = "topic_id"
    publish_messages(project_id, topic_id, event)

def publish_messages(project_id: str, topic_id: str, event) -> None:
    
    # Configure the batch to publish as soon as there are 10 messages
    # or 1 KiB of data, or 1 second has passed.
    batch_settings = pubsub_v1.types.BatchSettings(
        max_messages=100,  # default 100
        max_bytes=1024,  # default 1 MiB
        max_latency=10,  # default 10 ms
    )

    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project_id, topic_id)     # creates a fully qualified identifier - projects/project_id/topics/topic_id
    publish_futures = []
    messages = []

    object_blob = download_storage_object(event['bucket'], event['name'])

    with object_blob.open("rt") as f:
        blob_data = f.read()
    
    messages = blob_data.splitlines()

    for message in messages:
        if len(message) > 0:
            data = message.encode("utf-8")                              # Data must be a bytestring
            publish_future = publisher.publish(topic_path, data)        # When you publish a message, the client returns a future.
            publish_future.add_done_callback(callback)                  # Non-blocking. Allow the publisher client to batch multiple messages.
            publish_futures.append(publish_future)

    futures.wait(publish_futures, return_when=futures.ALL_COMPLETED)
    print(f"Published messages to {topic_path}.")

# Get object blob of uploaded file to cloud storage bucket
def download_storage_object(bucket_name, source_blob_name):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    return blob

# Resolve the publish future in a separate thread.
def callback(future: pubsub_v1.publisher.futures.Future) -> None:
    message_id = future.result()
    print(message_id)