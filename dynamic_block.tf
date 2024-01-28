resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

#create the dynamic ingree and iterate in the sg_ports variable
  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port #if no iterator is defined, the name of the variable defaults to the label of the dynamic block which is ingress in this case
    content {               
      from_port   = port.value #if there were no iterator port up there, this value
      to_port     = port.value #would have been ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value #no iterator defined so the value here is label of dynamic block + value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
