resource "aws_security_group" "securitygroup" {
  name        =  var.aws_sg_name
  description = var.description
  vpc_id      = var.aws_vpc_id


 }

resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
    count = local.create ? length(var.ingress_with_source_security_group_id) : 0
  
    security_group_id = local.this_sg_id
    type              = "ingress"
  
    source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
    prefix_list_ids          = var.ingress_prefix_list_ids
    description = lookup(
      var.ingress_with_source_security_group_id[count.index],
      "description",
      "Ingress Rule",
    )
  
    from_port = lookup(
      var.ingress_with_source_security_group_id[count.index],
      "from_port",
      var.rules[lookup(
        var.ingress_with_source_security_group_id[count.index],
        "rule",
        "_",
      )][0],
    )
    to_port = lookup(
      var.ingress_with_source_security_group_id[count.index],
      "to_port",
      var.rules[lookup(
        var.ingress_with_source_security_group_id[count.index],
        "rule",
        "_",
      )][1],
    )
    protocol = lookup(
      var.ingress_with_source_security_group_id[count.index],
      "protocol",
      var.rules[lookup(
        var.ingress_with_source_security_group_id[count.index],
        "rule",
        "_",
      )][2],
    )
  }