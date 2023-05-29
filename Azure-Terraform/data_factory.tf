resource "azurerm_data_factory" "vacinacao" {
  name                = "vacinacaodatafactory"
  location            = azurerm_resource_group.vacinacao.location
  resource_group_name = azurerm_resource_group.vacinacao.name

    tags = {
    environment = var.environment
  }
}

# Connection HTTP Server to Data Factory
resource "azurerm_data_factory_linked_custom_service" "Data01" {
  name                = "Data01"
  data_factory_id = azurerm_data_factory.vacinacao.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
    "url": "https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SIPNI/COVID/uf/uf%3DAL/part-00000-a1ee0c9b-ec60-4d91-8c80-c4dc3014b27c.c000.csv",
    "enableServerCertificateValidation": false,

    "authenticationType": "Anonymous"
}
JSON

  annotations = []

}

resource "azurerm_data_factory_linked_custom_service" "Data02" {
  name                = "Data02"
  data_factory_id = azurerm_data_factory.vacinacao.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
    "url": "https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SIPNI/COVID/uf/uf%3DAL/part-00001-a1ee0c9b-ec60-4d91-8c80-c4dc3014b27c.c000.csv",
    "enableServerCertificateValidation": false,

    "authenticationType": "Anonymous"
}
JSON

  annotations = []

}

resource "azurerm_data_factory_linked_custom_service" "Data03" {
  name                = "Data03"
  data_factory_id = azurerm_data_factory.vacinacao.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
    "url": "https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SIPNI/COVID/uf/uf%3DAL/part-00002-a1ee0c9b-ec60-4d91-8c80-c4dc3014b27c.c000.csv",
    "enableServerCertificateValidation": false,

    "authenticationType": "Anonymous"
}
JSON

  annotations = []

}

resource "azurerm_data_factory_linked_custom_service" "Data04" {
  name                = "Data04"
  data_factory_id = azurerm_data_factory.vacinacao.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
    "url": "https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SIPNI/COVID/uf/uf%3DAL/part-00003-a1ee0c9b-ec60-4d91-8c80-c4dc3014b27c.c000.csv",
    "enableServerCertificateValidation": false,

    "authenticationType": "Anonymous"
}
JSON

  annotations = []

}

resource "azurerm_data_factory_linked_custom_service" "Data05" {
  name                = "Data05"
  data_factory_id = azurerm_data_factory.vacinacao.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
    "url": "https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SIPNI/COVID/uf/uf%3DAL/part-00004-a1ee0c9b-ec60-4d91-8c80-c4dc3014b27c.c000.csv",
    "enableServerCertificateValidation": false,

    "authenticationType": "Anonymous"
}
JSON

  annotations = []

}

resource "azurerm_data_factory_dataset_http" "vacinacao" {
  count = length(var.data_factory_linked_name)
  name                = var.data_factory_linked_name[count.index]
  data_factory_id     = azurerm_data_factory.vacinacao.id
  linked_service_name = var.data_factory_linked_name[count.index]
  depends_on = [ azurerm_data_factory_linked_custom_service.Data05 ]
  
  request_method = "GET"
}

# Connection Data Lake Gen 2 to Data Factory
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "vacinacao" {
  name                  = "DataLakeLanding"
  data_factory_id       = azurerm_data_factory.vacinacao.id
  url                   = var.storage_account_url
  storage_account_key   = var.storage_account_key
}