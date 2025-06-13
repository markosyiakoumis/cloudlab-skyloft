import geni.portal as portal
import geni.rspec.pg as pg

pc = portal.Context()
request = pc.makeRequestRSpec()
 
server = request.RawPC("server")
server.hardware_type = "c6620"
server.component_manager_id = "urn:publicid:IDN+utah.cloudlab.us+authority+cm"
server.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"

# Clone Skyloft's AE repository
server.addService(pg.Install(url="https://github.com/yhtzd/archive/main.tar.gz", path="/local"))
# Clone Skyloft's modified kernel
server.addService(pg.Install(url="https://github.com/yhtzd/uintr-linux-kernel/archive/skyloft.tar.gz", path="/local"))
# Clone Skyloft's modified DPDK
server.addService(pg.Install(url="https://github.com/yhtzd/dpdk/archive/main.tar.gz", path="/local"))
# Clone Skyloft
server.addService(pg.Install(url="https://github.com/yhtzd/skyloft/archive/main.tar.gz", path="/local"))

# Execute server setup script
server.addService(pg.Execute(shell="bash", command="/local/repository/scripts/server.sh"))

client = request.RawPC("client")
client.hardware_type = "c220g1"
client.component_manager_id = "urn:publicid:IDN+wisc.cloudlab.us+authority+cm"
client.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU20-64-STD"

# Clone Skyloft's modified Shenango
client.addService(pg.Install(url="https://github.com/yhtzd/shenango-client/archive/master.tar.gz", path="/local"))

# Execute client setup script
client.addService(pg.Execute(shell="bash", command="/local/repository/scripts/client.sh"))

pc.printRequestRSpec(request)
