ESX                 = nil
local myJob     = nil
local drogueactif = false
local selling       = false
local coords = {}
local has       = false
local copsc     = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

function DrawMissionText(msg, time)
  ClearPrints()
  SetTextEntry_2('STRING')
  AddTextComponentString(msg)
  DrawSubtitleTimed(time, 1)
end

function RequestAndWaitModel(modelName) -- Request un modèle de véhicule
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

function RequestAndWaitDict(dictName) -- Request une animation (dict)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
  TriggerServerEvent('fetchjob')
end)

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*14
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+1, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('getjob')
AddEventHandler('getjob', function(jobName)
  myJob = jobName
end)


-- MENU VENTE
local mainMenu = RageUI.CreateMenu("Vente", "ACTION") 



local open = false
local society = nil
local drogueventeactif = false

mainMenu.X = 0 
mainMenu.Y = 0

mainMenu.Closed = function() 
    open = false 
end 

local lockedmethentrer = false
local lockedmethsortir = true
function menuvente()
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
                  if drogueventeactif == false then
                  RageUI.Separator('Vente drogue : ~r~Inactif')
                  else
                    RageUI.Separator('Vente drogue : ~g~Actif')
                  end
                  RageUI.Checkbox("Mode vente de drogue", nil, ventego, {}, {
                      onChecked = function(index, items)
                        ventego = true 
                          ESX.ShowNotification('~g~Vous venez de commencer à vendre')
                          drogueventeactif = true
                      end,
                      onUnChecked = function(index, items)
                          local playerPed = GetPlayerPed(-1)
                          ventego = false
                          ESX.ShowNotification('~r~Vous venez de terminer à vendre')
                          drogueventeactif = false
                      end
                  }) 


                   end)
            Wait(0)
            end
        end)
    end
end

 
Keys.Register('F4', 'DROGUE', 'Ouvrir le menu vente Drogue', function()
   ESX.PlayerData = ESX.GetPlayerData()
 if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'police' then
  menuvente()
  ESX.GetPlayerData()
 end
end)

currentped = nil
Citizen.CreateThread(function()
police = 0
ESX.TriggerServerCallback('pawal:checkpolice', function(nombrepolice)
	police = nombrepolice
end)

while true do
  Wait(0)
  local player = GetPlayerPed(-1)
  local playerloc = GetEntityCoords(player, 0)
  local handle, ped = FindFirstPed()

  local pos = GetEntityCoords(ped)
  repeat
    success, ped = FindNextPed(handle)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
      if DoesEntityExist(ped)then
        if IsPedDeadOrDying(ped) == false then
          if IsPedInAnyVehicle(ped) == false then
            local pedType = GetPedType(ped)
            if pedType ~= 28 and IsPedAPlayer(ped) == false then
              currentped = pos
              if distance <= 2 and ped  ~= GetPlayerPed(-1) and ped ~= oldped  then
                TriggerServerEvent('checkD')
                if has == true then
                  if drogueventeactif == true then
                  Drawing.draw3DText(pos.x, pos.y, pos.z, "~w~Appuyez sur [~b~E~w~] pour ~b~vendre", 4, 0.1, 0.05, 255, 255, 255, 255)
                  if IsControlJustPressed(1, 86) then
                    if police < Config.Policerminimum then
                      ESX.ShowNotification('~r~Pas assez de policier en ville !')
                      return
                    else               

                    oldped = ped

                    RequestAndWaitDict("mp_common")
                    RequestAndWaitModel("prop_coke_block_half_b")
                    RequestAndWaitModel('hei_prop_heist_cash_pile')

                      ESX.ShowNotification('Négociation en cours...')

    
                      SetPedTalk(ped)
                      
                      PlayAmbientSpeech1(ped, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
                      local cCreate = CreateObject(GetHashKey('prop_coke_block_half_b'), 0, 0, 0, true)
                      local oCreate = CreateObject(GetHashKey('hei_prop_heist_cash_pile'), 0, 0, 0, true)
                      AttachEntityToEntity(oCreate, ped, GetPedBoneIndex(ped, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                      AttachEntityToEntity(cCreate, player, GetPedBoneIndex(player, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                      TaskPlayAnim(player, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 1, false, false, false)
                      TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 1, false, false, false)
                      Wait(1000)
                      AttachEntityToEntity(oCreate, ped, GetPedBoneIndex(ped, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                      AttachEntityToEntity(cCreate, player, GetPedBoneIndex(player, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                      Wait(1000)

                      ClearPedTasks(player)
                      ClearPedTasks(ped)

                      if cCreate then 
                        DeleteEntity(cCreate)
                    end
                    if oCreate then 
                        DeleteEntity(oCreate)
                    end

                          
                      PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
                      pos1 = GetEntityCoords(ped)
                      TriggerServerEvent('drugs:trigger')
                      TriggerEvent('sell')
                      local percent = math.random(1, 11)

                      if percent == 7 or percent == 8 or percent == 9 then
                        success = false
                        notintrested = true
                      elseif percent ~= 8 and percent ~= 9 and percent ~= 10 and percent ~= 7 then
                        success = true
                        notintrested = false
                      else
                        notintrested = false
                        success = false
                        copscalled = true
                      end
                      TaskLookAtCoord(player, playerloc['x'], playerloc['y'], playerloc['z'], -1, 2048, 3)
                      TaskStandStill(ped, 100.0)
                      SetEntityAsMissionEntity(ped)
                      FreezeEntityPosition(oldped, false)
                      FreezeEntityPosition(player, false)
                      SetPedAsNoLongerNeeded(oldped)
                  end
                end
                end
              end
          end
          end
        end
      end
    end
  end
  until not success
  EndFindPed(handle)
end
end)

RegisterNetEvent('sell')
AddEventHandler('sell', function()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= 3 then
      TriggerServerEvent('drugs:sell', playerloc)
    end
end)


RegisterNetEvent('checkR')
AddEventHandler('checkR', function(test)
  has = test
end)


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


RegisterNetEvent('pawal:appelpolice')
AddEventHandler('pawal:appelpolice', function(posx, posy, posz)
  ESX.ShowAdvancedNotification('Central LSPD', '~r~Notification', 'Objet : ~g~Vente de drogue\n~s~Action : ~r~Demande d\'intervention~s~\nPrendre l\'appel : ~b~Y', "CHAR_CALL911", 1)
    while true do
        local name = GetCurrentResourceName() .. math.random(999)
        if IsControlPressed(0, 246) then
            SetNewWaypoint(posx, posy)
            ESX.ShowNotification('Agent : ~b~'..GetPlayerName(PlayerId())..'\n~s~Action : ~g~Prend l\'appel')
            return
        elseif IsControlPressed(0, 252) then
            return
        end
        Wait(0)
    end
end)