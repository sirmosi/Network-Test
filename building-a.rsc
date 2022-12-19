# dec/19/2022 23:13:59 by RouterOS 6.46.5
# software id = 
#
#
#
/interface bridge
add name=lobridge
/interface vrrp
add interface=ether2 name=vrrp1 vrid=50
add interface=ether3 name=vrrp2 vrid=60
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing bgp instance
set default as=100 disabled=yes
/routing ospf area
set [ find default=yes ] disabled=yes
/routing ospf instance
set [ find default=yes ] disabled=yes redistribute-connected=as-type-1 \
    router-id=1.1.1.1
add name=ospf1 redistribute-connected=as-type-1 redistribute-other-ospf=\
    as-type-1 router-id=1.1.1.1
add name=ospf2 redistribute-connected=as-type-1 redistribute-other-ospf=\
    as-type-1 router-id=1.1.1.1
/routing ospf area
add area-id=100.100.100.100 instance=ospf1 name=area1
add area-id=200.200.200.200 instance=ospf2 name=area2
/ip address
add address=10.10.1.2/24 interface=ether2 network=10.10.1.0
add address=10.10.1.100 interface=vrrp1 network=10.10.1.100
add address=10.20.1.100 interface=vrrp2 network=10.20.1.100
add address=10.20.1.2/24 interface=ether3 network=10.20.1.0
add address=172.16.1.100/24 interface=ether4 network=172.16.1.0
add address=172.16.2.100/24 interface=ether1 network=172.16.2.0
add address=1.1.1.1 interface=lobridge network=1.1.1.1
/ip dhcp-client
add disabled=no interface=ether3
/ip firewall nat
add action=masquerade chain=srcnat disabled=yes
/ip traffic-flow
set enabled=yes
/ip traffic-flow target
add dst-address=192.168.120.73
/mpls ldp
set enabled=yes lsr-id=1.1.1.1 transport-address=1.1.1.1
/mpls ldp interface
add interface=ether4
add interface=ether1
/routing ospf network
add area=area1 network=10.10.1.0/24
add area=area1 network=10.20.1.0/24
add area=area2 network=10.10.1.0/24
add area=area2 network=10.20.1.0/24
add area=area1 network=172.16.1.0/24
add area=area2 network=172.16.2.0/24
/system clock
set time-zone-name=Asia/Tehran
/system identity
set name=B1
/system ntp client
set enabled=yes primary-ntp=169.19.200.129 secondary-ntp=121.174.142.81
