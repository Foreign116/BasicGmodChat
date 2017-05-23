util.AddNetworkString("sendMessage")
util.AddNetworkString("receiveMessage")

net.Receive("sendMessage",function(len,ply)

local message = net.ReadString()
net.Start("receiveMessage")
net.WriteString(message)
net.WriteEntity(ply)
net.Broadcast()


end)