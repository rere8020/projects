# Generate SSH Key
if [[ ! -f "$HOME/.ssh/id_rsa.pub" ]];then
    ssh-keygen -m PEM -t rsa -b 4096 -q -N '' -f ~/.ssh/id_rsa
fi

# Removing a remote state file temporary
rm -f terraform.tf

# Terraform config
terraform init
terraform plan
terraform apply

# Execute Jenkins ConfigMaps script
chmod +x kubernetes_env_config/jenkins_configmap.sh
kubernetes_env_config/jenkins_configmap.sh
wget https://raw.githubusercontent.com/abujoj-upwork/devops/master/terraform.tf
terraform init
rm -f terraform.tfstate terraform.tfstate.backup
