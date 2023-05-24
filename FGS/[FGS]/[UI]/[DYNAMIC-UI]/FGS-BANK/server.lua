local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")



RegisterServerEvent('FGS-BANK-CORE:checkBalance')
AddEventHandler('FGS-BANK-CORE:checkBalance', function()
	local src = source
    local user_id = vRP.getUserId({source})
    local bank = vRP.getBankMoney({user_id})
    local cash = vRP.getMoney({user_id})
	local playername = GetPlayerName(src)
    TriggerClientEvent('FGS-BANK-CORE:updateBalance', src, bank, playername, user_id)
end)

RegisterServerEvent('FGS-BANK-CORE:depositMoney')
AddEventHandler('FGS-BANK-CORE:depositMoney', function(amountDeposit)
	local _source = source
	local user_id = vRP.getUserId({_source})
	totalBalance = vRP.getBankMoney({user_id})
	totalCashBalance = vRP.getMoney({user_id})
	if amountDeposit > totalCashBalance or amountDeposit == nil or amountDeposit <= 0 then
		TriggerClientEvent("FGS-BANK-CORE:showNotification", _source, "warn", "Incorrect amount")
	else
		vRP.tryDeposit({user_id, amountDeposit})
		TriggerClientEvent("FGS-BANK-CORE:showNotification", _source, "success", "Successfully deposit "..amountDeposit.."$")
		FGSLOGS("FGS Bank ", ""..source.." | "..GetPlayerName(source).." | "..GetPlayerIdentifier(source).." Deposited **"..amountDeposit.."$** into his account", 3066993, "deposit")
	end
end)

RegisterServerEvent('FGS-BANK-CORE:withdrawMoney')
AddEventHandler('FGS-BANK-CORE:withdrawMoney', function(amountWithdraw)
	local _source = source
	local user_id = vRP.getUserId({_source})
	bankMoney = vRP.getBankMoney({user_id})
	totalCashBalance = vRP.getMoney({user_id})

	if amountWithdraw > bankMoney or amountWithdraw == nil or amountWithdraw <= 0 then
		TriggerClientEvent("FGS-BANK-CORE:showNotification", _source, "warn", "Incorrect amount")
	else
		vRP.tryWithdraw({user_id, amountWithdraw})
		TriggerClientEvent("FGS-BANK-CORE:showNotification", _source, "success", "Successfully withdrawn "..amountWithdraw.."$")
		FGSLOGS("FGS Bank ", ""..source.." | "..GetPlayerName(source).." | "..GetPlayerIdentifier(source).." he withdrew **"..amountWithdraw.."$** into his account", 15158332, "withdraw")
	end
end)


RegisterServerEvent('FGS-BANK-CORE:transferMoney')
AddEventHandler('FGS-BANK-CORE:transferMoney', function(receiver, amountTransfer)
	local _source = source
	local user_id = vRP.getUserId({_source})
	local receiver_id = vRP.getUserId({receiver})
	local totalBalance = 0

	if(receiver_id == nil or receiver_id == -1) then
		TriggerClientEvent("FGS-BANK-CORE:showNotification", source, "warn", "Recipient not found")
	else
		sourceBalance =	vRP.getBankMoney({user_id})

		if tonumber(_source) == tonumber(receiver) then
			TriggerClientEvent("FGS-BANK-CORE:showNotification", source, "warn", "You can't transfer money to yourself")
		else
			if sourceBalance <= 0 or sourceBalance < tonumber(amountTransfer) or tonumber(amountTransfer) <= 0 then
				TriggerClientEvent("FGS-BANK-CORE:showNotification", source, "warn", "You don't have enough money")
			else
				vRP.tryBankPayment({user_id, tonumber(amountTransfer)})
				vRP.giveBankMoney({receiver_id, tonumber(amountTransfer)})
				TriggerClientEvent("FGS-BANK-CORE:showNotification", source, "success", "Transfer done")
				TriggerClientEvent("FGS-BANK-CORE:showNotification", receiver, "success", "New Transfer: "..amountTransfer.."$ from: [ "..source.." ]")
				FGSLOGS("FGS Bank ", "New Transfer\nPlayer: "..source.." | "..GetPlayerName(source).." | "..GetPlayerIdentifier(source).."\nTo: "..receiver.." | "..GetPlayerName(receiver).." | "..GetPlayerIdentifier(receiver).."\nAmount: **"..amountTransfer.."$** ", 1752220, "transfer")
			end
		end
	end
end)

function FGSLOGS (name, message, color, channel)
	if channel == 'deposit' then
		DiscordWebHook = "https://discord.com/api/webhooks/982451894737854484/5FdcNirex9ntPT3SfjfAUQKrfk9zCQDW4hQUsB2txLeWBzkENsG_7v1EkbDoP4CL2Xc7"
	elseif channel == 'withdraw' then
		DiscordWebHook = 'https://discord.com/api/webhooks/982451894737854484/5FdcNirex9ntPT3SfjfAUQKrfk9zCQDW4hQUsB2txLeWBzkENsG_7v1EkbDoP4CL2Xc7'
	elseif channel == 'transfer' then
		DiscordWebHook = 'https://discord.com/api/webhooks/982451894737854484/5FdcNirex9ntPT3SfjfAUQKrfk9zCQDW4hQUsB2txLeWBzkENsG_7v1EkbDoP4CL2Xc7'
	end

	local date = os.date('*t')
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
  
local embeds = {
	{
	  ["description"]=message,
	  ["type"]="rich",
	  ["color"] =color,
    	["footer"]=  {
			["text"]= ""..date.."",
		},
	}
}
  
if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end