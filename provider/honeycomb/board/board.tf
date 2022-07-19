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