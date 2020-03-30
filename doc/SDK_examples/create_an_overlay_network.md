### Create an overlay network

In this example we will create an overlay network over a number of nodes in the TF Grid.


```bash
me = j.tools.threebot.me.mainnet
j.clients.threebot.explorer_addr_set('explorer.grid.tf')

# create overlay network definition in datastructure called "network"
network = zos.network.create(r, ip_range="172.20.0.0/16", network_name="weynand_testnet_20")

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
        print("Node", node.node_id,"is up")
        zos.network.add_node(network, node.node_id , iprange, wg_port='8030')
        print(node.node_id, ":", iprange)
    else:
        print("Node", node.node_id,"is not up")
        
# Enter here the node_id for the node that is the IPv4 bridge to create the wireguard config.
wg_config = zos.network.add_access(network, 'CBDY1Fu4CuxGpdU3zLL9QT5DGaRkxjpuJmzV6V5CBWg4', '172.20.100.0/24', ipv4=True)

print("wireguard configuration")
print(wg_config)
print("provisioning result")
print(result)

# Set the duration for the reservation
import time
expiration = j.data.time.epoch + (4*7*24*60*60)

# register the reservation
rid = zos.reservation_register(r, expiration, identity=me)
time.sleep(5)

# inspect the result of the reservation provisioning
result = zos.reservation_result(rid)
```
