# Cumulus Routing on the Host Docker Advertisement daemon (CRoHDAd) - Ethernet Virtual Private Network (EVPN)
In this github project the CRoHDAd was used in combination with EVPN in order to advertise host (/32) routes of containers on one node to other nodes in a spine leaf data center environment. This was done through an VXLAN overlay between the nodes. Furthermore, the nodes were shared by multiple tenants. In order to allow for the sharing of resources, but maintain security and privacy of those tenants a Virtual Routing and Forwarding (VRF) table was created per tenant. This VRF table contains only the routes of that tenant its containers. Meaning, the tenant does not know about other tenants and how to reach them. Also a virtual bridge per tenant was used, to avoid L2 sniffing, since the other tenants could be potentially malicious.


![image](images/Architecture.png)
