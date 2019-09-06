#!/usr/bin/env bash

INT_NAME="${1}"
VLAN_ID="${2}"

manual() {
	ip link add link ${INT_NAME} name ${INT_NAME}.$VLAN_ID type vlan id $VLAN_ID
}

dhcp() {
	dhclient ${INT_NAME}.$VLAN_ID
}

delete(){
	ip link del link ${INT_NAME} name ${INT_NAME}.$VLAN_ID
}


if [ -z "$INT_NAME" ] || [ -z "$VLAN_ID" ]
then
	echo "Usage: $0 [ INTERFACE NAME ] [ VLAN ID ] { m[anual] | dh[cp] | d[el] }
Example for create vlan 10 with dhcp: $0 10 dh"
else
	case "$3" in
		m|manual)		manual ;;
		dh|dhcp)		manual; dhcp ;;
		d|del)			delete ;;
		*)			echo "Usage: $0 [ INTERFACE NAME ] [ VLAN ID ] m[anual] | dh[cp] | d[el]" >&2
					exit 1 ;;
	esac
fi
