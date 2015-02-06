#installs bitcoind
include_recipe "chef-bitcoind"

# directory "/opt/bitcoind/blocks" do 
#   owner 'bitcoind'
#   group 'bitcoind'
#   action :create
# end
# 
# execute "seed-blocks" do #cannot use remote_file as /tmp is too small
#   command "wget https://s3-eu-west-1.amazonaws.com/simonbettison/public/blocks.tgz -O /opt/bitcoind/blocks.tgz"
#   not_if "du /opt/bitcoind/bootstrap.dat.old 2>/dev/null | grep 22037232"
# end


#starts bitcoind
#include_recipe "chef-bitcoind::configure"

# directory "/home/ubuntu/.bitcoin" do
#   owner 'ubuntu'
#   group 'ubuntu'
#   action :create
# end
# 
# link "/home/ubuntu/.bitcoin/bitcoin.conf" do
#   to '/opt/bitcoind/bitcoin.conf'
#   owner 'ubuntu'
#   group 'ubuntu'
#   action :create
# end
