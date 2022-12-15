# dec/15/2022 23:03:00 by RouterOS 6.46.5
# software id = 
#
#
#
/interface bridge
add name=bridge1
add name=lobridge
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing ospf area
set [ find default=yes ] disabled=yes
/routing ospf instance
set [ find default=yes ] disabled=yes
add disabled=yes name=ospf1 router-id=4.4.4.4
add distribute-default=if-installed-as-type-1 name=ospf2 \
    redistribute-connected=as-type-1 router-id=4.4.4.4
/routing ospf area
add area-id=100.100.100.100 instance=ospf1 name=area1
add area-id=200.200.200.200 instance=ospf2 name=area2
/system logging action
set 3 remote=192.168.120.73 remote-port=8514
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
/ip address
add address=172.16.2.1/24 interface=bridge1 network=172.16.2.0
add address=4.4.4.4 interface=lobridge network=4.4.4.4
/ip dhcp-client
add disabled=no interface=ether1
/ip firewall mangle
add action=mark-routing chain=prerouting disabled=yes dst-address=0.0.0.0/0 \
    new-routing-mark=test passthrough=yes
/ip firewall nat
add action=masquerade chain=srcnat to-addresses=192.168.120.1
/ip route
add distance=1 gateway=192.168.120.1 routing-mark=test
/ip traffic-flow
set enabled=yes
/ip traffic-flow target
add dst-address=192.168.120.73
/mpls ldp
set enabled=yes lsr-id=4.4.4.4 transport-address=4.4.4.4
/mpls ldp interface
add interface=bridge1
/routing ospf network
add area=area2 network=172.16.2.0/24
/system clock
set time-zone-name=Asia/Tehran
/system identity
set name=ISP2
/system logging
set 0 action=remote
set 1 action=remote
set 2 action=remote
set 3 action=remote
/system ntp client
set enabled=yes primary-ntp=162.159.200.123 secondary-ntp=121.174.142.81
