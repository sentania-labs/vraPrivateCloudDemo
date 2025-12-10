locals {
  repo_defs = {
    for k, p in module.projects :
    k => {
      project_name = p.project_name
      project_id   = p.id

      project_slug = trim(
        regexreplace(
          lower(p.project_name),
          "[^a-z0-9]+",
          "-"
        ),
        "-"
      )

      project_id_short = substr(p.id, 0, 12)

      project_key = format(
        "%s__%s",
        trim(
          regexreplace(
            lower(p.project_name),
            "[^a-z0-9]+",
            "-"
          ),
          "-"
        ),
        substr(p.id, 0, 12)
      )
    }
  }
}


module "repository" {
  source  = "mineiros-io/repository/github"
  version = "0.18.0"

  for_each = local.repo_defs

  name       = each.value.project_key
  visibility = "public"
  template = {
    owner      = "sentania-labs"
    repository = "vcf-lab-application-template"
  }

  plaintext_secrets = {
    VCFA_PROJECT_NAME      = each.value.project_name
    VCFA_PROJECT_KEY       = each.value.project_key
    VCFA_PROJECT_ID        = each.value.id
    VCFA_ORGANIZATION_NAME = var.vcfa_organization
  }
}