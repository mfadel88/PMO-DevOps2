module "Network" {
    source = "./Network"
    vpc_cidr_block= var.vpc_cidr_block
    PRI-SN1-cider = var.PRI-SN1-cider
    PRI-SN2-cider = var.PRI-SN2-cider
    PUB-SN1-cider = var.PUB-SN1-cider
    PUB-SN2-cider = var.PUB-SN2-cider
}
