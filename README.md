# cryptonet-opsworks-cookbook

Cookbook for use on AWS OpsWorks containing recipe to set up bitcoin full node for relaying transactions.

The bitcoind recipe downloads and installs dependencies for bitcoin, then grabs bitcoin source from github and builds it without the wallet options. 
It then automatically configures and runs the bitcoind service as the default ubuntu user with a datadir of /bitcoin
You should mount an EBS volume here so that you dont have re-download the blockchain if you reboot the instance.

## Supported Platforms

Ubuntu 14.04 on AWS Opsworks

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt></tt></td>
    <td></td>
    <td></td>
    <td><tt></tt></td>
  </tr>
</table>

## Usage

Set up a new opsworks stack and configure it as follows:
Deafult Operating System: Ubuntu 14.04 LTS
(Under Advanced)
Use Custom chef cookbooks: yes
Repository URL: https://github.com/sgbett/cryptonet-opsworks.git
Use OpsWorks security groups no

Once you have created your stack, you need to 'Add a Layer' and configure it as follows:
Layer type: Custom 
Name: bitcoin
Short Name: bitcoin
Custom security groups: default

Once you have added the layer go to 'recipes', then 'edit'...
Under Custom Chef Recipes, setup, add the recipe:
cryptonet-opsworks::bitcoind
Then save your changes

Go to EBS volumes, then 'edit'...
Add an EBS volume on /bitcoin with enough room to store the blockchain, and allow for some growth. 100GB should get things started.

Spin up instances in the custom layer and wait a while!

You'll also need to make sure that the default security group has port 8333 open to 0.0.0.0/0 so other people can connect to your node.

You can check the status of your node at: https://getaddr.bitnodes.io

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Simon Bettison (simon@bettison.org)