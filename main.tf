data "mso_tenant" "wos" {
  name = var.tenant
  display_name = var.tenant
}

data "mso_site" "aws" {
  name  = var.site_name
}

data "mso_schema" "hybrid_cloud" {
  name          = var.schema_name
}

resource "mso_rest" "aws_site" {
  path = "api/v1/schemas/${data.mso_schema.hybrid_cloud.id}"
  method = "PATCH"
  payload = <<EOF
[
  {
    "op": "add",
    "path": "/sites/-",
    "value": {
      "siteId": "${data.mso_site.aws.id}",
      "templateName": "Template1",
      "contracts": [
        {
          "contractRef": {
            "schemaId": "${data.mso_schema.hybrid_cloud.id}",
            "templateName": "Template1",
            "contractName": "${var.name_prefix}Internet-to-Web"
          }
        },{
          "contractRef": {
            "schemaId": "${data.mso_schema.hybrid_cloud.id}",
            "templateName": "Template1",
            "contractName": "${var.name_prefix}Web-to-DB"
          }
        },{
          "contractRef": {
            "schemaId": "${data.mso_schema.hybrid_cloud.id}",
            "templateName": "Template1",
            "contractName": "${var.name_prefix}VMs-to-Internet"
          }
        }
      ],
      "vrfs": [{
        "vrfRef": {
          "schemaId": "${data.mso_schema.hybrid_cloud.id}",
          "templateName": "Template1",
          "vrfName": "${var.name_prefix}Hybrid_Cloud_VRF"
        },
        "regions": [{
          "name": "us-west-1",
          "cidrs": [{
            "ip": "10.101.110.0/24",
            "primary": true,
            "subnets": [{
              "ip": "10.101.110.0/25",
              "zone": "us-west-1a",
              "name": "",
              "usage": "gateway"
            }, {
              "ip": "10.101.110.128/25",
              "zone": "us-west-1b",
              "name": "",
              "usage": "gateway"
            }],
            "associatedRegion": "us-west-1"
          }],
          "isVpnGatewayRouter": true,
          "isTGWAttachment": true,
          "cloudRsCtxProfileToGatewayRouterP": {
            "name": "WoS",
            "tenantName": "infra"
          },
          "hubnetworkPeering": false
        }]
      }],
      "intersiteL3outs": null
    }
  }
]
EOF

}