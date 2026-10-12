# Authenticate the Cloudflare provider outside Terraform/Terragrunt:
#   PowerShell: $env:CLOUDFLARE_API_TOKEN = "<token>"
#   CI: store CLOUDFLARE_API_TOKEN in the CI secret store.
# The token should have Account Pages edit permissions (and the required
# zone permissions when managing domains). Cloudflare's GitHub App/OAuth
# connection must be authorized for the repository; grant it private-repo
# access in Cloudflare/GitHub rather than storing a GitHub token here.
terraform {
  source = "${get_repo_root()}/terraform/cloudflare/modules/github-pages"
}

inputs = {
  account_id = "00000000000000000000000000000000"

  project_name = "example-frontend"

  # Optional: defaults to "main" when omitted.
  production_branch = "main"

  build_command = "npm run build"

  build_directory = "dist"

  github_owner = "example-org"

  github_repo_name = "example-frontend"

  # Optional: set to null to use the default pages.dev URL.
  custom_domain = "app.example.com"
}
