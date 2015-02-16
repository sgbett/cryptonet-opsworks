#install dependencies
%w[build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev].each do |pkg|
  package pkg do
    action :install
  end
end

#checkout correct version of bitcoin
git "#{node['cryptonet-opsworks']['bitcoind']['src_prefix']}/bitcoin" do
  repository "https://github.com/bitcoin/bitcoin.git"
  revision node['cryptonet-opsworks']['bitcoind']['revision']
  action :sync
end

bash "build-and-install-bitcoind" do
  cwd "#{node['cryptonet-opsworks']['bitcoind']['src_prefix']}/bitcoin"
  code <<-EOF
    ./autogen.sh
    ./configure --disable-wallet
    make
    make install
  EOF
end
  
#setup config file
directory "/home/ubuntu/.bitcoin" do
  owner 'ubuntu'
  group 'ubuntu'
  action :create
end

template '/home/ubuntu/.bitcoin/bitcoin.conf' do
  owner 'ubuntu'
  group 'ubuntu'
  action :create
end

#set permissions on /bitcoin folder
directory "/bitcoin" do 
  owner 'ubuntu'
  group 'ubuntu'
  action :create
end

#start as service
template "/etc/init/bitcoind.conf" do
  source "bitcoind.upstart.erb"
  mode 0644
end

service 'bitcoind' do
  provider Chef::Provider::Service::Upstart
  action :start
end