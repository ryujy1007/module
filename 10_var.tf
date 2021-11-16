variable "name" {
  type = string
  default = "ryujy"
}

variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "ava" {
  type = list(string)
  default = ["a","c"]
}

variable "key" {
  type = string
  default = "ryujy-key"
}


variable "cidr_main" {
  type = string
  default = "10.0.0.0/16"
}


variable "cidr_public" {
  type = list(string)
  default = ["10.0.0.0/24","10.0.2.0/24"]
}

variable "cidr_private" {
  type = list(string)
  default = ["10.0.1.0/24","10.0.3.0/24"]
}

variable "cidr_privatedb" {
  type = list(string)
  default = [ "10.0.4.0/24","10.0.5.0/24" ]
}

variable "cidr_ip" {
  type = string
  default = "::/0"
}
variable "cidr_route" {
  type = string
  default = "0.0.0.0/0"
}

variable "pro_tcp" {
  type = string
  default = "tcp"
}

variable "pro_http" {
  type = string
  default = "HTTP"
}
variable "http" {
  type = string
  default = "80"
}

variable "ssh" {
  type = string
  default = "22"
}

variable "SQL" {
  type = string
  default = "3306"
}

variable "port_zero" {
  type = string
  default = "0"
}

variable "port_minus" {
  type = string
  default = "-1"
}

variable "instance" {
  type = string
  default = "t2.micro"
}

variable "private_ip" {
  type = string
  default = "10.0.0.11"
}

variable "lb_type" {
  type = string
  default = "application"
}

variable "strategy" {
  type = string
  default = "cluster"
}

variable "storage_size" {
  type = string
  default = "20"
}

variable "storage_type" {
  type = string
  default = "gp2"
}

variable "sql_engine" {
  type = string
  default = "mysql"
}

variable "sql_version" {
  type = string
  default = "8.0"
}

variable "db_class" {
  type = string
  default = "db.t2.micro"
}

variable "username" {
  type = string
  default = "admin"
}

variable "password" {
  type = string
  default = "It12345!"
}



















