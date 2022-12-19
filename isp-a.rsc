# dec/19/2022 23:16:13 by RouterOS 6.46.5
# software id = 
#
#
#
/interface bridge
add name=bridge1
add name=lobridge
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing bgp instance
set default as=10 router-id=3.3.3.3
/routing ospf area
set [ find default=yes ] disabled=yes
/routing ospf instance
set [ find default=yes ] disabled=yes
add distribute-default=always-as-type-1 name=ospf1 redistribute-connected=\
    as-type-1 router-id=3.3.3.3
/routing ospf area
add area-id=100.100.100.100 instance=ospf1 name=area1
/system logging action
set 3 remote=192.168.120.73 remote-port=8514 syslog-facility=syslog
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
/interface bridge settings
set use-ip-firewall=yes
/ip address
add address=172.16.1.1/24 interface=bridge1 network=172.16.1.0
add address=3.3.3.3 interface=lobridge network=3.3.3.3
/ip dhcp-client
add add-default-route=no disabled=no interface=ether1
/ip firewall nat
add action=masquerade chain=srcnat
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set irc disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
set udplite disabled=yes
set dccp disabled=yes
set sctp disabled=yes
/ip route
add distance=1 gateway=192.168.120.1
/ip traffic-flow
set cache-entries=64k enabled=yes
/ip traffic-flow target
add dst-address=192.168.120.73
/mpls ldp
set enabled=yes lsr-id=3.3.3.3 transport-address=3.3.3.3
/mpls ldp interface
add interface=bridge1
/routing bgp peer
add default-originate=always name=peer-to-isp2 remote-address=172.16.2.1 \
    remote-as=20
/routing ospf network
add area=area1 network=172.16.1.0/24
/system clock
set time-zone-name=Asia/Tehran
/system identity
set name=ISP1
/system logging
set 0 action=remote
set 1 action=remote
set 2 action=remote
set 3 action=remote
add action=remote topics=event
/system ntp client
set enabled=yes primary-ntp=162.159.200.123 secondary-ntp=121.174.142.81
