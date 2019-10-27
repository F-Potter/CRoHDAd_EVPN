## Overview
<cli>
root@server01:/home/cumulus# kubectl get pods -o wide 
NAME                              READY   STATUS    RESTARTS   AGE     IP             NODE
exp2-c1-vrf1-86c7f797cc-69qlk     1/1     Running   0          58m     10.244.2.2     server03
exp2-c2-vrf2-77c98694d5-spwvm     1/1     Running   0          56m     10.244.2.3     server03
exp2-c3-vrf3-d49cf6957-82f5h      1/1     Running   0          55m     10.244.2.4     server03
exp2-c4-vrf1-564d77b6ff-cmm4q     1/1     Running   0          41m     10.244.4.2     server05
exp2-c5-vrf2-655756cc75-7t8xc     1/1     Running   0          39m     10.244.4.3     server05
exp2-c6-vrf3-d7fc7d455-d7c2c      1/1     Running   0          39m     10.244.4.4     server05
exp2-c7-vrf1-6cc5ddd65-5v6ff      1/1     Running   0          13m     10.244.6.142   server07
exp2-c8-vrf2-697b5895d5-sfpsf     1/1     Running   0          12m     10.244.6.143   server07
exp2-c9-vrf3-96dd87fc7-lsdll      1/1     Running   0          11m     10.244.6.144   server07
</cli>

## Server03
### VRF Tenant1
<cli>
root@server03:/home/cumulus# ip route sh vrf tenant1
10.244.2.0/24 dev cni0 proto kernel scope link src 10.244.2.1
10.244.2.2 dev cni0 scope link
10.244.4.0/24 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
10.244.6.0/24 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
10.244.6.142 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
192.168.34.0/24 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
192.168.35.0/24 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
192.168.46.0/24 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
192.168.47.0/24 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
</cli>

### VRF Tenant2
<cli>
root@server03:/home/cumulus# ip route sh vrf tenant2
10.244.2.0/24 dev cni1 proto kernel scope link src 10.244.2.1
10.244.2.3 dev cni1 scope link
10.244.4.0/24 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
10.244.6.0/24 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
10.244.6.143 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
192.168.24.0/24 dev vlan1132 proto kernel scope link src 192.168.24.1
192.168.25.0/24 dev vlan1143 proto kernel scope link src 192.168.25.1
192.168.36.0/24 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
192.168.37.0/24 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
192.168.48.0/24 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
192.168.49.0/24 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
</cli>

### VRF Tenant3
<cli>
root@server03:/home/cumulus# ip route sh vrf tenant3
10.244.2.0/24 dev cni2 proto kernel scope link src 10.244.2.1
10.244.2.4 dev cni2 scope link
10.244.4.0/24 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
10.244.6.0/24 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
10.244.6.144 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
192.168.26.0/24 dev vlan1154 proto kernel scope link src 192.168.26.1
192.168.27.0/24 dev vlan1165 proto kernel scope link src 192.168.27.1
192.168.38.0/24 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
192.168.39.0/24 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
192.168.50.0/24 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
192.168.51.0/24 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
</cli>

### Bridge overview
<cli>
root@server03:/home/cumulus# brctl show
bridge name     bridge id               STP enabled     interfaces
bridge          8000.26416af45330       no              veth220
                                                        vni404001
                                                        vni404002
                                                        vni404003
cni0            8000.7654f2683daa       no              veth88f1bb1a (Container1)
cni1            8000.8eec93a850e0       no              veth1a41ef25 (Container2)
cni2            8000.76bdb7008b0e       no              veth8fee4f0c (Container3)
</cli>

### Bridge cni0 in Tenant1
<cli>
root@server03:/home/cumulus# vtysh -c 'show int cni0'
Interface cni0 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 12:49:13.31
  Link downs:     1    last: 2019/10/17 12:49:13.31
  vrf: tenant1
  index 42 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 76:54:f2:68:3d:aa
  inet 10.244.2.1/24
  inet6 fe80::7454:f2ff:fe68:3daa/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### Bridge cni1 in Tenant2
