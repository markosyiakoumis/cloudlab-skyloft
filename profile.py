import geni.portal as portal
import geni.rspec.pg as pg

pc = portal.Context()
request = pc.makeRequestRSpec()
 
server = request.RawPC("server")
server.hardware_type = "c6620"
server.component_manager_id = "urn:publicid:IDN+utah.cloudlab.us+authority+cm"
server.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"
server.addService(pg.Execute(shell="sh", command="/local/repository/scripts/server.sh"))

client = request.RawPC("client")
client.hardware_type = "c220g1"
client.component_manager_id = "urn:publicid:IDN+wisc.cloudlab.us+authority+cm"
client.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"
client.addService(pg.Execute(shell="sh", command="/local/repository/scripts/client.sh"))

pc.printRequestRSpec(request)
