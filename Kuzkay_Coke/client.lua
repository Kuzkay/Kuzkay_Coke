

ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

local locations = {}


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local spawned = false
Citizen.CreateThread( function()
Citizen.Wait(10000)
while true do
Citizen.Wait(1000)
	if GetDistanceBetweenCoords(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z, GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if spawned == false then
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
			TriggerEvent('KCoke:start')
		end
		spawned = true
	else
		if spawned then
			locations = {}
		end
		spawned = false
		
	end
end
end)


local displayed = false
local menuOpen = false

local blipPickup = AddBlipForCoord(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z)

			SetBlipSprite (blipPickup, 514)
			SetBlipDisplay(blipPickup, 4)
			SetBlipScale  (blipPickup, 1.1)
			SetBlipColour (blipPickup, 24)
			SetBlipAsShortRange(blipPickup, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Cocoa Leaves Plantation")
			EndTextCommandSetBlipName(blipPickup)
			
local blipProcess = AddBlipForCoord(Config.Processing.x, Config.Processing.y, Config.Processing.z)

			SetBlipSprite (blipProcess, 514)
			SetBlipDisplay(blipProcess, 4)
			SetBlipScale  (blipProcess, 1.1)
			SetBlipColour (blipProcess, 24)
			SetBlipAsShortRange(blipProcess, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Cocaine production")
			EndTextCommandSetBlipName(blipProcess)
			


local process = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
			for k in pairs(locations) do
				if GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1))) < 150 then			
					DrawMarker(3, locations[k].x, locations[k].y, locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 200, 0, 110, 0, 1, 0, 0)	
					
					if GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1)), false) < 2 then			
						TriggerServerEvent('KCoke:get')
						TriggerEvent('KCoke:new', k)
					end
				
				end
			end
			
			if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1))) < 150 then			
					DrawMarker(1, Config.Processing.x, Config.Processing.y, Config.Processing.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.0, 0, 200, 0, 110, 0, 1, 0, 0)	
					if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) < 2 then			
						Draw3DText( Config.Processing.x, Config.Processing.y, Config.Processing.z , "~w~Cocaine Production~y~\nPress [~b~E~y~] to start processing",4,0.15,0.1)
						if IsControlJustReleased(0, Keys['E']) then
							Citizen.CreateThread(function()
								Process()
							end)
						end
					end
					
					if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) < 5 and GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) > 3 then
						process = false
					end
				end
			
			
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*100
         local scale = scale*fov   
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
		 if inDist then
			SetTextColour(0, 190, 0, 220)		-- You can change the text color here
		 else
		 	SetTextColour(220, 0, 0, 220)		-- You can change the text color here
		 end
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
end

function Process()
process = true
local making = true
	while making and process do
	TriggerEvent('esx:showNotification', '~g~Starting ~w~Cocaine ~g~production')
	Citizen.Wait(5000)
	
	ESX.TriggerServerCallback('KCoke:process', function(output)
			making = output
		end)

	end
end


RegisterNetEvent('KCoke:start')
AddEventHandler('KCoke:start', function()
	local set = false
	Citizen.Wait(10)
	
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	
	

	
	table.insert(locations,{x=rnX, y=rnY, z=Z + 0.3});

	

end)


RegisterNetEvent('KCoke:new')
AddEventHandler('KCoke:new', function(id)
	local set = false
	Citizen.Wait(10)
	
	
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	
	locations[id].x = rnX
	locations[id].y = rnY
	locations[id].z = Z + 0.3

end)

RegisterNetEvent('KCoke:message')
AddEventHandler('KCoke:message', function(message)
	ESX.ShowNotification(message)
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end









