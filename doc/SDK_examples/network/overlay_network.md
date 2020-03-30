### Create an overlay network

In this example we will create an overlay network over a number of nodes in the TF Grid.  The nodes and locations can be researched on this explorer site:  http://explorer.grid.tf

#### Requirements

In order to be able to deploy this example deployment you will have to have the following components activated
- the 3bot SDK, in the form of a local container with the SDK, or a grid based SDK container.  Installation instuctions are here <<insert pointer to the linux of macos installation manuea>>
- if you use a locally installed container with the 3bot SDK you need to have the wireguard software installed.  Instructions to how to get his installed on your platform can be found [here](https://www.wireguard.com/install/)
- capacity reservation are not free so you will need to have some ThreeFold Tokens (TFT) to play around with.


#### 1. Mainnet nad Identity
First load you identity and make sure you are talking to the production explorer.  This is done by making sure you have set the default explorer to `explorer.grid.tf`.  Also you have to have an indentity set.



```bash
# Point the to the mainnet explorer
j.clients.threebot.explorer_addr_set('explorer.grid.tf')
```


```bash
me = j.tools.threebot.me.default
```

```
## jumpscale.threebot.me
ID: 1
 - name                : default
 - tid                 : 0
 - tname               : me
 - email               :
 - pubkey              :
 - admins              : ['weynandkuijpers.3bot']

```

#### 2. Load required libraries and create empty reservation structure

To be able to made a reservation we need to local the System Abstraction Layer (SAL) and create an empty reservation structure


```bash
# load the zero-os System Abstration Layer (SAL)
zos = j.sal.zosv2

# create empty reservation method
r = zos.reservation_create()
```

#### 3. Select overlay network addressing scheme and select nodes

In this example we added all the nodes from the salzburg, vienna, lochristi and munich are into one list.  You can shorten that list by selecting smaller sections of that list. For people that do not have IPv6 at home we need have at least one node on the network that has IPv4 access for the wireguard tunnel to terminate.  


```bash
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"



# create overlay network definition in datastructure called "network"
network = zos.network.create(r, ip_range=demo_ip_range, network_name=demo_network_name)

nodes_salzburg = zos.nodes_finder.nodes_search(farm_id=12775) # (IPv6 nodes)
nodes_vienna_1 = zos.nodes_finder.nodes_search(farm_id=82872) # (IPv6 nodes)
nodes_belgium = zos.nodes_finder.nodes_search(farm_id=1) # (IPv4 nodes, to be used as ingress/egress point.  These are not webgatewaysm, just nodes connected to the internet with IPv4 addresses)
nodes_munich = zos.nodes_finder.nodes_search(farm_id=50669) #(IPv6 nodes)

# nodes_all = nodes_salzburg + nodes_vienna_1 + nodes_belgium + nodes_munich
nodes_all = nodes_salzburg + nodes_vienna_1 + nodes_belgium + nodes_munich

# make sure to set a new port
for i, node in enumerate(nodes_all):
    if zos.nodes_finder.filter_is_up(node):
        iprange = f"172.20.{i+10}.0/24"
        zos.network.add_node(network, node.node_id , iprange, wg_port=demo_port)
        print(node.node_id, ":", iprange)
    else:
        print("Node", node.node_id,"is not up")
```

A handy function is available to create a wireguard configuration file to import to you local wireguard setup.


```bash
# Enter here the node_id for the node that is the IPv4 bridge to create the wireguard config.
wg_config = zos.network.add_access(network, 'CBDY1Fu4CuxGpdU3zLL9QT5DGaRkxjpuJmzV6V5CBWg4', '172.20.100.0/24', ipv4=True)

print("------------------------")
print(wg_config)
print("------------------------")
```

Copy the wireguard configuration to you local host on which the 3bot SDK is running and bring the woreguard interface up.  Instructions to do this are [here](https://www.wireguard.com/quickstart/)


```bash
# Set the duration for the reservation
import time

# Reservation period set in seconds. PLease adjust, this only allys for the network to exists for 5 seconds.
reservation_period=(5*60)
expiration = j.data.time.epoch + reservation_period

# Register the reservation.  All required data has been loaded in the reservation structrure: e
rid = zos.reservation_register(r, expiration, identity=me)
```

The returned number of the reservation number of the network reservation.  To retrieve the actual content of the reservation you can use the following command


```bash
# inspect the result of the reservation provisioning
result = zos.reservation_result(rid)

print("provisioning result")
print(result)
```


```bash

```


```bash

```


```bash

```


```bash

```
