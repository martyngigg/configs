# Install VirtualBox
brew install --cask virtualbox

# Install Vagrant
brew install vagrant
# vbguest plugin to manage VirtualBox Guest Additions on the VM
vagrant plugin install vagrant-vbguest
# disksize plugin to manage VirtualBox disk size on the VM
vagrant plugin install vagrant-disksize

# Install Docker CLI
brew install docker docker-compose

# Save IP to a hostname. This value must match IP_ADDR in the docker-engine Vagrantfile
DOCKER_ENGINE_IP=192.168.63.4
echo "$DOCKER_ENGINE_IP docker.local" | sudo tee -a /etc/hosts > /dev/null

# Set to docker cli to talk to VM
echo "export DOCKER_HOST=tcp://$DOCKER_ENGINE_IP:2375" | tee -a ~/.zshrc > /dev/null
