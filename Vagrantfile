Vagrant.configure("2") do |config|
    config.vm.box = "bento/centos-7.7"
    config.vm.provision "shell", path: "install.sh", privileged: true

    (1..4).each do |i|
        config.vm.define "minio0#{i}" do |minio|
            minio.vm.hostname = "minio0#{i}"
            minio.vm.network "private_network", ip: "172.20.20.2#{i}"
        end 
    end
  end