## Deployment of a Kubernetes cluster through the chatflow

Within the 3bot Admin console, a chatflow has been created to reserve capacity to run Kubernetes cluster on. 

![kubernetes_chatflow1](img/kubernetes/Kubernetes_chatflow1.png) 

Through this chatflow, the kubernetes cluster is reserved and configured simply by collection of a number of parameters : 
- IPv4 vs. IPv6
- Number of worker nodes
- public ssh key (allowing to access the container using ssh)
- cluster secret
- network definition (choice between reuse of a netork that has been set up earlier or new one)
- ip addresses to access all workers

This information is sufficient to create the cluster.

![kubernetes_chatflow11](img/kubernetes/kubernetes_chatflow11.png)

If you choose to define a new network, this needs to be activated using Wireguard (see explanation on network).

![kubernetes_chatflow12](img/kubernetes/kubernetes_chatflow12.png)
![kubernetes_chatflow13](img/kubernetes/kubernetes_chatflow13.png)

Once this is done you can ssh into the virtual machine from your account that you used the ssh key from. 

![kubernetes_chatflow14](img/kubernetes/kubernetes_chatflow14.png)
![kubernetes_chatflow15](img/kubernetes/kubernetes_chatflow15.png)
