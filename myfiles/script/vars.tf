variable "region" {
    description = "Region Of VPC"
    type = string 
    default = "ap-south-1"  
}
variable "tags" {
    description = "Region Of VPC"
    type = map
    default = null
}

#VPC1
variable "name" {
    description = "Name of the VPC"
    type = string    
    default = "development"
}
variable "vpc_cidr_block" {
    description = "CIDR Range Of VPC"
    type = string  
    default = "10.0.0.0/16"
}
variable "availability_zones_pub" {
    description = "Region Of VPC"
    type = list(string)
    default = ["ap-south-1a", "ap-south-1b"]
}
variable "public_subnet_cidr_blocks" {
    description = "Region Of VPC"
    type = list(string)  
    default = ["10.0.1.0/24", "10.0.2.0/24"]  
}
variable "availability_zones_pri" {
    description = "Region Of VPC"
    type = list(string)
    default = ["ap-south-1a"]
}
variable "private_subnet_cidr_blocks" {
    description = "Region Of VPC"
    type = list(string) 
    default = ["10.0.3.0/24"]  
}


#VPC2
variable "name2" {
    description = "Name of the VPC"
    type = string    
    default = "production"
}
variable "vpc_cidr_block2" {
    description = "CIDR Range Of VPC"
    type = string  
    default = "11.0.0.0/16"
}
variable "availability_zones2_pub" {
    description = "Region Of VPC"
    type = list(string)
    default = ["ap-south-1a", "ap-south-1b"]
}
variable "public_subnet_cidr_blocks2" {
    description = "Region Of VPC"
    type = list(string)  
    default = ["11.0.1.0/24", "11.0.5.0/24"]  
}
variable "availability_zones2_pri" {
    description = "Region Of VPC"
    type = list(string)
    default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
variable "private_subnet_cidr_blocks2" {
    description = "Region Of VPC"
    type = list(string) 
    default = ["11.0.2.0/24", "11.0.3.0/24", "11.0.4.0/24"]  
}

#EC2 Instance
variable "ami_ubuntu_south" {
    description   = "AMI ID of UBuntu in ap-south-1"
    type          = string
    default       = "ami-03bb6d83c60fc5f7c"  
}
variable "insttype_t2micro" {
    description   = "Instance Type"
    type          = string
    default       = "t2.micro"  
}
variable "insttype_t2medium" {
    description   = "Instance Type"
    type          = string
    default       = "t2.medium"  
}
variable "insttype_t2small" {
    description   = "Instance Type"
    type          = string
    default       = "t2.small"  
}

#TargetGroup
variable "health_check" {
   type = map(string)
   default = {
      "timeout"  = "10"
      "interval" = "20"
      "path"     = "/"
      "port"     = "80"
      "unhealthy_threshold" = "2"
      "healthy_threshold" = "3"
    }
}