terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = ">= 1.0, < 2.0"
    }
  }
}

resource "vercel_project" "this" {
  name      = var.project_name
  framework = var.framework

  git_repository = {
    type = "github"
    repo = var.github_repo
  }

  environment = [
    for key, value in var.environment_variables : {
      key    = key
      value  = value
      target = ["production", "preview", "development"]
    }
  ]
}

resource "vercel_project_domain" "this" {
  count = var.custom_domain == null ? 0 : 1

  project_id = vercel_project.this.id
  domain     = var.custom_domain
}
