# Authenticate the Vercel provider outside Terraform/Terragrunt:
#   PowerShell: $env:VERCEL_API_TOKEN = "<token>"
#   CI: store VERCEL_API_TOKEN in the CI secret store.
# For a team project, also set VERCEL_TEAM_ID to the team ID or slug.
# Vercel's GitHub App must be installed on the GitHub repository. For a
# private repository, grant that App access to this repository in GitHub.
terraform {
  source = "${get_repo_root()}/terraform/vercel/modules/github-project"
}

inputs = {
  project_name = "example-frontend"

  # Optional: defaults to "nextjs" when omitted.
  framework = "nextjs"

  github_repo = "example-org/example-frontend"

  # Optional: defaults to an empty map when omitted. Do not put secrets in
  # this example; use CI secrets or environment variables instead. For example,
  # in GitHub Actions:
  #   env:
  #     VERCEL_API_TOKEN: ${{ secrets.VERCEL_API_TOKEN }}
  #     API_URL: ${{ vars.API_URL }}
  #   steps:
  #     - run: terragrunt apply
  environment_variables = {
    NEXT_PUBLIC_API_URL = get_env("API_URL", "https://api.example.com")
  }

  # Optional: set to null to use the default vercel.app URL.
  custom_domain = "app.example.com"
}
