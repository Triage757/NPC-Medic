if ( CLIENT ) then return end

//Set NPC Coords
local hnpc_pos = Vector(-1778.700439, -692.058228, -131.968750)  //Set your Vector here. 
local hnpc_ang = Angle(0, -90, 0) //Set your Angle here.


hook.Add( "InitPostEntity", "healnpc_spawn", function()
    local healnpc = ents.Create( "heal_npc" )
    healnpc:SetPos( hnpc_pos ) //Do not TOUCH
    healnpc:SetAngles( hnpc_ang ) //Do not TOUCH, just don't mess with none of this acutally. 
    healnpc:Spawn()
    healnpc:DropToFloor()
end)

