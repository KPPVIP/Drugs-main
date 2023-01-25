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

local keyactivationcoke = false
RegisterNetEvent('pawal:activationlaboratoirekeycoke')
AddEventHandler('pawal:activationlaboratoirekeycoke', function(activationcoke)
    keyactivationcoke = activationcoke
end)

local keyactivationmeth = false
RegisterNetEvent('pawal:activationlaboratoirekeymeth')
AddEventHandler('pawal:activationlaboratoirekeymeth', function(activationmeth)
    keyactivationmeth = activationmeth
end)

local keyactivationweed = false
RegisterNetEvent('pawal:activationlaboratoirekeyweed')
AddEventHandler('pawal:activationlaboratoirekeyweed', function(activationmeth)
    keyactivationweed = activationmeth
end)

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    --\\Menu Meth//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- MENU TELEPORTATION
  local mainMenu = RageUI.CreateMenu("Porte", "ACTION") 



  local open = false
  local code = false
  
  mainMenu.X = 0 
  mainMenu.Y = 0
  
  mainMenu.Closed = function() 
      open = false 
  end 
  
  local lockedmethentrer = false
  local lockedmethsortir = true
  function teleportationmethmenu()
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
                    if config.codelabo then
                        if code == false then
                            if codesaisiaffichage == nil then
                                RageUI.Separator("Code saisi : ~r~Aucun")
                            end
                            if codesaisiaffichage ~= nil then
                                RageUI.Separator("Code saisi : ~r~"..codesaisiaffichage)
                            end
                            local codesaisiverif = codesaisi
                            RageUI.Button("Saisir le code", nil, {RightLabel = "~r~→"}, true , {
                                onSelected = function()
                                    local codesaisi = KeyboardInput("Veuillez saisir le code", "", "", 6)
                                    codesaisiaffichage = codesaisi
                                    if codesaisi == config.codelabometh then
                                        codecorrect = true
                                    else 
                                        codecorrect = false
                                    end
                            end
                            })   
                            
                            if codesaisiaffichage ~= nil then
                            RageUI.Button("Valider", nil, {RightLabel = "~r~→"}, true , {
                                onSelected = function()
                                    if codecorrect == true then
                                        codeactif = true
                                        code = true
                                        ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~g~Accepter')
                                    else 
                                        codeactif = false
                                        code = false   
                                        ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~r~Refuser')
                                    end
                                end
                            })   
                        end
                        end
                    end
                    
                    if codeactif == true then
                    RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 997.21, -3200.80, -36.39, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 997.21, -3200.80, -36.39, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 290.59)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                        end
                    end
                    })

                    RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                        onSelected = function()
                            if not droguetravail then
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1407.96, 3619.23, 34.89, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1407.96, 3619.23, 34.89, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 270.81)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                           end
                            else
                             ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                        end
                    end
                    })
                   end

                if config.keylabo == true then
                    if keyactivationmeth == false then
                    RageUI.Button("Débloquer la serrure", nil, {RightLabel = "~r~→"}, true , {
                        onSelected = function()
                        TriggerServerEvent('pawal:verifkeymeth')
                    end
                })
            end
                    if keyactivationmeth == true then
                        RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                            onSelected = function()
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 997.21, -3200.80, -36.39, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 997.21, -3200.80, -36.39, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 290.59)
                                lockedmethentrer = true
                                lockedmethsortir = false
                                RageUI.CloseAll()
                            end
                        end
                        })
    
                        RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                            onSelected = function()
                                if not droguetravail then
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 1407.96, 3619.23, 34.89, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 1407.96, 3619.23, 34.89, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 270.81)
                                lockedmethentrer = false
                                lockedmethsortir = true
                                RageUI.CloseAll()
                               end
                                else
                                 ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                            end
                        end
                        })
                    end
                end
                if config.standardlabo == true then
                    RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 997.21, -3200.80, -36.39, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 997.21, -3200.80, -36.39, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 270.00)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                        end
                    end
                    })

                    RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                        onSelected = function()
                            if not droguetravail then
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1407.96, 3619.23, 34.89, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1407.96, 3619.23, 34.89, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 290.67)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                           end
                            else
                             ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                        end
                    end
                    })
                end
                end)
              Wait(0)
              end
          end)
      end
  end
 
   
  Citizen.CreateThread(function()
     while true do
       local wait = 900
         for k,v in pairs(Config.teleportationmeth) do
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
                    teleportationmethmenu()
                 end
         end
         end
     Citizen.Wait(wait)
     end
 end)

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------







  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    --\\Menu Weed//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   -- MENU TELEPORTATION
   local mainMenu = RageUI.CreateMenu("Porte", "ACTION") 



   local open = false
   local code = false
   
   mainMenu.X = 0 
   mainMenu.Y = 0
   
   mainMenu.Closed = function() 
       open = false 
   end 
   
   local lockedmethentrer = false
   local lockedmethsortir = true
   function teleportationweedmenu()
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
                     if config.codelabo then
                         if code == false then
                             if codesaisiaffichage == nil then
                                 RageUI.Separator("Code saisi : ~r~Aucun")
                             end
                             if codesaisiaffichage ~= nil then
                                 RageUI.Separator("Code saisi : ~r~"..codesaisiaffichage)
                             end
                             local codesaisiverif = codesaisi
                             RageUI.Button("Saisir le code", nil, {RightLabel = "~r~→"}, true , {
                                 onSelected = function()
                                     local codesaisi = KeyboardInput("Veuillez saisir le code", "", "", 6)
                                     
                                     codesaisiaffichage = codesaisi
                                     if codesaisi == config.codelaboweed then
                                         codecorrect = true
                                     else 
                                         codecorrect = false
                                     end
                             end
                             })   
                             
                             if codesaisiaffichage ~= nil then
                             RageUI.Button("Valider", nil, {RightLabel = "~r~→"}, true , {
                                 onSelected = function()
                                     if codecorrect == true then
                                         codeactif = true
                                         code = true
                                         ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~g~Accepter')
                                     else 
                                         codeactif = false
                                         code = false   
                                         ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~r~Refuser')
                                     end
                                 end
                             })   
                         end
                         end
                     end
                     
                     if codeactif == true then
                        RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                            onSelected = function()
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 1066.14, -3183.48, -39.16, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 1066.14, -3183.48, -39.16, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 90.00)
                                lockedmethentrer = true
                                lockedmethsortir = false
                                RageUI.CloseAll()
                            end
                        end
                        })
    
                        RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                            onSelected = function()
                                if not droguetravail then
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, -1108.3, -1643.17, 4.64, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), -1108.3, -1643.17, 4.64, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 304.67)
                                lockedmethentrer = false
                                lockedmethsortir = true
                                RageUI.CloseAll()
                               end
                                else
                                 ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                            end
                        end
                        })
                    end
                 if config.keylabo == true then
                     if keyactivationweed == false then
                     RageUI.Button("Débloquer la serrure", nil, {RightLabel = "~r~→"}, true , {
                         onSelected = function()
                         TriggerServerEvent('pawal:verifkeyweed')
                     end
                 })
             end
                     if keyactivationweed == true then
                        RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                            onSelected = function()
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 1066.14, -3183.48, -39.16, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 1066.14, -3183.48, -39.16, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 90.00)
                                lockedmethentrer = true
                                lockedmethsortir = false
                                RageUI.CloseAll()
                            end
                        end
                        })
    
                        RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                            onSelected = function()
                                if not droguetravail then
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, -1108.3, -1643.17, 4.64, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), -1108.3, -1643.17, 4.64, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 304.67)
                                lockedmethentrer = false
                                lockedmethsortir = true
                                RageUI.CloseAll()
                               end
                                else
                                 ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                            end
                        end
                        })
                     end
                 end
                 if config.standardlabo == true then
                    RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1066.14, -3183.48, -39.16, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1066.14, -3183.48, -39.16, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 90.00)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                        end
                    end
                    })

                    RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                        onSelected = function()
                            if not droguetravail then
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, -1108.3, -1643.17, 4.64, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), -1108.3, -1643.17, 4.64, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 304.67)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                           end
                            else
                             ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                        end
                    end
                    })
                 end
                 end)
               Wait(0)
               end
           end)
       end
   end
  
    
   Citizen.CreateThread(function()
      while true do
        local wait = 900
          for k,v in pairs(Config.teleportationweed) do
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
                    teleportationweedmenu()
                  end
          end
          end
      Citizen.Wait(wait)
      end
  end)

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    --\\Menu Coke//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- MENU TELEPORTATION
  local mainMenu = RageUI.CreateMenu("Porte", "ACTION") 



  local open = false
  local code = false
  
  mainMenu.X = 0 
  mainMenu.Y = 0
  
  mainMenu.Closed = function() 
      open = false 
  end 
  
  local lockedmethentrer = false
  local lockedmethsortir = true
  function teleportationcokemenu()
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
                    if config.codelabo then
                        if code == false then
                            if codesaisiaffichage == nil then
                                RageUI.Separator("Code saisi : ~r~Aucun")
                            end
                            if codesaisiaffichage ~= nil then
                                RageUI.Separator("Code saisi : ~r~"..codesaisiaffichage)
                            end
                            local codesaisiverif = codesaisi
                            RageUI.Button("Saisir le code", nil, {RightLabel = "~r~→"}, true , {
                                onSelected = function()
                                    local codesaisi = KeyboardInput("Veuillez saisir le code", "", "", 6)
                                    
                                    codesaisiaffichage = codesaisi
                                    if codesaisi == config.codelabocoke then
                                        codecorrect = true
                                    else 
                                        codecorrect = false
                                    end
                            end
                            })   
                            
                            if codesaisiaffichage ~= nil then
                            RageUI.Button("Valider", nil, {RightLabel = "~r~→"}, true , {
                                onSelected = function()
                                    if codecorrect == true then
                                        codeactif = true
                                        code = true
                                        ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~g~Accepter')
                                    else 
                                        codeactif = false
                                        code = false   
                                        ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~r~Refuser')
                                    end
                                end
                            })   
                        end
                        end
                    end
                    
                    if codeactif == true then
                        RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                            onSelected = function()
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 1088.66, -3187.99, -38.99, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 1088.66, -3187.99, -38.99, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 180.77)
                                lockedmethentrer = true
                                lockedmethsortir = false
                                RageUI.CloseAll()
                            end
                        end
                        })
    
                        RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                            onSelected = function()
                                if not droguetravail then
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, -13.61, -6480.48, 31.43, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), -13.61, 6480.58, 31.43, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 223.86)
                                lockedmethentrer = false
                                lockedmethsortir = true
                                RageUI.CloseAll()
                               end
                                else
                                 ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                            end
                        end
                        })
                   end

                if config.keylabo == true then
                    if keyactivationcoke == false then
                    RageUI.Button("Débloquer la serrure", nil, {RightLabel = "~r~→"}, true , {
                        onSelected = function()
                        TriggerServerEvent('pawal:verifkeycoke')
                    end
                })
            end
                    if keyactivationcoke == true then
                        RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                            onSelected = function()
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 1088.66, -3187.99, -38.99, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 1088.66, -3187.99, -38.99, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 180.77)
                                lockedmethentrer = true
                                lockedmethsortir = false
                                RageUI.CloseAll()
                            end
                        end
                        })
    
                        RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                            onSelected = function()
                                if not droguetravail then
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, -13.61, -6480.48, 31.43, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), -13.61, 6480.58, 31.43, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 223.86)
                                lockedmethentrer = false
                                lockedmethsortir = true
                                RageUI.CloseAll()
                               end
                                else
                                 ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                            end
                        end
                        })
                    end
                end
                if config.standardlabo == true then
                    RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1088.66, -3187.99, -38.99, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1088.66, -3187.99, -38.99, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 180.77)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                        end
                    end
                    })

                    RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                        onSelected = function()
                            if not droguetravail then
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, -13.61, -6480.48, 31.43, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), -13.61, 6480.58, 31.43, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 223.86)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                           end
                            else
                             ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                        end
                    end
                    })
                end
                end)
              Wait(0)
              end
          end)
      end
  end

  Citizen.CreateThread(function()
    while true do
      local wait = 900
        for k,v in pairs(Config.teleportationcoke) do
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
                    teleportationcokemenu()
                end
        end
        end
    Citizen.Wait(wait)
    end
end)






 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                    --\\Menu Meth//--
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- MENU TELEPORTATION
  local mainMenu = RageUI.CreateMenu("Porte", "ACTION") 



  local open = false
  local code = false
  
  mainMenu.X = 0 
  mainMenu.Y = 0
  
  mainMenu.Closed = function() 
      open = false 
  end 
  
  local lockedmethentrer = false
  local lockedmethsortir = true
  function teleportationopiummenu()
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
                    if config.codelabo then
                        if code == false then
                            if codesaisiaffichage == nil then
                                RageUI.Separator("Code saisi : ~r~Aucun")
                            end
                            if codesaisiaffichage ~= nil then
                                RageUI.Separator("Code saisi : ~r~"..codesaisiaffichage)
                            end
                            local codesaisiverif = codesaisi
                            RageUI.Button("Saisir le code", nil, {RightLabel = "~r~→"}, true , {
                                onSelected = function()
                                    local codesaisi = KeyboardInput("Veuillez saisir le code", "", "", 6)
                                    
                                    codesaisiaffichage = codesaisi
                                    if codesaisi == config.codelabometh then
                                        codecorrect = true
                                    else 
                                        codecorrect = false
                                    end
                            end
                            })   
                            
                            if codesaisiaffichage ~= nil then
                            RageUI.Button("Valider", nil, {RightLabel = "~r~→"}, true , {
                                onSelected = function()
                                    if codecorrect == true then
                                        codeactif = true
                                        code = true
                                        ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~g~Accepter')
                                    else 
                                        codeactif = false
                                        code = false   
                                        ESX.ShowNotification('~r~Information\n~s~Code : ~r~'..codesaisiaffichage..'\n~s~Accès : ~r~Refuser')
                                    end
                                end
                            })   
                        end
                        end
                    end
                    
                    if codeactif == true then
                    RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 997.21, -3200.80, -36.39, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 997.21, -3200.80, -36.39, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 290.59)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                        end
                    end
                    })

                    RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                        onSelected = function()
                            if not droguetravail then
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1407.96, 3619.23, 34.89, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1407.96, 3619.23, 34.89, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 270.81)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                           end
                            else
                             ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                        end
                    end
                    })
                   end

                if config.keylabo == true then
                    if keyactivationmeth == false then
                    RageUI.Button("Débloquer la serrure", nil, {RightLabel = "~r~→"}, true , {
                        onSelected = function()
                        TriggerServerEvent('pawal:verifkeymeth')
                    end
                })
            end
                    if keyactivationmeth == true then
                        RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                            onSelected = function()
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 997.21, -3200.80, -36.39, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 997.21, -3200.80, -36.39, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 290.59)
                                lockedmethentrer = true
                                lockedmethsortir = false
                                RageUI.CloseAll()
                            end
                        end
                        })
    
                        RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                            onSelected = function()
                                if not droguetravail then
                                local coords = GetEntityCoords(GetPlayerPed(-1))
                                if GetDistanceBetweenCoords(coords, 1407.96, 3619.23, 34.89, true) > 0.5 then
                                SetEntityCoords(GetPlayerPed(-1), 1407.96, 3619.23, 34.89, 0.0, 0.0, 0.0, true)
                                SetEntityHeading(GetPlayerPed(-1), 270.81)
                                lockedmethentrer = false
                                lockedmethsortir = true
                                RageUI.CloseAll()
                               end
                                else
                                 ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                            end
                        end
                        })
                    end
                end
                if config.standardlabo == true then
                    RageUI.Button("Entrer dans le batiment", nil, {RightLabel = "~r~→"}, lockedmethsortir , {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 997.21, -3200.80, -36.39, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 997.21, -3200.80, -36.39, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 270.00)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                        end
                    end
                    })

                    RageUI.Button("Sortir du batiment", nil, {RightLabel = "~r~→"}, lockedmethentrer , {
                        onSelected = function()
                            if not droguetravail then
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1407.96, 3619.23, 34.89, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1407.96, 3619.23, 34.89, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 290.67)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                           end
                            else
                             ESX.ShowNotification('Action : ~r~Impossible\nVous devez ranger votre tenue')
                        end
                    end
                    })
                end
                end)
              Wait(0)
              end
          end)
      end
  end
 
   
  Citizen.CreateThread(function()
     while true do
       local wait = 900
         for k,v in pairs(Config.teleportationopium) do
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
                    teleportationopiummenu()
                 end
         end
         end
     Citizen.Wait(wait)
     end
 end)
