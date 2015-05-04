include('shared.lua')
include('init.lua')
if CLIENT then

local function HealNPCM()

local medf = vgui.Create( "DFrame" )
medf:SetPos( 5, 5 )
medf:SetSize( 335, 180 )
medf:SetTitle( "Medic" )
medf:SetBackgroundBlur( true ) 
medf:Center( true ) 
medf:SetDraggable( false ) 
medf:MakePopup() 

local medp = vgui.Create( "DPanel", medf )
medp:SetPos( 6, 40 )
medp:SetSize( 60, 60 )
medp:SetBackgroundColor( Color(97,97,97,200) ) 

local medi = vgui.Create( "SpawnIcon", medp )
medi:SetPos( 6, 20 )
medi:SetSize( 60, 60 )
medi:SetModel( "models/Humans/Group03m/male_07.mdl" )
medi:Center( true ) 

local medt = vgui.Create(  "DLabel", medf ) 
medt:SetText( "Hello there civilian!\nWhat could I possibly do for you?" ) 
medt:SetPos( 120, 75 )  
medt:SizeToContents() 

local medb = vgui.Create( "Button", medf ) 
medb:SetText( "Heal Me! ($180)" ) 
medb:SetSize( 120, 25 ) 
medb:SetPos ( 195, 145 ) 
medb:SetVisible( true )
medb.DoClick = function( self ) 
	local phealth = LocalPlayer():Health()
	local pmoney = LocalPlayer():getDarkRPVar("money")

	if ( pmoney < 180 ) then
		notification.AddLegacy( "You don't have enough money!", NOTIFY_ERROR, 5 )
		surface.PlaySound( "buttons/button11.wav" )
		Msg( "You don't have the required funds\n" )
	
	elseif ( phealth <= 99 ) then
		notification.AddLegacy( "You've been healed!", NOTIFY_GENERIC, 5 )
		surface.PlaySound( "items/smallmedkit1.wav" )
		Msg( "You've been healed!\n" )
	else
		notification.AddLegacy( "You're already at full health!", NOTIFY_ERROR, 5 )
		surface.PlaySound( "buttons/button11.wav" )
		Msg( "You're already at full health!\n" )
	end
    net.Start( "HealNPC.SetHealth" ) 
    net.SendToServer()
    
	end
end
usermessage.Hook("healmenu",HealNPCM) 


SNPC = SNPC or {}

function SNPC.DrawText()
	for _, ent in pairs (ents.FindByClass("heal_npc")) do
		local Ang = ent:GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), -90)
		
		cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
			draw.SimpleText( 'Medic', "ChatFont", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		cam.End3D2D()
			
		Ang:RotateAroundAxis( Ang:Right(), -180)
		
		cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
			draw.SimpleText( 'Medic', "ChatFont", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
		cam.End3D2D()
	end
end
hook.Add("PostDrawOpaqueRenderables", "NPC_TEXT", SNPC.DrawText)

end