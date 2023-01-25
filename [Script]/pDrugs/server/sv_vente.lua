ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false

  RegisterNetEvent('drugs:trigger')
  AddEventHandler('drugs:trigger', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_fail')
  			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 1)
 	end
end)

ESX.RegisterServerCallback('pawal:checkpolice', function(source, cb)
    nombrepolice = 0
    for _, playerId in pairs(ESX.GetPlayers()) do
        xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer.job.name == 'police' then
            nombrepolice = nombrepolice + 1
        end
    end

    cb(nombrepolice)
end)

RegisterServerEvent('fetchjob')
AddEventHandler('fetchjob', function()
    local xPlayer  = ESX.GetPlayerFromId(source)
    TriggerClientEvent('getjob', source, xPlayer.job.name)
end)



  RegisterServerEvent('drugs:sell')
  AddEventHandler('drugs:sell', function(droguevente)
  	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	--Item
	local weedlabo = xPlayer.getInventoryItem('weedemballage').count
	local methlabo = xPlayer.getInventoryItem('methemballage').count
	local cokelabo = xPlayer.getInventoryItem('cokeemballage').count
	local opiumlabo = xPlayer.getInventoryItem('opiumemballage').count
    --

	--Prix vente
	local paymentweedlabo = math.random (270,300)
	local paymentcokelabo = math.random (400,500)
	local paymentmethlabo = math.random (340,370)
	local paymentopiumlabo = math.random (195,235)
	--

	--Nombre de pochon à vendre en 1 seul transaction
	local nombreopiumlabo = math.random (1,4)
	local nombreweedlabo = math.random (1,4)
	local nombremethlabo = math.random (1,4)
	local nombrecokelabo = math.random (1,4)
    --
		--

		if weedlabo >= nombreweedlabo and success == true then
			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de vendre x~b~"..nombreweedlabo.." ~b~Pochon de Weed de qualité +~s~ pour ~b~$".. paymentweedlabo*nombreweedlabo)
			ExecuteCommand('e pointright')
	   
			xPlayer.removeInventoryItem('weedemballage', nombreweedlabo)
  			xPlayer.addAccountMoney('black_money', paymentweedlabo*nombreweedlabo)
		 selling = false
		elseif methlabo >= nombremethlabo and success == true then
			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de vendre x~b~"..nombremethlabo.." ~b~Pochon de Meth de qualité +~s~ pour ~b~$".. paymentmethlabo*nombremethlabo)
			ExecuteCommand('e pointright')
	   
			xPlayer.removeInventoryItem('methemballage', nombremethlabo)
  			xPlayer.addAccountMoney('black_money', paymentmethlabo*nombremethlabo)
		 selling = false
		elseif opiumlabo >= nombreopiumlabo and success == true then
			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de vendre x~b~"..nombreopiumlabo.." ~b~Pochon de Meth de qualité +~s~ pour ~b~$".. paymentopiumlabo*nombreopiumlabo)
			ExecuteCommand('e pointright')
	   
			xPlayer.removeInventoryItem('opiumemballage', nombreopiumlabo)
  			xPlayer.addAccountMoney('black_money', paymentopiumlabo*nombreopiumlabo)
		 selling = false
		elseif cokelabo >= nombrecokelabo and success == true then
			TriggerClientEvent("pNotify:SetQueueMax", source, "lmao", 5)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous venez de vendre x~b~"..nombrecokelabo.." ~b~ Pochon de Coke de qualité +~s~ pour ~b~$".. paymentcokelabo*nombrecokelabo)
			ExecuteCommand('e pointright')
	   
			xPlayer.removeInventoryItem('cokeemballage', nombrecokelabo)
  			xPlayer.addAccountMoney('black_money', paymentcokelabo*nombrecokelabo)
		 selling = false
			elseif selling == true and success == false and notintrested == true then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Echec de la vente")
  			selling = false
  			elseif weedlabo < 1 and cokelabo < 1 and methlabo < 1 and opiumlabo < 1 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Echec de la vente")
			elseif copscalled == true and success == false then
				for i=1, #xPlayers, 1 do
					local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer2.job.name == 'police' then
				  TriggerClientEvent('pawal:appelpolice', xPlayers[i], droguevente.x, droguevente.y, droguevente.z)
					end
				end
				  TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Echec de la vente")
  			selling = false
  		end
end)

RegisterNetEvent('pass_or_fail')
AddEventHandler('pass_or_fail', function()

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
end)


RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	local weedlabo = xPlayer.getInventoryItem('weedemballage').count
	local methlabo = xPlayer.getInventoryItem('methemballage').count
	local cokelabo = xPlayer.getInventoryItem('cokeemballage').count
	local opiumlabo = xPlayer.getInventoryItem('opiumemballage').count


	if weedlabo >= 1 or methlabo >= 1 or opiumlabo >= 1 or cokelabo >= 1 then
		TriggerClientEvent("checkR", source, true)
	else
		TriggerClientEvent("checkR", source, false)
	end

end)

