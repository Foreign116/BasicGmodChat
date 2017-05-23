local rtBox = nil
local isOpen = false
local messages = ""
net.Receive("receiveMessage",function()

local message = net.ReadString()
local sender = net.ReadEntity()

messages = messages.."\n"..sender:Name().." : "..message 
if isOpen then 
rtBox:SetText(messages)
end 

end)
function OpenChat()
	isOpen = true
	local frame = vgui.Create("DFrame")
	frame:SetSize(500,500)
	frame:Center()
	frame:MakePopup()
	frame.OnClose = function(s)
		isOpen=false
		s:Remove()
	end
	local panel = vgui.Create("DPanel",frame)
	panel:SetPos(10,30)
	panel:SetSize(500-20,500-30-50)

	rtBox = vgui.Create("RichText",panel)
	rtBox:SetSize(500-20,500-30-50)
	rtBox:SetText(messages)

	local entry = vgui.Create("DTextEntry",frame)
	entry:SetPos(10,30+(500-30-50)+5)
	entry:SetSize(500-20,40)
	entry.OnEnter = function(s)
		net.Start("sendMessage")
		net.WriteString(s:GetText())
		net.SendToServer()
		s:SetText("")
		s:RequestFocus()

	end


end


hook.Add("OnPlayerChat","OpenChatMenu",function(ply,text)
if ply==LocalPlayer() then
	if string.lower(text)=="!chat" then
		OpenChat()
	end
end


end)