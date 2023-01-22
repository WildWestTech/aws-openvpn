# aws-openvpn
create an openvpn server in aws

## Console Steps Before You Begin
- Console -> EC2 -> Key Pairs -> Create Key Pair
    - Name: openvpn
    - Key Pair Type: RSA
    - Private Key File Format: .pem
    - Tag:
        - Name: openvpn-pem-keys
    - Download Key Pair (should happen automatically)

- Run the terraform script
    - be prepared for an error on your first run
    - see next step

- Accept Terms
    - it seems there is a forced one-time console agreement for using this product
    - per stackoverflow, there is a request to add this feature
    - https://github.com/hashicorp/terraform-provider-aws/issues/17146
    - for now, just follow the prompt (there should be a link to follow)

- Run the terraform script again to complete the build

- More Console Stuff
    - navigate to the instance (in EC2)
    - click on the "connect" button
    - copy the ssh command provided under the "ssh client" section
        - it should look something like this
            - ssh -i "openvpn-pem-keys.pem" root@ec2-12-34-56-78.compute-1.amazonaws.com
    - open your terminal and run the command provided (you may need to point to where you downloaded the key file)
    - accept the terms
    - now run the same command again, but this time, login as openvpnas
    - time to update the password
        - i recommend using a password generator (https://passwordsgenerator.net/)
        - sudo passwd openvpn
            - enter your password
            - confirm password
    - navigate to your public ipv4 address
        - https://your-public-ip:943
        - login to the admin portal
    - VPN Settings
        - Routing
            - Should client Internet traffic be routed through the VPN? Yes
            - Save Settings (scroll down)
            - Update Running Server (scroll up)
    - navigate back back here 
        - https://your-public-ip:943
        - grab your preferred method of connection
            - i already have an openvpn, so i just grabbed the connection profile
            - if you don't have a client, pick one of the clients to download


