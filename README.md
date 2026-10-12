# IaC Modules

Reusable infrastructure-as-code modules for Terraform and Terragrunt. Modules
can provision cloud services, networking, security, data platforms,
application platforms, and other infrastructure.

## Repository layout

```text
examples/
  <terragrunt-example>/
    terragrunt.hcl
terraform/
  <provider>/
    modules/
      <module>/
        main.tf
        variables.tf
        outputs.tf
```

Provider and module names are placeholders. Add new modules under the
corresponding provider directory and add a Terragrunt example when a module is
intended for Terragrunt consumption.

## Prerequisites

- Terraform
- Terragrunt when using the Terragrunt examples
- The accounts and services required by the module being used
- Credentials with the minimum permissions required by each provider

Each module owns its provider constraints. Review the module's Terraform files
before use to identify the required provider versions and Terraform version.

## Authentication

Provider credentials must be supplied outside Terraform configuration. Do not
put API tokens in Terragrunt configuration, Terraform variables, committed
`.tfvars` files, or source code.

Set the environment variables expected by the provider before running
Terraform or Terragrunt. Provider-specific authentication requirements should
be documented alongside the relevant module or Terragrunt example.

In CI, configure credentials as masked or secret environment variables.

## Private source repositories

When a module integrates with a source-control repository, repository access is
normally authorized through the target platform's source-control integration.
The module should receive repository metadata, not long-lived personal access
tokens.

Before applying an integration module:

1. Authorize the platform's GitHub App, OAuth integration, or equivalent.
2. Grant the integration access to the required private repository.
3. Provide repository metadata using the input format documented by the module.

## Use a module with Terragrunt

Each module should document its inputs, outputs, provider requirements, and
authentication expectations. Review the relevant module and example before
running commands.

Run Terragrunt from the repository root by selecting an example with
`--working-dir`:

```text
terragrunt --working-dir examples/<terragrunt-example> init
terragrunt --working-dir examples/<terragrunt-example> plan
terragrunt --working-dir examples/<terragrunt-example> apply
```

Use `destroy` only when the target infrastructure is intentionally being
removed:

```text
terragrunt --working-dir examples/<terragrunt-example> destroy
```

## Validate modules

Run formatting and validation from the repository root:

```text
terraform fmt -check -recursive
terraform -chdir=terraform/<provider>/modules/<module> init -backend=false
terraform -chdir=terraform/<provider>/modules/<module> validate
```

For all modules, repeat the `terraform -chdir` commands for each module
directory. Terragrunt configurations can also be validated with:

```text
terragrunt --working-dir examples/<terragrunt-example> validate
```

## Module contracts

Inputs and outputs are module-specific. Consult each module's
`variables.tf` and `outputs.tf` rather than assuming that all modules expose
the same values.

Modules should:

- Expose clear, typed inputs with useful descriptions and safe defaults.
- Expose stable identifiers, endpoints, and values needed by consumers.
- Keep provider-specific implementation details inside the module.
- Make destructive or optional behavior explicit through inputs.
- Document authentication, prerequisites, and any external setup.

## Repository conventions

- Keep each module focused on one infrastructure capability.
- Keep provider credentials outside source-controlled configuration.
- Pin provider versions and commit lock files for reproducible provider
  selection.
- Add or update a Terragrunt example when introducing a module intended for
  Terragrunt consumption.
- Run formatting and validation before opening a pull request.

Never commit `.terraform/` directories, state files, plan files, or provider
credentials. Terraform provider lock files named `.terraform.lock.hcl` should
be committed.

## Continuous integration

The GitHub Actions workflow in `.github/workflows/ci.yml` runs on pull requests
targeting `main` and checks:

- Terraform formatting, initialization, and validation for every module.
- Terragrunt formatting for every example.

When a pull request is merged into `main`, the workflow creates an annotated
tag using the format `v0.1.<run-number>`. Update the tag format in the workflow
if the repository adopts a different release or versioning strategy.
