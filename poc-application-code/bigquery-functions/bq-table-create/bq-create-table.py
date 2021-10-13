## Copyright 2019 Google LLC

# Copyright 2021 Google LLC. This software is provided as is, without
# warranty or representation for any use or purpose. Your use of it is
# subject to your agreement with Google.

## Function name:  bq-create-table

import sys
from google.cloud import bigquery

def bq_create_table(event, context):

    ## Developer TODO: update values
    table_id = "project_id.dataset_id.table_name"
    client = bigquery.Client()

    schema = [
        bigquery.SchemaField("STATION", "STRING"),
        bigquery.SchemaField("STATION_NAME", "STRING"),
        bigquery.SchemaField("ELEVATION", "FLOAT"),
        bigquery.SchemaField("LATITUDE", "FLOAT"),
        bigquery.SchemaField("LONGITUDE", "FLOAT"),
        bigquery.SchemaField("DATE", "STRING"),
        bigquery.SchemaField("HLY_TEMP_NORMAL", "INTEGER"),
        bigquery.SchemaField("HLY_PRES_NORMAL", "INTEGER"),
        bigquery.SchemaField("HLY_DEWP_NORMAL", "INTEGER"),
    ]

    table = bigquery.Table(table_id, schema=schema)
    table = client.create_table(table)  # Make an API request.
    print(
        "Created table {}.{}.{}".format(table.project, table.dataset_id, table.table_id)
    )