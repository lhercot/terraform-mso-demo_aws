output "subnet_dn" {
  value = "uni/tn-${var.tenant}/ctxprofile-${var.name_prefix}Hybrid_Cloud_VRF-us-west-1/cidr-[10.101.110.0/24]/subnet-[10.101.110.128/25]"
  description = "The ACI subnet object DN"
}

output "region" {
  value = "us-west-1"
  description = "The AWS region"
}

output "aws_site_id" {
  value = data.mso_site.aws.id
  description = "The id of the AWS Site"
}