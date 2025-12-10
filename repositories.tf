module "repository" {
  source  = "mineiros-io/repository/github"
  version = "0.18.0"

  for_each = module.projects

  name       = each.value.project.name
  visibility = "public"
  template = {
    owner      = "sentania-labs"
    repository = "vcf-lab-application-template"
  }

  plaintext_secrets = {
    VCFA_PROJECT_NAME      = replace(each.value.project.name, " ", "_")
    VCFA_PROJECT_ID        = each.value.project.id
    VCFA_ORGANIZATION_NAME = var.vcfa_organization
  }
}