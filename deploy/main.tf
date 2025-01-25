provider "azurerm" {
  subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}

variable "python_version" {
  default = "3.12"
}

variable "app_name" {
  default = "demo-fastapi-app"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-rg"
  location = "Central India"
}

resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      python_version = var.python_version
    }
    always_on = false
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "WEBSITES_PORT"                  = "8000"
    "STARTUP_COMMAND"                = "python -m uvicorn main:app --host 0.0.0.0"
  }
}

resource "azurerm_app_service_source_control" "github" {
  app_id                 = azurerm_linux_web_app.main.id
  repo_url               = "https://github.com/devcrypted/demo-fastapi.git"
  branch                 = "main"
  use_manual_integration = true
}

output "app_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "api_docs_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}/docs"
}
