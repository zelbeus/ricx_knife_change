
local edited = nil
local knife_weapon
function GetCurrentPedWeaponEntityIndex(ped, p1)
    return Citizen.InvokeNative(0x3B390A939AF0B5FC, ped, p1)
end
--Usage while WEAPON_MELEE_KNIFE is in hand: "/change_k [number 1-32]" example: "/change_k 1"
RegisterCommand("change_k", function(source, args, raw)
    if edited ~= nil then 
        DeleteObject(edited)
    end
    local cc = GetEntityCoords(PlayerPedId())
    knife_weapon = GetCurrentPedWeaponEntityIndex(PlayerPedId(), 0)
    local a,b = GetCurrentPedWeapon(PlayerPedId(), 1, 0, 1)

    if not knife_weapon or b ~= -618550132 then
        return print("no knife")
    end
    local k_models = {
        `w_melee_knife03`,
        `s_melee_knife05`,
        `w_melee_knife18`,
        `p_melee_knife09_cs`,
        `w_melee_knife04`,
        `w_melee_knife15`,
        `s_cs_knifeangel01x`,
        `p_melee_knife01`,
        `p_hoofknife01x`,--works 9
        `w_melee_knife01`,
        `w_melee_knife02`,
        `w_melee_knife05`,
        `w_melee_knife06`,
        `w_melee_knife06`,
        `w_melee_knife07`,
        `w_melee_knife08`,
        `w_melee_knife09`,
        `w_melee_knife10`,
        `w_melee_knife11`,
        `w_melee_knife12`,
        `w_melee_knife13`,
        `w_melee_knife14`,
        `w_melee_knife15`,
        `w_melee_knife16`,
        `w_melee_knife17`,
        `w_melee_knife18`,
        `w_melee_knife19`,
        `w_melee_knife20`,
        `w_melee_knife21`,
        `w_melee_knife22`,  
        `mp008_p_knife_ceremonial01`,  
        `mp008_p_knife_ceremonial01_blood`,  
    }

    local model = k_models[tonumber(args[1])]
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    SetEntityAlpha(knife_weapon, 0)
    edited = CreateObject(model, cc.x, cc.y, cc.z, true, true, false)
    SetModelAsNoLongerNeeded(model)
    AttachEntityToEntity(edited, knife_weapon, 0, vector3(0.0, 0, 0.0), vector3(0.0, 0.0, 0.0), false, false, false, false, 0, true, false, false)
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if edited ~= nil then 
        SetEntityAlpha(knife_weapon, 255)
        DeleteObject(edited)
    end
end)
