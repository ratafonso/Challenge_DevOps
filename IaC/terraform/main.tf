terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

locals {
    env       = terraform.workspace == "Default" ? "PROD" : upper(element(split("-", terraform.workspace), 0))
    namespace = lower(local.env)
    short_env = substr(local.namespace,0,1,2)
    workload_sla = local.env == "PROD" ? "gold" : "bronze"
    schedule = local.env == "PROD" ? "24x7" : "8x5"
    common_tags = {
        workload_name = "letscodebyada"
        environment = local.namespace
        cost_center = "0000000001"
        business_unit = "ada"
        application_owner = "Isabella Bahu"
        service_offering = "LETSCODEBYADA-${local.env}"
        security_tier = "sec_tier_1"
        backup_policy = "prod"
        workload_sla = local.workload_sla
        dr_rpo_rto = "na"
        tag_policy_version = "1.0"
        schedule = local.schedule
        timezone = "utc"
        patch_group = "tbd"
        maintenance_window = "prod"
        deploy_mode = "automated"
        deployed_by = "terraform"
        deploy_repo = "github.com/ratafonso/Challenge_DevOps"
        service_status = "self_managed"
        end_date = "never"
    }
}