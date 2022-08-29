locals {
  create = var.create
  this_sg_id = var.create_sg ? concat(aws_security_group.this.*.id, [""])[0] : var.security_group_id
}

resource "aws_security_group" "this" {
  name        =  var.name
  description = var.description
  vpc_id      = var.aws_vpc_id


 }

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = local.create ? length(var.ingress_with_cidr_blocks) : 0

  security_group_id = local.this_sg_id

  type              = "ingress"

  cidr_blocks = split(
    ",",
    lookup(
      var.ingress_with_cidr_blocks[count.index],
      "cidr_blocks",
      join(",", var.ingress_cidr_blocks),
    ),
  )
  prefix_list_ids = var.ingress_prefix_list_ids
  description = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][1],
  )
  protocol = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "protocol",
    var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][2],
  )
}

resource "aws_security_group_rule" "computed_ingress_with_source_security_group_id" {
  count = local.create ? var.number_of_computed_ingress_with_source_security_group_id : 0

  security_group_id = local.this_sg_id  
  type              = "ingress"

  source_security_group_id = var.computed_ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  prefix_list_ids          = var.ingress_prefix_list_ids
  description = lookup(
    var.computed_ingress_with_source_security_group_id[count.index],
    "description",
    "Ingress Rule",
  )

  from_port = lookup(
    var.computed_ingress_with_source_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_ingress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_ingress_with_source_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_ingress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    var.computed_ingress_with_source_security_group_id[count.index],
    "protocol",
    var.rules[lookup(
      var.computed_ingress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )
}

resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  count = local.create ? length(var.egress_with_cidr_blocks) : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  cidr_blocks = split(
    ",",
    lookup(
      var.egress_with_cidr_blocks[count.index],
      "cidr_blocks",
      join(",", var.egress_cidr_blocks),
    ),
  )
  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    var.egress_with_cidr_blocks[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_cidr_blocks[count.index],
    "from_port",
    var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][0],
  )
  to_port = lookup(
    var.egress_with_cidr_blocks[count.index],
    "to_port",
    var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][1],
  )
  protocol = lookup(
    var.egress_with_cidr_blocks[count.index],
    "protocol",
    var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][2],
  )
}

resource "aws_security_group_rule" "computed_egress_with_source_security_group_id" {
  count = local.create ? var.number_of_computed_egress_with_source_security_group_id : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  source_security_group_id = var.computed_egress_with_source_security_group_id[count.index]["source_security_group_id"]
  prefix_list_ids          = var.egress_prefix_list_ids
  description = lookup(
    var.computed_egress_with_source_security_group_id[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.computed_egress_with_source_security_group_id[count.index],
    "from_port",
    var.rules[lookup(
      var.computed_egress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][0],
  )
  to_port = lookup(
    var.computed_egress_with_source_security_group_id[count.index],
    "to_port",
    var.rules[lookup(
      var.computed_egress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][1],
  )
  protocol = lookup(
    var.computed_egress_with_source_security_group_id[count.index],
    "protocol",
    var.rules[lookup(
      var.computed_egress_with_source_security_group_id[count.index],
      "rule",
      "_",
    )][2],
  )
}