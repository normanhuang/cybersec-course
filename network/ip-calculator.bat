@echo off
rem Given a IP address and its subnet mask in CIDR notation,
rem Output subnet mask IP, network IP, useable range, and broadcast IP.
rem Authored by Norman Huang


Setlocal EnableDelayedExpansion

set /A "subnet_mask_octets[0]=0"
set /A "subnet_mask_octets[1]=0"
set /A "subnet_mask_octets[2]=0"
set /A "subnet_mask_octets[3]=0"

set /A "bitmap[0]=1"
set /A "bitmap[1]=2"
set /A "bitmap[2]=4"
set /A "bitmap[3]=8"
set /A "bitmap[4]=16"
set /A "bitmap[5]=32"
set /A "bitmap[6]=64"
set /A "bitmap[7]=128"

set /P ip="Enter a CIDR-format IP (x.x.x.x/y): "

for /f "tokens=1,2,3,4,5 delims=./" %%a in ("%ip%") do (
    set /A "ip_octets[0]=%%a, ip_octets[1]=%%b, ip_octets[2]=%%c, ip_octets[3]=%%d, prefix=%%e"
)

set /A "subnet_full_octets=%prefix%/8"
set /A "subnet_borrowed_bits=%prefix%%%8"

set /A octet_index=0


rem fill in the full subnet octets
:subnet_fill
    set /A "subnet_mask_octets[%octet_index%]=255"
    set /A octet_index+=1
    set /A subnet_full_octets-=1
if %subnet_full_octets% GTR 0 goto subnet_fill

:subnet_borrowed
if (!subnet_borrowed_bits! EQU 0) (
    goto network
) 
set /A "n=8-%subnet_borrowed_bits%"
set /A "subnet_mask_octets[%octet_index%]+=!bitmap[%n%]!"
set /A subnet_borrowed_bits-=1

if !subnet_borrowed_bits! GTR 0 goto subnet_borrowed

:network
echo Subnet mask: %subnet_mask_octets[0]%.%subnet_mask_octets[1]%.%subnet_mask_octets[2]%.%subnet_mask_octets[3]%

rem masking is implemented with a bitwise AND
set /A "network_ip[0]=%ip_octets[0]%&%subnet_mask_octets[0]%"
set /A "network_ip[1]=%ip_octets[1]%&%subnet_mask_octets[1]%" 
set /A "network_ip[2]=%ip_octets[2]%&%subnet_mask_octets[2]%" 
set /A "network_ip[3]=%ip_octets[3]%&%subnet_mask_octets[3]%" 
echo Network IP: %network_ip[0]%.%network_ip[1]%.%network_ip[2]%.%network_ip[3]%

rem range
set /A "range_ip[0]=(255-%subnet_mask_octets[0]%)+%network_ip[0]%"
set /A "range_ip[1]=(255-%subnet_mask_octets[1]%)+%network_ip[1]%"
set /A "range_ip[2]=(255-%subnet_mask_octets[2]%)+%network_ip[2]%"
set /A "range_ip[3]=(255-%subnet_mask_octets[3]%)+%network_ip[3]%-1"
set /A "broadcast_octet=(255-%subnet_mask_octets[3]%)+%network_ip[3]%"

set /A "useable_octet=%network_ip[3]%+1"
echo Useable Range:[%network_ip[0]%.%network_ip[1]%.%network_ip[2]%.%useable_octet%, %range_ip[0]%.%range_ip[1]%.%range_ip[2]%.%range_ip[3]%]

echo Broadcast IP: %range_ip[0]%.%range_ip[1]%.%range_ip[2]%.%broadcast_octet%