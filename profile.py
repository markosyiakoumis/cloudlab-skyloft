# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg

# Create a portal object.
pc = portal.Context()
# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

experiments = [
    ("memcached", True),
    ("thread", True)
]

for name, default in experiments:
    pc.defineParameter(name, name, portal.ParameterType.BOOLEAN, default)

params = pc.bindParameters()
enabled_experiments = [name for name, default in experiments if getattr(params, name)]
experiments_arg = ",".join(enabled_experiments)

server = request.RawPC("server")
server.hardware_type = "c6620"
server.component_manager_id = "urn:publicid:IDN+utah.cloudlab.us+authority+cm"
server.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"

# Attach server initialization and experiment scripts.
server.addService(pg.Execute(shell="bash", command="sudo /local/repository/server/startup.sh"))
server.addService(pg.Execute(shell="bash", command="sudo /local/repository/server/experiment-setup.sh --experiments=" + experiments_arg))

client = request.RawPC("client")
client.hardware_type = "c220g1"
client.component_manager_id = "urn:publicid:IDN+wisc.cloudlab.us+authority+cm"
client.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU20-64-STD"

# Attach client initialization script.
#client.addService(pg.Execute(shell="bash", command="/local/repository/scripts/client/init.sh"))

pc.printRequestRSpec(request)
