output "project_id" {
  description = "ID of the Vercel project."
  value       = vercel_project.this.id
}

output "project_name" {
  description = "Name of the Vercel project."
  value       = vercel_project.this.name
}

output "live_url" {
  description = "Primary URL for the deployed project."
  value       = var.custom_domain != null ? "https://${var.custom_domain}" : "https://${var.project_name}.vercel.app"
}

output "custom_domain" {
  description = "Configured custom domain, or null when no custom domain was requested."
  value       = var.custom_domain
}
