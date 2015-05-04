AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

function ENT:Initialize( )
 
	self:SetModel( "models/Humans/Group03m/male_07.mdl" )
	self:SetHullType( HULL_HUMAN ) 
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX ) 
	bit.bor( CAP_ANIMATEDFACE , CAP_TURN_HEAD) 
	self:SetUseType( SIMPLE_USE ) 
	self:DropToFloor()
 
	self:SetMaxYawSpeed( 90 ) 
 
end

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		umsg.Start("healmenu", Caller) 
		umsg.End() 
	end
end

if SERVER then 
	util.AddNetworkString( "HealNPC.SetHealth" ) 
	net.Receive( "HealNPC.SetHealth", function( bits, ply ) 

	local phealth = ply:Health()
		if ply:getDarkRPVar("money") < 180 then
			print( "You don't have enough money!.\n" )  
		else if ( phealth <= 99 ) then
			ply:SetHealth( 100 )
 			ply:addMoney( -180 )
	end
end

end )

end
  