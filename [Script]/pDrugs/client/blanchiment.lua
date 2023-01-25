ESX  = nil
local open = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
    end
	
	ESX.PlayerData = ESX.GetPlayerData()
	
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
  PlayerData.job2 = job2
end)

local LaundererMenu = RageUI.CreateMenu("Blanchisseur", "Action")
LaundererMenu.EnableMouse = true
LaundererMenu:DisplayPageCounter(false)


local SliderPannel = {
    Minimum = 0,
    Index = 1,
}

LaundererMenu.Closed = function()  
    SliderPannel.Index = 0 
    RageUI.Visible(LaundererMenu, false)
    open = false
end 

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
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

function RefreshPlayerData()
    Citizen.CreateThread(function()
        ESX.PlayerData = ESX.GetPlayerData()
    end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 2.0, 2.0, -1, 51, 0, false, false, false)
	end)
end


local Percentage = 1.00 -- Fr: Pourcentage sur le prix final, ici le blanchisseur prend 20% (1-0.80 = 0.20) // En: Percentage of the final price here the laundryman takes 20% (1-0.80 = 0.20)
local Progress = nil 
local PercentagePannel = 0.0
local Somme = 0
local locked = false
function MenuBlanchiment()
    if open then 
        open = false 
        RageUI.Visible(LaundererMenu,false)
        return
    else
        open = true 
        RageUI.Visible(LaundererMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(LaundererMenu, function()

                    if Somme ~= 0 then
                        locked = true
                    end
                    if Somme == 0 or Somme == "0" then
                        locked = false
                    end

                    RageUI.Button("Somme à blanchir :", false, {RightLabel = "~r~$"..Somme}, true, {
                        onSelected = function()
                            local Sommesaisi = KeyboardInput("Somme à blanchir", "", "", 6)
                            Somme = Sommesaisi
                        end
                    })   
                    RageUI.Button("Lancer le blanchiment", false, {RightLabel = "→→"}, locked, {
                        onSelected = function()
                            if Somme ~= nil then 
                                Somme = tonumber(Somme)
                                if type(Somme) == "number" then 
                                    Progress = true
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), true)
                            startAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer")
                                end
                            end
                        end
                    })   
                    RageUI.Separator("Votre Argent sale: ~r~$"..ESX.PlayerData.accounts[2].money)
                    
                    if Progress == true then
                        RageUI.PercentagePanel(PercentagePannel, 'Blanchiment en cours', '', '', {}, 2)
                        if PercentagePannel < 1.0 then
                            PercentagePannel = PercentagePannel + 0.0008
                        else
                            local FinalPercentage = Round(SliderPannel.Index * Percentage)
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)
                            Wait(50)
                            TriggerServerEvent("pawal:blanchiment", Somme)
                            PercentagePannel = 0.0
                            Progress = false
                            LaundererMenu.Closable = true
                            Somme = 0
                            LaundererMenu.Closed()
                        end
                    end

                end)

                Wait(0)
            end
        end)


    end
end


local TeleportMenu = RageUI.CreateMenu("Blanchisseur", "Action")
local lockedmethentrer = true

function MenuBlanchimentTp()
    if open then 
        open = false 
        RageUI.Visible(TeleportMenu,false)
        return
    else
        open = true 
        RageUI.Visible(TeleportMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(TeleportMenu, function()

                    
                    RageUI.Button("Entrer dans le batiment", false, {RightLabel = "→→"}, lockedmethentrer, {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 1138.0682373047,-3198.8930664063,-39.665683746338, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 1138.0682373047,-3198.8930664063,-39.665683746338, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 0.00)
                            lockedmethentrer = false
                            lockedmethsortir = true
                            RageUI.CloseAll()
                            end
                        end
                    })   
                    RageUI.Button("Sortir du batiment", false, {RightLabel = "→→"}, lockedmethsortir, {
                        onSelected = function()
                            local coords = GetEntityCoords(GetPlayerPed(-1))
                            if GetDistanceBetweenCoords(coords, 285.06185913086,-977.87432861328,44.987602233887, true) > 0.5 then
                            SetEntityCoords(GetPlayerPed(-1), 285.06185913086,-977.87432861328,44.987602233887, 0.0, 0.0, 0.0, true)
                            SetEntityHeading(GetPlayerPed(-1), 360.00)
                            lockedmethentrer = true
                            lockedmethsortir = false
                            RageUI.CloseAll()
                            end
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
        for k,v in pairs(Config.blanchimentposition) do
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
                    RefreshPlayerData()
                    Wait(50)
                    MenuBlanchiment()
                end
        end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
      local wait = 900
        for k,v in pairs(Config.blanchimentteleportposition) do
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
                    RefreshPlayerData()
                    Wait(50)
                    MenuBlanchimentTp()
                end
        end
        end
    Citizen.Wait(wait)
    end
end)