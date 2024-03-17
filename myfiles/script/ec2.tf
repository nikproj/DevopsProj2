#ON Dev-VPC
/*
resource "aws_instance" "dev1"{
 tags = merge (
      {
          Name = "Developer1"
      },
      var.tags
  )
 ami                            = var.ami_ubuntu_south
 instance_type                  = var.insttype_t2micro
 key_name                       = "mykey"
 subnet_id                      = aws_subnet.private[0].id
 associate_public_ip_address    = false
 security_groups                = [aws_security_group.dev_sg.id]
 user_data = <<-EOF
                     #!/bin/bash
                     sudo apt update -y
                 EOF
}
*/

resource "aws_instance" "jenkinmaster"{
 tags = merge (
      {
          Name = "MasterServer"
      },
      var.tags
  )
 ami                            = var.ami_ubuntu_south
 instance_type                  = var.insttype_t2medium
 key_name                       = "mykey"
 subnet_id                      = aws_subnet.public[0].id
 associate_public_ip_address    = true
 security_groups                = [aws_security_group.dev_sg.id]
 user_data = <<-EOF
                     #!/bin/bash
                     sudo apt update -y
                     sudo su -
                     #JAVA_11
                     sudo add-apt-repository ppa:openjdk-r/ppa -y
                     sudo apt-get update -y
                     sudo apt-get install -y fontconfig openjdk-11-jre openjdk-11-jdk
                     #JENKINS
                     curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
                     echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
                     sudo apt-get update -y
                     sudo apt-get install jenkins -y
                     #DOCKER
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
                     sudo chmod 755 /tmp/installDocker.sh
                     sudo bash /tmp/installDocker.sh
                     sudo systemctl restart docker.service
                     #CRI-DOCKER
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installCRIDockerd.sh -P /tmp
                     sudo chmod 755 /tmp/installCRIDockerd.sh
                     sudo bash /tmp/installCRIDockerd.sh
                     sudo systemctl restart cri-docker.service
                     #kubeadm,kubelet,kubectl
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installK8S.sh -P /tmp
                     sudo chmod 755 /tmp/installK8S.sh
                     sudo bash /tmp/installK8S.sh
                     #Initialize kubernetes Master Node
                     sudo kubeadm init --cri-socket unix:///var/run/cri-dockerd.sock --ignore-preflight-errors=all
                     sudo mkdir -p $HOME/.kube
                     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
                     sudo chown $(id -u):$(id -g) $HOME/.kube/config
                     #CALICO-NETWORKING-DRIVER   
                     kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/calico.yaml
                      
                     #kubeadm token create --print-join-command
                     #sudo |token| --cri-socket unix:///var/run/cri-dockerd.sock
                 EOF
}


#on Prod-VPC
resource "aws_instance" "server1"{
 tags = merge (
      {
          Name = "ProdServer-1"
      },
      var.tags
  )
 ami                            = var.ami_ubuntu_south
 instance_type                  = var.insttype_t2small
 key_name                       = "mykey"
 subnet_id                      = aws_subnet.private2[0].id
 associate_public_ip_address    = false
 security_groups                = [aws_security_group.kube_sg.id]
 user_data = <<-EOF
                     #!/bin/bash
                     sudo apt update -y
                     sudo su -
                     #JAVA_11
                     sudo add-apt-repository ppa:openjdk-r/ppa -y
                     sudo apt-get update -y
                     sudo apt-get install -y fontconfig openjdk-11-jre openjdk-11-jdk
                     #DOCKER
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
                     sudo chmod 755 /tmp/installDocker.sh
                     sudo bash /tmp/installDocker.sh
                     sudo systemctl restart docker.service
                     #CRI-DOCKER
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installCRIDockerd.sh -P /tmp
                     sudo chmod 755 /tmp/installCRIDockerd.sh
                     sudo bash /tmp/installCRIDockerd.sh
                     sudo systemctl restart cri-docker.service
                     #kubeadm,kubelet,kubectl
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installK8S.sh -P /tmp
                     sudo chmod 755 /tmp/installK8S.sh
                     sudo bash /tmp/installK8S.sh
                 EOF
}

resource "aws_instance" "server2"{
 tags = merge (
      {
          Name = "ProdServer-2"
      },
      var.tags
  )
 ami                            = var.ami_ubuntu_south
 instance_type                  = var.insttype_t2small
 key_name                       = "mykey"
 subnet_id                      = aws_subnet.private2[1].id
 associate_public_ip_address    = false
 security_groups                = [aws_security_group.kube_sg.id]
 user_data = <<-EOF
                     #!/bin/bash
                     sudo apt update -y
                     sudo su -
                     #DOCKER
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
                     sudo chmod 755 /tmp/installDocker.sh
                     sudo bash /tmp/installDocker.sh
                     sudo systemctl restart docker.service
                     #CRI-DOCKER
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installCRIDockerd.sh -P /tmp
                     sudo chmod 755 /tmp/installCRIDockerd.sh
                     sudo bash /tmp/installCRIDockerd.sh
                     sudo systemctl restart cri-docker.service
                     #kubeadm,kubelet,kubectl
                     sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installK8S.sh -P /tmp
                     sudo chmod 755 /tmp/installK8S.sh
                     sudo bash /tmp/installK8S.sh
                     #sudo |token| --cri-socket unix:///var/run/cri-dockerd.sock
                 EOF
}