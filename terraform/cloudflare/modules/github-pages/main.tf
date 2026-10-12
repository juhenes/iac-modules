terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.0, < 5.0"
    }
  }
}

resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = var.production_branch

  source {
    type = "github"

    config {
      owner             = var.github_owner
      repo_name         = var.github_repo_name
      production_branch = var.production_branch
    }
  }

  build_config {
    build_command   = var.build_command
    destination_dir = var.build_directory
  }
}

resource "cloudflare_pages_domain" "this" {
  count = var.custom_domain == null ? 0 : 1

  account_id   = var.account_id
  project_name = cloudflare_pages_project.this.name
  domain       = var.custom_domain
}
