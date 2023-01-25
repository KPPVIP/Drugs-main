ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
	
	ESX.PlayerData = ESX.GetPlayerData()

    Citizen.Wait(5000)
    
    
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

RegisterNetEvent('pawal:stoptraitement')
AddEventHandler('pawal:stoptraitement', function()
    traitementencours = false
	traitementmeth = false
    stopanim()
end)

local keyactivation = false
RegisterNetEvent('pawal:activationlaboratoirekey')
AddEventHandler('pawal:activationlaboratoirekey', function(activation)
     keyactivation = activation
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
 
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                --\\Menu Tenue//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 local mainMenu = RageUI.CreateMenu("Drogue", "Tenue") 
 local open = false
 
 mainMenu.X = 0 
 mainMenu.Y = 0

 mainMenu.Closed = function() 
     open = false 
 end 
 
 function pDrugs()
     if open then 
         open = false 
             RageUI.Visible(mainMenu, false) 
             return 
     else 
         open = true 
             RageUI.Visible(mainMenu, true)
         Citizen.CreateThread(function()
             while open do 
                 RageUI.IsVisible(mainMenu, function()
                    if config.BanniereColorActivation == true then
                        mainMenu:SetRectangleBanner(config.BanniereRed,config.BanniereGreen,config.BanniereBlue,config.BanniereOpacity)
                    end

                    RageUI.Checkbox("Prendre une tenue de travail", nil, droguetravail, {}, {
                        onChecked = function(index, items)
                            droguetravail = true 
                            droguetenue()
                            ESX.ShowNotification('Tenue : ~g~Actif~s~\nActivité : ~g~Possible')
                        end,
                        onUnChecked = function(index, items)
                            droguetravail = false
                            civiltenue()
                            ESX.ShowNotification('Tenue : ~r~Inactif~s~\nActivité : ~r~Impossible')
                        end
                    }) 
                    

                    end)
             Wait(0)
             end
         end)
     end
 end
 
 -- MARKERS TENUE
 
 Citizen.CreateThread(function()
     while true do
       local wait = 900
         for k,v in pairs(Config.position) do
             local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
             local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
             if dist <= 3 then 
                 wait = 1                                                 
                 DrawMarker(config.markertype, v.x, v.y, v.z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.7, 0.7, 0.7, config.red, config.green, config.blue, config.opacity, false, false, true, false, false, false, false, false)
             end
             if dist <= 1.5 then
                 wait = 1
                 ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir") 
                 if IsControlJustPressed(1,38) then
                    pDrugs() 
                 end
             end 
         end
     Citizen.Wait(wait)
     end
 end)

 function  droguetenue()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
              ['tshirt_1'] = 62,  ['tshirt_2'] = 1,
              ['torso_1'] = 67,   ['torso_2'] = 1,
              ['arms'] = 38,
              ['pants_1'] = 40,   ['pants_2'] = 1,
              ['shoes_1'] = 25,   ['shoes_2'] = 0,
              ['helmet_1'] = -1,  ['helmet_2'] = 0,
              ['chain_1'] = 0,    ['chain_2'] = 0,
              ['ears_1'] = -1,     ['ears_2'] = 0,
              ['mask_1'] = 46
            }
        else
            clothesSkin = {
              ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
              ['torso_1'] = 249,   ['torso_2'] = 0, 
              ['arms'] = 31,
              ['pants_1'] = 101,   ['pants_2'] = 0,
              ['shoes_1'] = 6,   ['shoes_2'] = 0,  
              ['helmet_1'] = -1,  ['helmet_2'] = 0,
              ['chain_1'] = 0,    ['chain_2'] = 0,
              ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function civiltenue()
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
      TriggerEvent('skinchanger:loadSkin', skin)
     end)
  end
