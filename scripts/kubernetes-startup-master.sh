#enable docker
sudo systemctl enable docker

#turn swapmemory off
sudo swapoff -a

#Check if flannel is running
i=0;

var=$(kubectl get daemonset --all-namespaces)
for line in $var; do
    if [[ $line == *"flannel"* ]]; then
       ((i=i+1))
    fi
done

if [[ $i == 0 ]]; then
   echo "Flannel is NOT running"
   echo "Starting flannel..."
   sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
else
   echo "Flannel is already running, nothing to do"
fi
