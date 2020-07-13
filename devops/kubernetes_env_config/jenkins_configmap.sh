# ConfigMaps Variables 
configmap_file="jenkins_configmap.yaml"
service_name="jenkins-admin"
namespace="default"


kube_server=$(kubectl config view -o jsonpath='{.clusters[*].cluster.server}')
secret_name=$(kubectl get serviceaccount -n "$namespace" -o jsonpath="{.items[?(@.metadata.name=='$service_name')].secrets[*].name}")
ca=$(kubectl get secret "$secret_name" -n "$namespace" -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret "$secret_name" -n "$namespace" -o jsonpath='{.data.token}' | base64 --decode)

# Generate a ConfigMap yaml file
cat <<EOF > ./$configmap_file 
apiVersion: v1
kind: ConfigMap 
metadata:
  name: jenkins-configmap
  namespace: default   
data:
  config: | 
      apiVersion: v1
      kind: Config
      clusters:
      - name: default-cluster
        cluster:
          certificate-authority-data: ${ca}
          server: ${kube_server}
      contexts:
      - name: default-context
        context:
          cluster: default-cluster
          namespace: default
          user: ${service_name}
      current-context: default-context
      users:
      - name: ${service_name}
        user:
          token: ${token}
EOF
# Create jenkins configmap 
kubectl create -f ./jenkins_configmap.yaml

# Delete the configmap file
rm -f $configmap_file
