# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"
  config.ssh.pty = true
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: ".git/"


  ## AWS
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_EC2_KEYPAIR']

    aws.region = ENV['AWS_REGION']
    aws.instance_type = 'c3.2xlarge'
    case ENV['AWS_REGION']
    when 'ap-northeast-1'
      aws.ami = 'ami-4985b048' # Amazon Linux AMI 2014.09.1 (HVM)
    when 'us-east-1'
      aws.ami = 'ami-b66ed3de' # Amazon Linux AMI 2014.09.1 (HVM)
    else
      raise "Unsupported region #{ENV['AWS_REGION']}"
    end

    aws.tags = {
      'Name' => 'mosquitto 1.3.5 Amazon Linux2014.09 HVM'
    }
    aws.user_data = "#!/bin/bash\necho 'Defaults:ec2-user !requiretty' > /etc/sudoers.d/999-vagrant-cloud-init-requiretty && chmod 440 /etc/sudoers.d/999-vagrant-cloud-init-requiretty\n"

    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = ENV['AWS_EC2_KEYPASS']
  end


  config.vm.provision "file", source: "files/mosquitto.repo", destination: "mosquitto.repo"
  config.vm.provision :shell, :path => "bootstrap.sh"
#  config.vm.provision :shell, :path => "hotfix.sh"

end
