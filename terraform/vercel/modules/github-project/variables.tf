variable "project_name" {
  description = "Name of the Vercel project."
  type        = string
}

variable "framework" {
  description = "Framework used by the project, as recognized by Vercel."
  type        = string
  default     = "nextjs"
}

variable "github_repo" {
  description = "GitHub repository in owner/repository format."
  type        = string
}

variable "environment_variables" {
  description = "Environment variables to configure for production, preview, and development deployments."
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "custom_domain" {
  description = "Optional custom domain to attach to the Vercel project."
  type        = string
  default     = null
  nullable    = true
}
