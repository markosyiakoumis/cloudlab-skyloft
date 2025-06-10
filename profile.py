"""This is a trivial example of a gitrepo-based profile; The profile source code and other software, documentation, etc. are stored in in a publicly accessible GIT repository (say, github.com). When you instantiate this profile, the repository is cloned to all of the nodes in your experiment, to `/local/repository`. 

This particular profile is a simple example of using a single raw PC. It can be instantiated on any cluster; the node will boot the default operating system, which is typically a recent version of Ubuntu.

Instructions:
Wait for the profile instance to start, then click on the node in the topology and choose the `shell` menu item. 
"""

import geni.portal as portal
import geni.rspec.pg as pg

pc = portal.Context()

request = pc.makeRequestRSpec()
 
node = request.RawPC("node")
node.hardware_type = "c6620"
node.component_manager_id = "urn:publicid:IDN+utah.cloudlab.us+authority+cm"
node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD"

node.addService(pg.Execute(shell="sh", command="/local/repository/init.sh"))

pc.printRequestRSpec(request)
