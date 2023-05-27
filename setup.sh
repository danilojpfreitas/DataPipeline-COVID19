#!/usr/bin/env bash

install() {
    echo "Azure Terraform"
    cd Azure-Terraform
    Terraform init
    Terraform plan

    echo "Install Airbyte..."
    git clone -b modern-data-stack https://github.com/danilojpfreitas/airbyte.git
    cd airbyte
    ./run-ab-platform.sh
    cd ..

    echo "Install Airflow..."
    mkdir airflow
    cd airflow
    curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.6.1/docker-compose.yaml'
    mkdir -p ./dags ./logs ./plugins ./config
    echo -e "AIRFLOW_UID=$(id -u)" > .env
    docker-compose up airflow-init
    docker compose up
    wget https://raw.githubusercontent.com/danilojpfreitas/DataPipeline-airbyte-dbt-airflow-snowflake-metabase/main/airflow/.gitignore
    cd ..

    echo "Install Metabase..."
    mkdir metabase
    cd metabase
    wget https://raw.githubusercontent.com/danilojpfreitas/DataPipeline-airbyte-dbt-airflow-snowflake-metabase/main/metabase/docker-compose.yaml
    docker-compose up
    cd ..

    echo "Access Airbyte at http://localhost:8000 and set up the connections."
  
    echo "Access Airflow at http://localhost:8080 to kick off your Airbyte sync DAG."  

    echo "Access Metabase at http://localhost:3000 and set up a connection with Snowflake."
}
