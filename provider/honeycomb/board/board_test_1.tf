##################################################################################
# PROVIDERS
##################################################################################

terraform {
  required_providers {
    honeycombio = {
      source = "honeycombio/honeycombio"
    }
  }
}

locals {
  dataset = "metrics-staging"
  board_name = "[nlanatta-test] Testing"
  board_description = "AVG of all requests for the last 2 hrs."
  query_name = "AVG Requests"
}

##################################################################################
# DATA
##################################################################################

data "honeycombio_query_specification" "query" {
  time_range  = 2 * 60 * 60 # 2 hours
  calculation {
    op     = "AVG"
    column = "cool.column.name"
  }
  filter {
    column = "component"
    op = "="
    value = "componentName"
  }
}

##################################################################################
# RESOURCES
##################################################################################

resource "honeycombio_query_annotation" "avg_request_annotation" {
  dataset    = local.dataset
  query_id  = honeycombio_query.avg_request_query.id
  name      = local.query_name
}

resource "honeycombio_query" "avg_request_query" {
  dataset    = local.dataset
  query_json = data.honeycombio_query_specification.query.json
}

resource "honeycombio_board" "nlanatta_test" {
  name        = local.board_name
  description = local.board_description
  style       = "list"

  query {
    caption  = local.query_name
    dataset  = local.dataset
    query_id = honeycombio_query.avg_request_query.id
    query_annotation_id = honeycombio_query_annotation.avg_request_annotation.id
  }
}