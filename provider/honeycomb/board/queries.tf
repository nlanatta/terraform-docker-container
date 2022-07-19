resource "honeycombio_query_annotation" "avg_request_annotation" {
  dataset    = local.dataset
  query_id  = honeycombio_query.avg_request_query.id
  name      = local.query_name
}

resource "honeycombio_query" "avg_request_query" {
  dataset    = local.dataset
  query_json = data.honeycombio_query_specification.query.json
}

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