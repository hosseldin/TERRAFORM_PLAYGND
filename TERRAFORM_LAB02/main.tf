# ==============================================
#
# =========== TERRAFORM FILE START =============
#
# ==============================================
#
# Created By: Hossam Mahmoud
# Date: 2025-02-28
# Filename: main.tf
# Description: Calls the networking and compute modules
# Version: 1.0.0
# Copyright (c) 2025 Hossam. All rights reserved.
#
# ==============================================
#
# ====== TERRAFORM IMPLEMENTATION START ======
#
# ==============================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
}

module "instances" {
  source = "./modules/instance"
  instances = [
    for instance in var.instances : {
      name              = instance.name
      ami               = instance.ami
      instance_type     = instance.instance_type
      subnet_id         = lookup(module.vpc.subnet_ids, instance.subnet_name, null)
      security_group_id = lookup(module.security_group.security_group_ids, instance.security_name, null)
=======
    {
      name              = "app-server-1"
      ami               = var.ami_id
      instance_type     = var.instance_type
      subnet_id         = module.vpc.public_subnet_id
      security_group_id = module.security_group.security_group_id
    },
    {
      name              = "app-server-2"
      ami               = var.ami_id
      instance_type     = var.instance_type
      subnet_id         = module.vpc.private_subnet_id
      security_group_id = module.security_group.security_group_id
>>>>>>> ea8631a403d5a4e5e6039c69f42de322418f6aa7
    }
  ]
}





# ==============================================
#
# ======= TERRAFORM IMPLEMENTATION END ========
#
# ==============================================
#
# End of File
# Copyright (c) 2025 Hossam. All rights reserved.
#
# ==============================================
#
# ============= TERRAFORM FILE END =============
#
# ==============================================
