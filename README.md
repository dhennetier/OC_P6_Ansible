# OC_P6_Ansible
## Clé d accès générée pour le compte ocp6-terrafom avec role limité à EC2 

1. **VM fournit par AWS via TERRAFORM**
   - resource "aws_instance" "my_server" 
     - region = "eu-west-3"
     - ami           = "ami-0ef9bcd5dfb57b968" # ubuntu zone paris
     - instance_type = "t3.micro"
     - associate_public_ip_address = false  # elastic ip utilisée
   - resource "aws_eip" "my_eip"
   - resource "aws_security_group" "my_security_group"
   - resource "tls_private_key" "my_ssh_key"
   - resource "aws_key_pair" "generated_key"  

2. **Informations VM  et IP statique générée**
  - aws_eip.my_eip.public_ip
    - "35.180.1.165"  
  - aws_eip.my_eip.public_dns
    - "ec2-35-180-1-165.eu-west-3.compute.amazonaws.com"
  - "ssh -i ~/.ssh/aws_${aws_key_pair.generated_key.key_name}.pem ubuntu@${aws_eip.my_eip.public_dns}"
    - "ssh -i ~/.ssh/aws_openclassrooms_devops_p6.pem ubuntu@ec2-35-180-1-165.eu-west-3.compute.amazonaws.com" 

3. ** Inventaire Ansible format yml : hosts.yml**
   - un seul serveur dans l'inventaire , serveur web sur AWS : fichier 
   - Référencé par le aws_eip.my_eip.public_dns :ec2-35-180-1-165.eu-west-3.compute.amazonaws.com
     
   - [hosts.yml](.hosts.yml)
```json
all:
  children:
    webservers:  # Groupe pour les serveurs web : un seul serveur ici mais prévoyons ...
      hosts:
        # eip: public dns
        ec2-35-180-1-165.eu-west-3.compute.amazonaws.com:
          ansible_user: ubuntu
          ansible_ssh_private_key_file: ~/.ssh/aws_openclassrooms_devops_p6.pem
          ansible_python_interpreter: /usr/bin/python3.12
```

4. **Problème sur VM micro**
   - Les ressource mmémoire sous dimesionnée sur l offre gratuite : t".micro
   - Nombreux plantages ou machine figée pendant déploiement
   - passage sur region Paris mais pas d amélioration significatives
   - Playbook a jouer avant : [setup_swap.yml](./setup_swap.yml)
5. **Fix NGNIX  : fichier nginix.cfg adapté**
      - alias DNS se l eIP publique sur olympics.openmindx.fr ( Domaine perso sur Scaleway ) 
  
7. ** Deploiement Application : deploy.yml**
  
8. **Test Application : olympics.openmindx.fr**
    
  
