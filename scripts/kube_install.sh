INSTALL_PKGS="curl gpg gnupg2 docker.io software-properties-common"

for i in $INSTALL_PKGS; do
  sudo apt install -y $i
done

sudo systemctl enable docker

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt install kubeadm -y

sudo swapoff -a
