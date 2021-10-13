## Copyright 2019 Google LLC

# Copyright 2021 Google LLC. This software is provided as is, without
# warranty or representation for any use or purpose. Your use of it is
# subject to your agreement with Google.

## Function name:  bq-table-read

import sys
from google.cloud import bigquery

def log_bucket_trigger(event, context):

    ## Developer TODO: update values
    dataset_id = "project_id.dataset_name"
    table_id = "project_id.dataset_name.table_name"

    client = bigquery.Client()    # Construct a BigQuery client object.
    dataset = bigquery.Dataset(dataset_id)    # Construct a full Dataset object to send to the API.

    ### Download all rows from a table.
    rows_iter = client.list_rows(table_id)  # Make an API request.

    # Iterate over rows to make the API requests to fetch row data.
    rows = list(rows_iter)
    print("Downloaded {} rows from table {}".format(len(rows), table_id))

    rows_iter = client.list_rows(table_id, max_results=10)    # Download at most 10 rows.
    rows = list(rows_iter)
    print("Downloaded {} rows from table {}".format(len(rows), table_id))
    