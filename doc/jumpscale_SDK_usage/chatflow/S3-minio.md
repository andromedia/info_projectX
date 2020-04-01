Within the 3bot Admin console, a chatflow has been created to reserve S3 storage capacity. 
This storage can be dispersed over different nodes. 

![minio_chatflow1](images/minio/Minio_chatflow1.png)

Through this chatflow, S3 storage is reserved and configured simply by collection of a number of parameters : 
- IPv4 vs. IPv6
- Password to be used for the 0-db storage
- Disk type : SSD or HDD
- Mode : user or sequential
- Minio login key
- Secret to match the previous key
- Amount of CPUs needed
- Memory size needed (in GB)
- Number of data drives to be used for spreading the data
- Number of parity drives
- Network definition (existing or new)
- If new network : IP range to be used (self-selected or generated)
- Network name (in case network is meant to be reused)
- IP address to access the storage

This information is sufficient to create the workload on the network.

![minio_chatflow17](images/minio/Minio_chatflow17.png)

The network might yet be set up, using Wireguard.
For ubuntu machines, you get command line instruction: 
![minio_chatflow17](images/minio/Minio_chatflow17.png)

On MacOS, the Wireguard configuration can be set up through the Wireguard application : 
- Download the configuration into a file
![minio_chatflow19](images/minio/Minio_chatflow19.png)

- load this into Wireguard tunnel 
![minio_chatflow20](images/minio/Minio_chatflow20.png)

Finally, the location of the workload is shown : 
![minio_chatflow21](images/minio/Minio_chatflow21.png)
