import geni.portal as portal
import geni.rspec.pg as pg

pc = portal.Context()
request = pc.makeRequestRSpec()
 
server = request.RawPC("server")
server.hardware_type = "c6620"
server.component_manager_id = "urn:publicid:IDN+utah.cloudlab.us+authority+cm"
server.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"
server.addService(pg.Execute(shell="sh", command="/local/repository/server.sh"))

client = request.RawPC("client")

pc.printRequestRSpec(request)
