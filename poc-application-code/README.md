# gcp-poc-application-code
This repo holds code code the 3 tier application and the BigQuery-DataFlow design patterns for log ingestion and query.

## Prerequisites & Notes

### Region
Use ```northamerica-northeast1``` for all services and configuratioons.

### Google Cloud APIs

Enable the following services 
```
logging.googleapis.com
dns.googleapis.com
cloudbuild.googleapis.com
dataflow.googleapis.com
cloudfunctions.googleapis.com
compute.googleapis.com
pubsub.googleapis.com
bigquery.googleapis.com
servicenetworking.googleapis.com
sqladmin.googleapis.com
```

## 3-Tier Application

### Setup Steps

#### **Database Step**

Provision the SQL instance as a private instance, then sue the following scripts.

#### **SQL Table Schema**
```
create table customers (
    id int PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(50) not null, 
    address VARCHAR(250) not null
);
```
#### **SQL Table Data**
```
insert into customers (name, address) values ('Winston Churchill','10 Downing London');
insert into customers (name, address) values ('Karl Shilton','SW1A 1AA London ');
insert into customers (name, address) values ('Tony Stark','10880 Malibu Point');
insert into customers (name, address) values ('Steve Rogers','569 Leaman Place');
insert into customers (name, address) values ('Barry Allen','2036 W 13th Ave');
```

#### **Application Setup Prerequisite:**

Create images ```fe-image-1``` & ```app-image-1```.
* Follow the bootstrapsh scripts and setup VM instances for FE and APP respectively.
* Use the VM disks to create the images and nam them appropriately.  

#### **Application Step**

1. use the ```fe-image-1``` and ```app-image-1``` to create ```fe-instance-template-1``` and ```app-instance-template-1```
2. use the templates to create respective instance groups ```fe-instance-group-1``` and ```app-instance-group-1```
    a) validate the corresponding VM instances are provisioned on successful setup of the instance groups 
3. create TCP Internal load balancer - ```fe-nlb``` and ```app-nlb```
    a) use the instance groups created in step 2 for the respective load balancer backends
    b) use the corresponding subnets and port ```80``` to configure the load balancer frontends
4. SSH into the VM ```app-instance-***```; as root, and edit the ```readfromcloudsql.py``` to update the SQL DB instance pribate IP, as root.
5. Start the middletier service by executing
```
python3 readfromcloudsql.py
```
5. SSH into the VM ```fe-instance-***```; as root, edit the ```/var/www/html/index.html``` to updet the private IP of the ```app-nlb``` in the "fetch".



## BigQuery solution

### Stream data upload to BigQuery table

#### **Setup Steps**
1. create 2 storage buckets - ```log-data-sink-bucket``` & ```bq-dataflow-temp``` 
2. create 2 topics - ```cloudfunction-trigger``` & ```ps-to-bq-dataflow```
3. create 1 BigQuery dataset - ```log_processing_dataset```
4. deploy cloud function ```create-bq-table``` with pub/sub tigger to ```cloudfunction-trigger```
5. trigger create-bq-table function to create 1 BigQuery table - ```temp_data_table_1```
6. deploy cloud function ```bq-table-ps-stream-update``` with storage trigger from ```log-data-sink-bucket```
7. create subscription of type ```Export To BigQuery``` for topic - ```ps-to-bq-dataflow``` and confirm subscription creation

#### **Validation**
1. upload new data file to storage bucket
2. validate stream function is triggerred
3. validate row count increment in BigQuery table update through ```SELECT count(1) from [table_id] ``` 

### Batch data upload to BigQuery table

#### **Setup Steps**
1. create 1 storage bucket - ```log-data-sink-bucket``` 
2. create 1 topics - ```cloudfunction-trigger```
3. deploy cloud function ```create-bq-table``` with pub/sub tigger to ```cloudfunction-trigger```
4. trigger create-bq-table function to create 1 BigQuery table - ```temp_data_table_1```
5. deploy cloud function ```bq-table-batch-update``` with topic trigger from ```cloudfunction-trigger```

#### **Validation**
1. upload new data file to storage bucket
2. post new message to ```cloudfunction-trigger``` with the uri of the uploaded object
3. validate ```bq-table-batch-update``` function is triggerred for execution
4. validate row count increment in BigQuery table update through ```SELECT count(1) from [table_id] ```
