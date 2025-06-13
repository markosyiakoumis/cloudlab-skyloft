# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg

# Create a portal object.
pc = portal.Context()
# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

pc.defineParameter("schbench", "Execute schbench", portal.ParameterType.BOOLEAN, True)
pc.defineParameter("synthetic-single", "Execute synthetic-single", portal.ParameterType.BOOLEAN, True)
pc.defineParameter("synthetic-multiple", "Execute synthetic-multiple", portal.ParameterType.BOOLEAN, True)
pc.defineParameter("memcached", "Execute memcached", portal.ParameterType.BOOLEAN, True)
pc.defineParameter("rocksdb", "Execute rocksdb", portal.ParameterType.BOOLEAN, True)
pc.defineParameter("preempt", "Execute preempt", portal.ParameterType.BOOLEAN, True)
pc.defineParameter("thread", "Execute thread", portal.ParameterType.BOOLEAN, True)

params = pc.bindParameters()

server = request.RawPC("server")
server.hardware_type = "c6620"
server.component_manager_id = "urn:publicid:IDN+utah.cloudlab.us+authority+cm"
server.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"

# Attach server initialization script.
server.addService(pg.Execute(shell="bash", command="sudo /local/repository/scripts/server/init.sh"))

client = request.RawPC("client")
client.hardware_type = "c220g1"
client.component_manager_id = "urn:publicid:IDN+wisc.cloudlab.us+authority+cm"
client.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU20-64-STD"

# Attach client initialization script.
#client.addService(pg.Execute(shell="bash", command="/local/repository/scripts/client/init.sh"))

pc.printRequestRSpec(request)
