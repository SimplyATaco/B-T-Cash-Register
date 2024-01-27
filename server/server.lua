ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("cashRegister:ChargeCustomer")
AddEventHandler("cashRegister:ChargeCustomer", function(employee, method, amount)
    local xPlayer = ESX.GetPlayerFromId(employee)
    local xTarget = ESX.GetPlayerFromId(source)
    local society = xPlayer.getJob().name
    amount = tonumber(amount)

    local splitRatio = Config.JobCommisions[society] or Config.JobCommisions.default

    local PlayerMoney = xTarget.getAccount(method).money
    if PlayerMoney >= amount then
        xTarget.removeAccountMoney(method, amount)
        xPlayer.addAccountMoney('bank', amount * splitRatio.employee)
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. society, function(account)
            if account then
                account.addMoney(amount * splitRatio.society)
            end
        end)
        if Config.Receipts then
            xPlayer.addInventoryItem(Config.ReceiptItem, 1)
        end
        if Config.Logs then
            ESX.DiscordLogFields("CashRegister", "Cash Register", "green", {
                { name = "Info", value = xPlayer.getName() .. " (" .. xPlayer.source .. ") Has charged " .. xTarget.getName() .. "(" .. xTarget.source .. ")  $" .. amount, inline = false },
                { name = "License of Employee",  value = GetPlayerIdentifierByType(xPlayer.source, 'license') ,   inline = false },
                { name = "License of Customer",  value = GetPlayerIdentifierByType(xTarget.source, 'license') ,   inline = false },
            })
        end
        TriggerClientEvent("cashRegister:Noti", employee, Config.Strings.noti_title, Config.Strings.customer_paid .. amount .. Config.Strings.employee_received .. amount * splitRatio.employee, "success")
        TriggerClientEvent("cashRegister:Noti", source, Config.Strings.noti_title, Config.Strings.customer_charged ..amount, "success")
    else
        TriggerClientEvent("cashRegister:Noti", employee, Config.Strings.noti_title, Config.Strings.insufficient_funds, "error")
        TriggerClientEvent("cashRegister:Noti", source, Config.Strings.noti_title, Config.Strings.insufficient_funds_customer, "error")
    end
end)

RegisterServerEvent("bt-cashregisters:sellReceipts")
AddEventHandler("bt-cashregisters:sellReceipts", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = xPlayer.getInventoryItem("receipt")
    if amount and amount.count >= 1 then
        xPlayer.removeInventoryItem('receipt', amount.count)
        TriggerClientEvent("bt-cashregister:progressBar", source, amount.count)
    else
        TriggerClientEvent("cashRegister:Noti", source, Config.Strings.noti_title, Config.Strings.no_receipts, "error")
    end
end)

RegisterServerEvent("bt-cashregister:receiptSold")
AddEventHandler("bt-cashregister:receiptSold", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local payout = amount * Config.ReceiptValue
    xPlayer.addAccountMoney('money', payout)
    if Config.Logs then
        ESX.DiscordLogFields("CashRegister", "Cash Register", "green", {
            { name = "Info", value = xPlayer.getName() .. " (" .. xPlayer.source .. ") Has turned in " .. amount .. "x receipts for $" .. payout, inline = false },
            { name = "License of Employee",  value = GetPlayerIdentifierByType(xPlayer.source, 'license') ,   inline = false },
        })
    end
    TriggerClientEvent("cashRegister:Noti", source, Config.Strings.noti_title, Config.Strings.receipt_sold .. payout, "success")
end)


RegisterServerEvent("cashRegister:RequestPayment")
AddEventHandler("cashRegister:RequestPayment", function(customer, employee, amount)
    TriggerClientEvent("cashRegister:HandlePaymentResponse", customer, employee, amount)
end)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
	    return xPlayer.getName()
    end
end

RegisterNetEvent('bt-cashregisters:getPlayerNames')
AddEventHandler('bt-cashregisters:getPlayerNames', function(playerServerIds)
    local playerNames = {}
    for i=1, #playerServerIds do
        local name = GetRealPlayerName(playerServerIds[i])
        if name then
            table.insert(playerNames, {value = playerServerIds[i], label = name .. " (" .. playerServerIds[i] .. ")"})
        end
    end
    TriggerClientEvent('bt-cashregisters:setPlayerNames', source, playerNames)
end)