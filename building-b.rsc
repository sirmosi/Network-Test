# dec/20/2022 08:59:09 by RouterOS 6.46.5
# software id = 
#
#
#
/interface bridge
add name=lobridge
/interface vrrp
add interface=ether3 name=vrrp1 priority=80 vrid=50
add interface=ether4 name=vrrp2 priority=80 vrid=60
/routing ospf area
set [ find default=yes ] disabled=yes
/routing ospf instance
set [ find default=yes ] disabled=yes redistribute-connected=as-type-1 \
    router-id=2.2.2.2
add name=ospf1 redistribute-connected=as-type-1 router-id=2.2.2.2
add name=ospf2 redistribute-connected=as-type-1 router-id=2.2.2.2
/routing ospf area
add area-id=100.100.100.100 instance=ospf1 name=area1
add area-id=200.200.200.200 instance=ospf2 name=area2
/system logging action
set 3 remote=127.0.0.1 remote-port=8514
/ip address
add address=10.20.1.3/24 interface=ether4 network=10.20.1.0
add address=10.10.1.3/24 interface=ether3 network=10.10.1.0
add address=10.10.1.100 interface=vrrp1 network=10.10.1.100
add address=10.20.1.100 interface=vrrp2 network=10.20.1.100
add address=172.16.1.200/24 interface=ether5 network=172.16.1.0
add address=172.16.2.200/24 interface=ether6 network=172.16.2.0
add address=2.2.2.2 interface=lobridge network=2.2.2.2
/ip traffic-flow
set enabled=yes
/ip traffic-flow target
add dst-address=127.0.0.1
/mpls ldp
set enabled=yes lsr-id=2.2.2.2 transport-address=2.2.2.2
/mpls ldp interface
add interface=ether6
add interface=ether5
/routing ospf network
add area=area1 network=10.10.1.0/24
add area=area2 network=10.10.1.0/24
add area=area2 network=10.20.1.0/24
add area=area1 network=10.20.1.0/24
add area=area1 network=172.16.1.0/24
add area=area2 network=172.16.2.0/24
/system clock
set time-zone-name=Asia/Tehran
/system logging
set 0 action=remote
set 1 action=remote
set 2 action=remote
set 3 action=remote
/system ntp client
set enabled=yes primary-ntp=162.19.200.123 secondary-ntp=121.174.142.81
