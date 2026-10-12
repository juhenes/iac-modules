output "project_name" {
  description = "Name of the Cloudflare Pages project."
  value       = cloudflare_pages_project.this.name
}

output "project_id" {
  description = "ID of the Cloudflare Pages project."
  value       = cloudflare_pages_project.this.id
}

output "live_url" {
  description = "Primary URL for the deployed project."
  value       = var.custom_domain != null ? "https://${var.custom_domain}" : "https://${var.project_name}.pages.dev"
}

output "custom_domain" {
  description = "Configured custom domain, or null when no custom domain was requested."
  value       = var.custom_domain
}
