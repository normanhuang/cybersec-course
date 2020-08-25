# Network Security
Fundamentals of networks, protocols and network devices (Cisco routers and switches more specifically).
A collection of notes, learnings, scripts, and other artifacts to help with understanding network security

### ip-calculator.bat
This is a simple IP calculator written in Batch. Given a IP with its subnet mask in CIDR format (x.x.x.x/y), it will output the subnet mask IP, the network ID, the useable IP range of that network, and its corresponding broadcast IP.
1. On Windows, you can add the script to your %PATH% or run it from wherever you saved it.
1. When prompted, enter the IP address with its corresponding subnet mask.
```
Enter a CIDR-format IP (x.x.x.x/y): 192.168.0.129/25
Subnet mask: 255.255.255.128
Network IP: 192.168.0.128
Useable Range:[192.168.0.129, 192.168.0.254]
Broadcast IP: 192.168.0.255
Press any key to continue . . .
```
