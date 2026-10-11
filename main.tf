resource "google_cloud_asset_organization_feed" "cloud_asset_organization_feeds" {
  for_each = var.cloud_asset_organization_feeds

  billing_project = each.value.billing_project
  feed_id         = each.value.feed_id
  org_id          = each.value.org_id
  asset_names     = each.value.asset_names
  asset_types     = each.value.asset_types
  content_type    = each.value.content_type
  deletion_policy = each.value.deletion_policy

  feed_output_config {
    pubsub_destination {
      topic = each.value.feed_output_config.pubsub_destination.topic
    }
  }

  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      description = condition.value.description
      expression  = condition.value.expression
      location    = condition.value.location
      title       = condition.value.title
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