<cli>
root@server03:/home/cumulus# vtysh -c 'show int cni1'
Interface cni1 is up, line protocol is up
  Link ups:       1    last: 2019/10/17 12:50:07.31
  Link downs:     0    last: (never)
  vrf: tenant2
  index 46 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 8e:ec:93:a8:50:e0
  inet 10.244.2.1/24
  inet6 fe80::14ef:60ff:fec5:1138/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### Bridge cni2 in Tenant3
<cli>
root@server03:/home/cumulus# vtysh -c 'show int cni2'
Interface cni2 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 12:51:33.16
  Link downs:     1    last: 2019/10/17 12:51:33.15
  vrf: tenant3
  index 47 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 76:bd:b7:00:8b:0e
  inet 10.244.2.1/24
  inet6 fe80::944a:80ff:fec6:1b46/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### IP address of cni0
<cli>
root@server03:/home/cumulus# ifconfig cni0
cni0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.2.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::7454:f2ff:fe68:3daa  prefixlen 64  scopeid 0x20<link>
        ether 76:54:f2:68:3d:aa  txqueuelen 1000  (Ethernet)
        RX packets 13  bytes 588 (588.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 38  bytes 2900 (2.9 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### IP address of cni1
<cli>
root@server03:/home/cumulus# ifconfig cni1
cni1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.2.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::14ef:60ff:fec5:1138  prefixlen 64  scopeid 0x20<link>
        ether 8e:ec:93:a8:50:e0  txqueuelen 1000  (Ethernet)
        RX packets 8  bytes 448 (448.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 17  bytes 1566 (1.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### IP address of cni2
<cli>
root@server03:/home/cumulus# ifconfig cni2
cni2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.2.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::944a:80ff:fec6:1b46  prefixlen 64  scopeid 0x20<link>
        ether 76:bd:b7:00:8b:0e  txqueuelen 1000  (Ethernet)
        RX packets 15  bytes 812 (812.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 40  bytes 3232 (3.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### Global routing table
<cli>
root@server03:/home/cumulus# ip route
10.250.250.10 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.11 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.14 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.15 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.16 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.17 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.18 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
</cli>

## Tenant1
### Container IP of Container1 on Server3 and connectivity to Container4 on Server5 in VRF Tenant1
<cli>
root@server03:/home/cumulus# docker exec -it 44c5ed7a397c sh
/ # ip a
3: eth0@if43: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 7e:b4:f4:45:57:01 brd ff:ff:ff:ff:ff:ff
    inet 10.244.2.2/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.2
PING 10.244.4.2 (10.244.4.2): 56 data bytes
64 bytes from 10.244.4.2: seq=0 ttl=62 time=5.607 ms
64 bytes from 10.244.4.2: seq=1 ttl=62 time=2.582 ms
--- 10.244.4.2 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 2.582/4.094/5.607 ms
</cli>

### Container IP of Container1 on Server3 and connectivity to Container7 on Server7 in VRF Tenant1
<cli>
/ # ip a
3: eth0@if43: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 7e:b4:f4:45:57:01 brd ff:ff:ff:ff:ff:ff
    inet 10.244.2.2/24 scope global eth0
       valid_lft forever preferred_lft forever
       
/ # ping 10.244.6.142
PING 10.244.6.142 (10.244.6.142): 56 data bytes
64 bytes from 10.244.6.142: seq=0 ttl=62 time=2.242 ms
64 bytes from 10.244.6.142: seq=1 ttl=62 time=1.936 ms
64 bytes from 10.244.6.142: seq=2 ttl=62 time=6.886 ms
--- 10.244.6.142 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.936/3.688/6.886 ms
</cli>

## Tenant2
### Container IP of Container2 on Server3 and connectivity to Container5 on Server5 in VRF Tenant1
<cli>
root@server03:/home/cumulus# docker exec -it ffc82320dce8 sh
       valid_lft forever preferred_lft forever
3: eth0@if44: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether ae:1a:2e:81:82:8a brd ff:ff:ff:ff:ff:ff
    inet 10.244.2.3/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.3
PING 10.244.4.3 (10.244.4.3): 56 data bytes
64 bytes from 10.244.4.3: seq=0 ttl=62 time=2.905 ms
64 bytes from 10.244.4.3: seq=1 ttl=62 time=6.285 ms
64 bytes from 10.244.4.3: seq=2 ttl=62 time=2.380 ms
--- 10.244.4.3 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.380/3.856/6.285 ms
</cli>

### Container IP of Container2 on Server3 and connectivity to Container8 on Server7 in VRF Tenant1
<cli>
root@server03:/home/cumulus# docker exec -it ffc82320dce8 sh
       valid_lft forever preferred_lft forever
3: eth0@if44: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether ae:1a:2e:81:82:8a brd ff:ff:ff:ff:ff:ff
    inet 10.244.2.3/24 scope global eth0
       valid_lft forever preferred_lft forever
       
/ # ping 10.244.6.143
PING 10.244.6.143 (10.244.6.143): 56 data bytes
64 bytes from 10.244.6.143: seq=0 ttl=62 time=2.424 ms
64 bytes from 10.244.6.143: seq=1 ttl=62 time=1.818 ms
64 bytes from 10.244.6.143: seq=2 ttl=62 time=2.209 ms
^C
--- 10.244.6.143 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.818/2.150/2.424 ms
</cli>

## Tenant3
### Container IP of Container3 on Server3 and connectivity to Container6 on Server5 in VRF Tenant1
<cli>
root@server03:/home/cumulus# docker exec -it c810d0212cfc sh
/ # ip a
3: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether c2:fe:a7:27:9a:62 brd ff:ff:ff:ff:ff:ff
    inet 10.244.2.4/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.4
PING 10.244.4.4 (10.244.4.4): 56 data bytes
64 bytes from 10.244.4.4: seq=0 ttl=62 time=4.016 ms
64 bytes from 10.244.4.4: seq=1 ttl=62 time=2.462 ms
64 bytes from 10.244.4.4: seq=2 ttl=62 time=2.057 ms
--- 10.244.4.4 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.057/2.845/4.016 ms
</cli>

### Container IP of Container3 on Server3 and connectivity to Container9 on Server7 in VRF Tenant1
<cli>
root@server03:/home/cumulus# docker exec -it c810d0212cfc sh
/ # ip a
3: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether c2:fe:a7:27:9a:62 brd ff:ff:ff:ff:ff:ff
    inet 10.244.2.4/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.6.144
PING 10.244.6.144 (10.244.6.144): 56 data bytes
64 bytes from 10.244.6.144: seq=0 ttl=62 time=2.882 ms
64 bytes from 10.244.6.144: seq=1 ttl=62 time=2.011 ms
64 bytes from 10.244.6.144: seq=2 ttl=62 time=2.023 ms
--- 10.244.6.144 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.011/2.305/2.882 ms
</cli>

## Server05
### VRF Tenant1
<cli>
root@server05:/home/cumulus# ip route sh vrf tenant1
10.244.2.0/24 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
10.244.2.2 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
10.244.4.0/24 dev cni0 proto kernel scope link src 10.244.4.1
10.244.4.2 dev cni0 scope link
10.244.6.0/24 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
10.244.6.142 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
192.168.22.0/24 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
192.168.23.0/24 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
192.168.46.0/24 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
192.168.47.0/24 via 10.250.250.17 dev dummysvi404001 proto bgp metric 20 onlink
</cli>

### VRF Tenant2
<cli>
root@server05:/home/cumulus# ip route sh vrf tenant2
10.244.2.0/24 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
10.244.2.3 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
10.244.4.0/24 dev cni1 proto kernel scope link src 10.244.4.1
10.244.4.3 dev cni1 scope link
10.244.6.0/24 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
10.244.6.143 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
192.168.24.0/24 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
192.168.25.0/24 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
192.168.48.0/24 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
192.168.49.0/24 via 10.250.250.17 dev dummysvi404002 proto bgp metric 20 onlink
</cli>

### VRF Tenant3
<cli>
root@server05:/home/cumulus# ip route sh vrf tenant3
10.244.2.0/24 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
10.244.2.4 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
10.244.4.0/24 dev cni2 proto kernel scope link src 10.244.4.1
10.244.4.4 dev cni2 scope link
10.244.6.0/24 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
10.244.6.144 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
192.168.26.0/24 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
192.168.27.0/24 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
192.168.50.0/24 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
192.168.51.0/24 via 10.250.250.17 dev dummysvi404003 proto bgp metric 20 onlink
</cli>

### Bridge overview
<cli>
root@server05:/home/cumulus# brctl show
bridge name     bridge id               STP enabled     interfaces
bridge          8000.42437f366d67       no              veth340
                                                        vni404001
                                                        vni404002
                                                        vni404003
cni0            8000.2e32e2ba63b6       no              vethe1c06fad (Container 4)
cni1            8000.9ef50e17fdc2       no              veth58500372 (Container 5)
cni2            8000.8231a23183f7       no              veth13383a9b (Container 6)
docker0         8000.0242d2a48b89       no
</cli>

### Bridge cni0 in Tenant1
<cli>
root@server05:/home/cumulus# vtysh -c 'show int cni0'
Interface cni0 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 13:06:59.68
  Link downs:     1    last: 2019/10/17 13:06:59.68
  vrf: tenant1
  index 44 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 2e:32:e2:ba:63:b6
  inet 10.244.4.1/24
  inet6 fe80::2c32:e2ff:feba:63b6/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### Bridge cni1 in Tenant2
<cli>
root@server05:/home/cumulus# vtysh -c 'show int cni1'
Interface cni1 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 13:07:04.18
  Link downs:     1    last: 2019/10/17 13:07:04.18
  vrf: tenant2
  index 42 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 9e:f5:0e:17:fd:c2
  inet 10.244.4.1/24
  inet6 fe80::9cf5:eff:fe17:fdc2/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### Bridge cni2 in Tenant3
<cli>
root@server05:/home/cumulus# vtysh -c 'show int cni2'
Interface cni2 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 13:07:09.14
  Link downs:     1    last: 2019/10/17 13:07:09.14
  vrf: tenant3
  index 43 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 82:31:a2:31:83:f7
  inet 10.244.4.1/24
  inet6 fe80::8031:a2ff:fe31:83f7/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### IP address of cni0
<cli>
root@server05:/home/cumulus# ifconfig cni0
cni0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.4.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::2c32:e2ff:feba:63b6  prefixlen 64  scopeid 0x20<link>
        ether 2e:32:e2:ba:63:b6  txqueuelen 1000  (Ethernet)
        RX packets 24  bytes 1176 (1.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 30  bytes 2872 (2.8 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### IP address of cni1
<cli>
root@server05:/home/cumulus# ifconfig cni1
cni1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.4.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::9cf5:eff:fe17:fdc2  prefixlen 64  scopeid 0x20<link>
        ether 9e:f5:0e:17:fd:c2  txqueuelen 1000  (Ethernet)
        RX packets 9  bytes 532 (532.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 31  bytes 2742 (2.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### IP address of cni2
<cli>
root@server05:/home/cumulus# ifconfig cni2
cni2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.4.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::8031:a2ff:fe31:83f7  prefixlen 64  scopeid 0x20<link>
        ether 82:31:a2:31:83:f7  txqueuelen 1000  (Ethernet)
        RX packets 51  bytes 3388 (3.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 60  bytes 4744 (4.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### Global routing table
<cli>
root@server05:/home/cumulus# ip route
10.250.250.10 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.11 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.12 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.14 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.16 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.17 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.18 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
</cli>

## Tenant1
### Container IP of Container4 on Server5 and connectivity to Container1 on Server3 in VRF Tenant1
<cli>
root@server05:/home/cumulus# docker exec -it ba095770cdd0 sh
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 4e:3a:ed:ce:4d:b0 brd ff:ff:ff:ff:ff:ff
    inet 10.244.4.2/24 scope global eth0
       valid_lft forever preferred_lft forever
/ # ping 10.244.2.2
PING 10.244.2.2 (10.244.2.2): 56 data bytes
64 bytes from 10.244.2.2: seq=0 ttl=62 time=2.925 ms
64 bytes from 10.244.2.2: seq=1 ttl=62 time=2.080 ms
64 bytes from 10.244.2.2: seq=2 ttl=62 time=2.207 ms
^C
--- 10.244.2.2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.080/2.404/2.925 ms

</cli>

### Container IP of Container4 on Server5 and connectivity to Container6 on Server7 in VRF Tenant1
<cli>
root@server05:/home/cumulus# docker exec -it ba095770cdd0 sh
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 4e:3a:ed:ce:4d:b0 brd ff:ff:ff:ff:ff:ff
    inet 10.244.4.2/24 scope global eth0
       valid_lft forever preferred_lft forever
/ # ping 10.244.6.142
PING 10.244.6.142 (10.244.6.142): 56 data bytes
64 bytes from 10.244.6.142: seq=0 ttl=62 time=14.906 ms
64 bytes from 10.244.6.142: seq=1 ttl=62 time=1.280 ms
64 bytes from 10.244.6.142: seq=2 ttl=62 time=1.980 ms
^C
--- 10.244.6.142 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.280/6.055/14.906 ms
</cli>

## Tenant2
### Container IP of Container5 on Server5 and connectivity to Container2 on Server3 in VRF Tenant1
<cli>
root@server05:/home/cumulus# docker exec -it a7abd7dcb7d8 sh
/ # ip a
3: eth0@if46: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 6a:41:1a:87:92:9e brd ff:ff:ff:ff:ff:ff
    inet 10.244.4.3/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.3
PING 10.244.2.3 (10.244.2.3): 56 data bytes
64 bytes from 10.244.2.3: seq=0 ttl=62 time=2.717 ms
64 bytes from 10.244.2.3: seq=1 ttl=62 time=1.701 ms
64 bytes from 10.244.2.3: seq=2 ttl=62 time=2.371 ms
--- 10.244.2.3 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.701/2.263/2.717 ms
</cli>

### Container IP of Container5 on Server5 and connectivity to Container8 on Server7 in VRF Tenant1
<cli>
root@server05:/home/cumulus# docker exec -it a7abd7dcb7d8 sh
/ # ip a
3: eth0@if46: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 6a:41:1a:87:92:9e brd ff:ff:ff:ff:ff:ff
    inet 10.244.4.3/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.6.143
PING 10.244.6.143 (10.244.6.143): 56 data bytes
64 bytes from 10.244.6.143: seq=0 ttl=62 time=1.680 ms
64 bytes from 10.244.6.143: seq=1 ttl=62 time=1.729 ms
64 bytes from 10.244.6.143: seq=2 ttl=62 time=1.160 ms
--- 10.244.6.143 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.160/1.523/1.729 ms
</cli>

## Tenant3
### Container IP of Container6 on Server5 and connectivity to Container3 on Server3 in VRF Tenant1
<cli>
root@server05:/home/cumulus# docker exec -it 1fbc83628a7f sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 3a:40:cd:2f:d6:5d brd ff:ff:ff:ff:ff:ff
    inet 10.244.4.4/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.4
PING 10.244.2.4 (10.244.2.4): 56 data bytes
64 bytes from 10.244.2.4: seq=0 ttl=62 time=2.522 ms
64 bytes from 10.244.2.4: seq=1 ttl=62 time=1.990 ms
64 bytes from 10.244.2.4: seq=2 ttl=62 time=1.974 ms
--- 10.244.2.4 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.974/2.162/2.522 ms
</cli>

### Container IP of Container6 on Server5 and connectivity to Container9 on Server7 in VRF Tenant1
<cli>
root@server05:/home/cumulus# docker exec -it 1fbc83628a7f sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 3a:40:cd:2f:d6:5d brd ff:ff:ff:ff:ff:ff
    inet 10.244.4.4/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.6.144
PING 10.244.6.144 (10.244.6.144): 56 data bytes
64 bytes from 10.244.6.144: seq=0 ttl=62 time=2.212 ms
64 bytes from 10.244.6.144: seq=1 ttl=62 time=1.150 ms
64 bytes from 10.244.6.144: seq=2 ttl=62 time=1.256 ms
--- 10.244.6.144 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.150/1.539/2.212 ms
</cli>

## Server07
### VRF Tenant1
<cli>
root@server07:/home/cumulus# ip route sh vrf tenant1
10.244.2.0/24 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
10.244.2.2 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
10.244.4.0/24 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
10.244.4.2 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
10.244.6.0/24 dev cni0 proto kernel scope link src 10.244.6.1
10.244.6.142 dev cni0 scope link
192.168.22.0/24 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
192.168.23.0/24 via 10.250.250.12 dev dummysvi404001 proto bgp metric 20 onlink
192.168.34.0/24 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
192.168.35.0/24 via 10.250.250.15 dev dummysvi404001 proto bgp metric 20 onlink
</cli>

### VRF Tenant2
<cli>
root@server07:/home/cumulus# ip route sh vrf tenant2
10.244.2.0/24 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
10.244.2.3 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
10.244.4.0/24 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
10.244.4.3 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
10.244.6.0/24 dev cni1 proto kernel scope link src 10.244.6.1
10.244.6.143 dev cni1 scope link
192.168.24.0/24 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
192.168.25.0/24 via 10.250.250.12 dev dummysvi404002 proto bgp metric 20 onlink
192.168.36.0/24 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
192.168.37.0/24 via 10.250.250.15 dev dummysvi404002 proto bgp metric 20 onlink
</cli>

### VRF Tenant3
<cli>
root@server07:/home/cumulus# ip route sh vrf tenant3
10.244.2.0/24 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
10.244.2.4 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
10.244.4.0/24 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
10.244.4.4 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
10.244.6.0/24 dev cni2 proto kernel scope link src 10.244.6.1
10.244.6.144 dev cni2 scope link
192.168.26.0/24 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
192.168.27.0/24 via 10.250.250.12 dev dummysvi404003 proto bgp metric 20 onlink
192.168.38.0/24 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
192.168.39.0/24 via 10.250.250.15 dev dummysvi404003 proto bgp metric 20 onlink
</cli>
### Bridge overview
<cli>
root@server07:/home/cumulus# brctl show
bridge name     bridge id               STP enabled     interfaces
bridge          8000.16bf5d109102       no              veth460
                                                        vni404001
                                                        vni404002
                                                        vni404003
cni0            8000.5eea9a511ea1       no              veth7967dafd (Container7)
cni1            8000.ea6e66cd4848       no              veth701d3c85 (Container8)
cni2            8000.9a020acda9ea       no              vethb7700bd3 (Container9)
docker0         8000.0242b01c0212       no
</cli>

### Bridge cni0 in Tenant1
<cli>
root@server07:/home/cumulus# vtysh -c 'show int cni0'
Interface cni0 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 13:33:55.09
  Link downs:     1    last: 2019/10/17 13:33:55.09
  vrf: tenant1
  index 44 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 5e:ea:9a:51:1e:a1
  inet 10.244.6.1/24
  inet6 fe80::5cea:9aff:fe51:1ea1/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### Bridge cni1 in Tenant2
<cli>
root@server07:/home/cumulus# vtysh -c 'show int cni1'
Interface cni1 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 13:23:40.35
  Link downs:     1    last: 2019/10/17 13:23:40.35
  vrf: tenant2
  index 42 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: ea:6e:66:cd:48:48
  inet 10.244.6.1/24
  inet6 fe80::24f9:ecff:fe89:9d1a/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### Bridge cni2 in Tenant3
<cli>
root@server07:/home/cumulus# vtysh -c 'show int cni2'
Interface cni2 is up, line protocol is up
  Link ups:       2    last: 2019/10/17 13:23:36.06
  Link downs:     1    last: 2019/10/17 13:23:36.06
  vrf: tenant3
  index 43 metric 0 mtu 1450 speed 0
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  Type: Unknown
  HWaddr: 9a:02:0a:cd:a9:ea
  inet 10.244.6.1/24
  inet6 fe80::f403:40ff:fea0:a9c0/64
  Interface Type Bridge
  Bridge VLAN-aware: no
</cli>

### IP address of cni0
<cli>
root@server07:/home/cumulus# ifconfig cni0
cni0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.6.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::5cea:9aff:fe51:1ea1  prefixlen 64  scopeid 0x20<link>
        ether 5e:ea:9a:51:1e:a1  txqueuelen 1000  (Ethernet)
        RX packets 17  bytes 924 (924.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 30  bytes 2788 (2.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### IP address of cni1
<cli>
root@server07:/home/cumulus# ifconfig cni1
cni1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.6.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::24f9:ecff:fe89:9d1a  prefixlen 64  scopeid 0x20<link>
        ether ea:6e:66:cd:48:48  txqueuelen 1000  (Ethernet)
        RX packets 16  bytes 1008 (1.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 41  bytes 3442 (3.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### IP address of cni2
<cli>
root@server07:/home/cumulus# ifconfig cni2
cni2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.244.6.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::f403:40ff:fea0:a9c0  prefixlen 64  scopeid 0x20<link>
        ether 9a:02:0a:cd:a9:ea  txqueuelen 1000  (Ethernet)
        RX packets 53  bytes 3332 (3.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 51  bytes 4590 (4.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
</cli>

### Global routing table
<cli>
root@server07:/home/cumulus# ip route
10.250.250.10 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.11 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.12 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.14 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.15 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.16 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink
10.250.250.18 proto bgp metric 20
        nexthop via 169.254.0.1 dev eth1 weight 1 onlink
        nexthop via 169.254.0.1 dev eth2 weight 1 onlink

</cli>

## Tenant1
### Container IP of Container7 on Server7 and connectivity to Container1 on Server3 in VRF Tenant1
<cli>
root@server07:/home/cumulus# docker exec -it 31895b7013c9 sh
/ # ip a
3: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 0a:88:81:67:73:cb brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.142/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.2
PING 10.244.2.2 (10.244.2.2): 56 data bytes
64 bytes from 10.244.2.2: seq=0 ttl=62 time=2.601 ms
64 bytes from 10.244.2.2: seq=1 ttl=62 time=1.724 ms
64 bytes from 10.244.2.2: seq=2 ttl=62 time=1.776 ms
--- 10.244.2.2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.724/2.033/2.601 ms
</cli>

### Container IP of Container7 on Server7 and connectivity to Container4 on Server5 in VRF Tenant1
<cli>
root@server07:/home/cumulus# docker exec -it 31895b7013c9 sh
/ # ip a
3: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether 0a:88:81:67:73:cb brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.142/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.2
PING 10.244.4.2 (10.244.4.2): 56 data bytes
64 bytes from 10.244.4.2: seq=0 ttl=62 time=2.174 ms
64 bytes from 10.244.4.2: seq=1 ttl=62 time=1.355 ms
64 bytes from 10.244.4.2: seq=2 ttl=62 time=1.197 ms
--- 10.244.4.2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.197/1.575/2.174 ms
</cli>

## Tenant2
### Container IP of Container8 on Server7 and connectivity to Container2 on Server3 in VRF Tenant1
<cli>
root@server07:/home/cumulus# docker exec -it e7e120ff7275 sh
/ # ip a
3: eth0@if46: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether be:f7:bf:af:93:f8 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.143/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.3
PING 10.244.2.3 (10.244.2.3): 56 data bytes
64 bytes from 10.244.2.3: seq=0 ttl=62 time=2.699 ms
64 bytes from 10.244.2.3: seq=1 ttl=62 time=2.137 ms
64 bytes from 10.244.2.3: seq=2 ttl=62 time=1.943 ms
--- 10.244.2.3 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.943/2.259/2.699 ms
</cli>

### Container IP of Container8 on Server7 and connectivity to Container5 on Server5 in VRF Tenant1
<cli>
root@server07:/home/cumulus# docker exec -it e7e120ff7275 sh
/ # ip a
3: eth0@if46: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether be:f7:bf:af:93:f8 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.143/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.3
PING 10.244.4.3 (10.244.4.3): 56 data bytes
64 bytes from 10.244.4.3: seq=0 ttl=62 time=2.190 ms
64 bytes from 10.244.4.3: seq=1 ttl=62 time=1.303 ms
64 bytes from 10.244.4.3: seq=2 ttl=62 time=1.459 ms
--- 10.244.4.3 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.303/1.650/2.190 ms
</cli>

## Tenant3
### Container IP of Container9 on Server7 and connectivity to Container3 on Server3 in VRF Tenant1
<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.4
PING 10.244.2.4 (10.244.2.4): 56 data bytes
64 bytes from 10.244.2.4: seq=0 ttl=62 time=3.551 ms
64 bytes from 10.244.2.4: seq=1 ttl=62 time=2.790 ms
64 bytes from 10.244.2.4: seq=2 ttl=62 time=2.157 ms
--- 10.244.2.4 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.157/2.832/3.551 ms
</cli>

### Container IP of Container9 on Server7 and connectivity to Container6 on Server5 in VRF Tenant1
<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.4
PING 10.244.4.4 (10.244.4.4): 56 data bytes
64 bytes from 10.244.4.4: seq=0 ttl=62 time=1.652 ms
64 bytes from 10.244.4.4: seq=1 ttl=62 time=1.213 ms
64 bytes from 10.244.4.4: seq=2 ttl=62 time=1.308 ms
--- 10.244.4.4 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.213/1.391/1.652 ms
</cli>

## Cross connectivity
<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.2
PING 10.244.2.2 (10.244.2.2): 56 data bytes
--- 10.244.2.2 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
</cli>

<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.2.3
PING 10.244.2.3 (10.244.2.3): 56 data bytes
--- 10.244.2.3 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
</cli>

<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.2
PING 10.244.4.2 (10.244.4.2): 56 data bytes
--- 10.244.4.2 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
</cli>

<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.4.3
PING 10.244.4.3 (10.244.4.3): 56 data bytes
--- 10.244.4.3 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
</cli>

<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.6.142
PING 10.244.6.142 (10.244.6.142): 56 data bytes
--- 10.244.6.142 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
</cli>

<cli>
root@server07:/home/cumulus# docker exec -it ee9e54605d60 sh
/ # ip a
3: eth0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue state UP
    link/ether aa:1e:82:2a:b9:69 brd ff:ff:ff:ff:ff:ff
    inet 10.244.6.144/24 scope global eth0
       valid_lft forever preferred_lft forever
       
       
/ # ping 10.244.6.143
PING 10.244.6.143 (10.244.6.143): 56 data bytes
--- 10.244.6.143 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
</cli>
