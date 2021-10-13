## Copyright 2019 Google LLC

# Copyright 2021 Google LLC. This software is provided as is, without
# warranty or representation for any use or purpose. Your use of it is
# subject to your agreement with Google.

## Function name: bq-table-batch-update

import sys
import base64
from google.cloud import bigquery

def batch_update(event, context):

    ## Developer TODO: update values format: project_id.dataset_name.table_name
    table_id = "table_id"

    if 'data' in event:
        uri = base64.b64decode(event['data']).decode('utf-8')
    else:
        print("Invalid or no bucket uri passed. Please post to topic with a valid object uri.")
        return

    job_config = bigquery.LoadJobConfig(
        schema=[
            bigquery.SchemaField("STATION", "STRING"),
            bigquery.SchemaField("STATION_NAME", "STRING"),
            bigquery.SchemaField("ELEVATION", "FLOAT"),
            bigquery.SchemaField("LATITUDE", "FLOAT"),
            bigquery.SchemaField("LONGITUDE", "FLOAT"),
            bigquery.SchemaField("DATE", "STRING"),
            bigquery.SchemaField("HLY_TEMP_NORMAL", "INTEGER"),
            bigquery.SchemaField("HLY_PRES_NORMAL", "INTEGER"),
            bigquery.SchemaField("HLY_DEWP_NORMAL", "INTEGER"),
        ],
        source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON,
    )

    client = bigquery.Client()    # Construct a BigQuery client object.

    load_job = client.load_table_from_uri(
        uri,
        table_id,
        location="northamerica-northeast1",  # Must match the destination dataset location.
        job_config=job_config,
    )  # Make an API request.

    load_job.result()  # Waits for the job to complete.

    destination_table = client.get_table(table_id)
    print("Loaded {} rows.".format(destination_table.num_rows))