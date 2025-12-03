# OC_P6_Ansible
## Clé d accès générée pour le compte ocp6-terrafom avec role limité à EC2 

1. **VM fournit par AWS via TERRAFORM
   - resource "aws_instance" "my_server" 
     region = "eu-west-3"
     ami           = "ami-0ef9bcd5dfb57b968" # ubuntu zone paris
     instance_type = "t3.micro"
     associate_public_ip_address = false  # elastic ip utilisée
   - resource "aws_eip" "my_eip"
   - resource "aws_security_group" "my_security_group"
   - resource "tls_private_key" "my_ssh_key"
   - resource "aws_key_pair" "generated_key"  

2. **Informations VM  et IP statique générée
   
   
