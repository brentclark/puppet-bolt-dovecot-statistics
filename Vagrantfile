$msg = <<MSG
------------------------------------------------------

bolt module install --force
cd src/ ; ./runme.sh

------------------------------------------------------
MSG

require 'vagrant-bolt'
vagrant_root = File.dirname(__FILE__)

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 4
      v.name = "vagrant-bolt-dovecot-statistics"
  end

  config.vm.box = "debian/bullseye64"
  config.vm.hostname = 'vagrant-bolt-dovecot-statistics'
  #config.vm.define =  "vagrant-bolt-dovecot-statistics"
  config.vm.post_up_message = $msg
  config.vm.network :forwarded_port, guest: 993, host: 993, host_ip: "127.0.0.1", auto_correct: true
  config.vm.network :forwarded_port, guest: 143, host: 143, host_ip: "127.0.0.1", auto_correct: true
  config.vm.synced_folder "#{vagrant_root}/src", "/home/vagrant/src", type: "sshfs"

  config.bolt.verbose = true
  config.bolt.debug   = true

  config.trigger.after :up do |trigger|
    trigger.name = "Bolt \"facts::bash\" after :up"
    trigger.ruby do |env, machine|
      VagrantBolt.plan("facts", env, machine)
    end
  end

  config.vm.provision :bolt do |bolt|
    #bolt.project = './src'
    bolt.command = :plan
    bolt.name = 'vagrant_bolt_dovecot_statistics::dovecot'
    bolt.run_as = "root"
  end

#    DEBIAN_FRONTEND=noninteractive apt-get -fy --no-install-suggests --no-install-recommends  install \
#    chrony git-core dnsutils vim dirmngr apt-transport-https cpanminus curl wget lsb-release \
#    libc6-dev gcc make rsync net-tools xfonts-utils fontconfig jq -fy
end
