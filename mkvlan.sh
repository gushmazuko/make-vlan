#!/usr/bin/env bash

int_name="eth0"
VLAN_ID="${1}"

manual() {
	sudo ip link add link ${int_name} name ${int_name}.$VLAN_ID type vlan id $VLAN_ID
}

dhcp() {
	sudo dhclient ${int_name}.$VLAN_ID
}

delete(){
	sudo ip link del link ${int_name} name ${int_name}.$VLAN_ID
}


if [ -z "$VLAN_ID" ]
then
	echo "Usage: $0 [ VLAN ID ] { m[anual] | dh[cp] | d[el] }
Example for create vlan 10 with dhcp: $0 10 dh"
else
	case "$2" in
		m|manual)		manual ;;
		dh|dhcp)		manual; dhcp ;;
		d|del)		delete ;;
		*)			echo "Usage: $0 [ VLAN ID ] m[anual] | dh[cp] | d[el]" >&2
					exit 1 ;;
	esac
fi
