resource "azuredevops_project" "platform" {
  name               = "platform"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Basic"
}

resource "azuredevops_build_definition" "feature_flag_service" {
  project_id = azuredevops_project.platform.id
  name       = "lsuthar-coder.platform-feature-flag-service"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = "lsuthar-coder/platform-feature-flag-service"
    branch_name           = "main"
    yml_path              = "azure-pipelines.yml"
    service_connection_id = var.azure_github_service_connection_id
  }
}

resource "azuredevops_build_definition" "auth_service" {
  project_id = azuredevops_project.platform.id
  name       = "lsuthar-coder.platform-auth-service"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = "lsuthar-coder/platform-auth-service"
    branch_name           = "main"
    yml_path              = "azure-pipelines.yml"
    service_connection_id = var.azure_github_service_connection_id
  }
}

resource "azuredevops_build_definition" "api_gateway" {
  project_id = azuredevops_project.platform.id
  name       = "lsuthar-coder.platform-api-gateway"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = "lsuthar-coder/platform-api-gateway"
    branch_name           = "main"
    yml_path              = "azure-pipelines.yml"
    service_connection_id = var.azure_github_service_connection_id
  }
}
