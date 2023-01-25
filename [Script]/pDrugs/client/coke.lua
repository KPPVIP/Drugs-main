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
    traitementencourscoke = false
	traitementcoke = false
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
                                                                                                    --\\Menu coke//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 -- MENU TRAITEMENT
 local mainMenu = RageUI.CreateMenu("Coke", "Traitement") 



 local open = false
 local society = nil
 
 mainMenu.X = 0 
 mainMenu.Y = 0
 
 mainMenu.Closed = function() 
     open = false 
 end 
 
 function traitementDrogueCoke()
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

                    RageUI.Checkbox("Commencer le traitement", nil, traitementencourscoke, {}, {
                        onChecked = function(index, items)
                            traitementencourscoke = true 
                            ESX.ShowNotification('Vous venez de commencer le ~g~traitement')
                            ExecuteCommand('e mechanic4')
                            SetEntityHeading(GetPlayerPed(-1), 0)
                            RageUI.CloseAll()
                            open = false
                            traitementfonctioncoke()
                        end,
                        onUnChecked = function(index, items)
                            local playerPed = GetPlayerPed(-1)
                            traitementencourscoke = false
                            stoptraitementcoke()
                            stopanim()
                            FreezeEntityPosition(playerPed, false)
                        end
                    }) 

                    end)
             Wait(0)
             end
         end)
     end
 end

  
 Citizen.CreateThread(function()
    while true do
      local wait = 900
        for k,v in pairs(Config.cokepositiontraitement) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if droguetravail then
            if dist <= 0.8 then 
                wait = 1                                                 
                DrawMarker(config.markertype, v.x, v.y, v.z-1.00, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, config.red, config.green, config.blue, config.opacity, false, false, true, false, false, false, false, false)
            end
            if dist <= 0.8 then
                wait = 1
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir") 
                if IsControlJustPressed(1,38) then
                    traitementDrogueCoke()
                end
            end
        end
        end
    Citizen.Wait(wait)
    end
end)
 
function stopanim()
    local playerPed = GetPlayerPed(-1)
    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)
end


 function stoptraitementcoke()
    if traitementcoke then
    	traitementcoke = false
        ESX.ShowNotification('Vous venez de stopper le ~r~traitement')
        ClearPedTasks('')
    end
end

function traitementfonctioncoke()
    local playerPed = GetPlayerPed(-1)
    if not traitementcoke then
        traitementcoke = true
        FreezeEntityPosition(playerPed, true)
    while traitementcoke do
        Citizen.Wait(2000)
        TriggerServerEvent('pdrugs:traitementcoke')
    end
    else
        traitementcoke = false
    end
end



  -- MENU EMBALLAGE
  local mainMenu = RageUI.CreateMenu("Coke", "ACTION") 



  local open = false
  local society = nil
  
  mainMenu.X = 0 
  mainMenu.Y = 0
  
  mainMenu.Closed = function() 
      open = false 
  end 
  
  local lockedcokeentrer = false
  local lockedcokesortir = true
  function cokepositionemballage()
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

                    RageUI.Checkbox("Commencer l'emballage", nil, traitementencourscoke, {}, {
                        onChecked = function(index, items)
                            traitementencourscoke = true 
                            ESX.ShowNotification('Vous venez de commencer ~g~l\'emballage')
                            ExecuteCommand('e mechanic4')
                            RageUI.CloseAll()
                            open = false
                            emballagefonctioncoke()
                        end,
                        onUnChecked = function(index, items)
                            local playerPed = GetPlayerPed(-1)
                            traitementencourscoke = false
                            stopemballagecoke()
                            stopanim()
                            FreezeEntityPosition(playerPed, false)
                        end
                    }) 

 
                     end)
              Wait(0)
              end
          end)
      end
  end
 
   
  Citizen.CreateThread(function()
     while true do
       local wait = 900
         for k,v in pairs(Config.cokepositionemballage) do
             local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
             local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
             if droguetravail then
             if dist <= 3 then 
                 wait = 1                                                 
                 DrawMarker(config.markertype, v.x, v.y, v.z-1.00, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.7, 0.7, 0.7, config.red, config.green, config.blue, config.opacity, false, false, true, false, false, false, false, false)
             end
             if dist <= 1.5 then
                 wait = 1
                 ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir") 
                 if IsControlJustPressed(1,38) then
                    cokepositionemballage()
                 end
            end
         end
         end
     Citizen.Wait(wait)
     end
 end)

 function stopemballagecoke()
    if traitementcoke then
    	traitementcoke = false
        ESX.ShowNotification('Vous venez de stopper ~r~l\'emballage')
        ClearPedTasks('')
    end
end

 function emballagefonctioncoke()
    local playerPed = GetPlayerPed(-1)
    if not traitementcoke then
        traitementcoke = true
        FreezeEntityPosition(playerPed, true)
    while traitementcoke do
        Citizen.Wait(2000)
        TriggerServerEvent('pdrugs:emballagecoke')
    end
    else
        traitementcoke = false
    end
end

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    --\\RECOLTE coke//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   -- MENU TELEPORTATION
   local mainMenu = RageUI.CreateMenu("Coke", "ACTION") 



   local open = false
   local code = false
   
   mainMenu.X = 0 
   mainMenu.Y = 0
   
   mainMenu.Closed = function() 
       open = false 
   end 
   
   local lockedcokeentrer = false
   local lockedcokesortir = true
   function menurecoltecoke()
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

                      RageUI.Checkbox("Commencer la récolte", nil, traitementencourscoke, {}, {
                        onChecked = function(index, items)
                            traitementencourscoke = true 
                            ESX.ShowNotification('Vous venez de commencer la~g~ récolte')
                            ExecuteCommand('e pickup')
                            RageUI.CloseAll()
                            open = false
                            recoltefonctioncoke()
                        end,
                        onUnChecked = function(index, items)
                            local playerPed = GetPlayerPed(-1)
                            traitementencourscoke = false
                            stoprecoltecoke()
                            stopanim()
                            FreezeEntityPosition(playerPed, false)
                        end
                    }) 
                 end)
               Wait(0)
               end
           end)
       end
   end
  
    
   Citizen.CreateThread(function()
      while true do
        local wait = 900
          for k,v in pairs(Config.cokepositionrecolte) do
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
              if dist <= 3 then 
                  wait = 1                                                 
                  DrawMarker(config.markertype, v.x, v.y, v.z-1.00, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.7, 0.7, 0.7, config.red, config.green, config.blue, config.opacity, false, false, true, false, false, false, false, false)
              end
              if dist <= 1.5 then
                  wait = 1
                  ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir") 
                  if IsControlJustPressed(1,38) then
                    menurecoltecoke()
                  end
          end
          end
      Citizen.Wait(wait)
      end
  end)

  function recoltefonctioncoke()
    local playerPed = GetPlayerPed(-1)
    if not traitementcoke then
        traitementcoke = true
        FreezeEntityPosition(playerPed, true)
    while traitementcoke do
        Citizen.Wait(2000)
        TriggerServerEvent('pdrugs:recoltecoke')
        ExecuteCommand('e pickup')
    end
    else
        traitementcoke = false
    end
end

function stoprecoltecoke()
    if traitementcoke then
    	traitementcoke = false
        ESX.ShowNotification('Vous venez de stopper la ~r~récolte')
        ClearPedTasks('')
    end
end