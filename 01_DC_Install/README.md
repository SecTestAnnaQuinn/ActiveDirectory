# 01 Installing the Domain Controller

1. Use 'sconfig' to:
    - Change the hostname
    - Change the IP address to Static
    - Chenge the DNS server to our own IP address

2. Install the Active Directory Windows Feature

```shell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

import-Module ADDSDeployment

Install-ADDSForest

```
3. Configure Active Directory
    - Established Butterfree.com as Domain
    - Set SafeModeAdministratorPassword
    - After reset, we need to change the DNS Server address, as it is incorrectly listed as a loopback

```shell
Set-DNSClientServerAddress -InterfaceIndex *number*  -ServerAddresses *ipofchoice*

```
4. Join Workstation to Butterfree Domain
    - Set machine to use AD Controller as DNS
    - Access Work or School
    - Join the Butterfree domain