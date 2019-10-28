#Turning swapmemory off
sudo swapoff -a

#sleep 45sec, so the node can get ready
echo "sleep 45sec, so the node can get ready"
sleep 45

#Checks if flannel.1 interface exists and substracts subnet
interface="flannel.1"
default_bridge="cni0"

if ifconfig "$interface" &> /dev/null; then
   echo "interface $interface exists"
   ip=$(ifconfig "$interface" | awk '$1 == "inet" {print $2}')
   baseaddr="$(echo $ip | cut -d. -f1-3)"
   lsv="$(echo $ip | cut -d. -f4)"
   lsv=$(( $lsv + 1))
   ip=$"$baseaddr.$lsv"
   echo "$ip"

#Checks if cni0 exists (occurs when containers have been created on the node), if so, flannel can be deleted from the node.
   if ifconfig "$default_bridge" &> /dev/null; then
      echo "The default bridge $default_bridge exists"
      echo "Removing $interface, since not needed anymore"
      ip link set "$interface" down
      ip link delete "$interface"
   else
      echo "No containers have been deployed on this node before, please deploy a container first"
   fi
elif ifconfig "$default_bridge" &> /dev/null; then
   ip=$(ifconfig "$default_bridge" | awk '$1 == "inet" {print $2}')
else
   echo "interface $interface does NOT exist"
   echo "Start the kubernetes-startup.sh script on the Kubernetes Master"
fi



#Creates 2 bridges (i.e cni1 and cni2 based on Kubernetes subnet)
bridges=2;

for ((i=1;i<="$bridges";i++)); do
    tenant=$(( $i + 1 ))
    echo "Setting bridge cni0 in vrf tenant1"
    brctl addbr cni"$i" &> /dev/null
    ip addr add "$ip" dev cni"$i" &> /dev/null
    ip link set dev cni"$i" up &> /dev/null
    echo "Created bridge cni$i with IP address $ip"
    ip link set dev cni0 vrf tenant1
    ip link set dev cni"$i" vrf tenant"$tenant"
    network=$(ifconfig cni"$i" | awk '$1 == "inet"{print $2}')
    baseaddr_bridge="$(echo $network | cut -d. -f1-3)"
    lsv_bridge="$(echo $network | cut -d. -f4)"
    lsv_bridge=$(( $lsv + 0))
    subnet=$"$baseaddr_bridge.$lsv_bridge"
    ip route add "$subnet"/24 dev cni"$i" vrf tenant"$tenant"
    echo "Added $subnet/24 dev cni$i to vrf table tenant$tenant"
    echo "Bridge cni$i is in vrf tenant$i, run 'ip link set dev cni$i vrf (vrf)' to change the vrf of the bridge"
done
