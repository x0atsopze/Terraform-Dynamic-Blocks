resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

#create the dynamic ingrees and iterate in the sg_ports variable
  dynamic "ingress" {
    for_each = var.sg_ports
#if no iterator is defined, the name of the variable defaults to the label of the dynamic block which is ingress in this case
    iterator = port 
    content {
#if there were no iterator port up there, this value would have been ingress.value
      from_port   = port.value 
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
#no iterator defined so the value here is label of dynamic block + value
      from_port   = egress.value 
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
