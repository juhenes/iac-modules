variable "account_id" {
  description = "Cloudflare account ID that owns the Pages project."
  type        = string
}

variable "project_name" {
  description = "Name of the Cloudflare Pages project."
  type        = string
}

variable "production_branch" {
  description = "GitHub branch used for production deployments."
  type        = string
  default     = "main"
}

variable "build_command" {
  description = "Command Cloudflare Pages runs to build the application."
  type        = string
}

variable "build_directory" {
  description = "Directory containing the built frontend assets."
  type        = string
}

variable "github_owner" {
  description = "GitHub organization or user that owns the repository."
  type        = string
}

variable "github_repo_name" {
  description = "Name of the GitHub repository connected to Cloudflare Pages."
  type        = string
}

variable "custom_domain" {
  description = "Optional custom domain to attach to the Pages project."
  type        = string
  default     = null
  nullable    = true
}
