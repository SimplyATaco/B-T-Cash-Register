ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("cashRegister:Noti")
AddEventHandler("cashRegister:Noti", function(title, text, nType)
    lib.notify({
        title = title,
        description = text,
        position = 'center-right',
        type = nType
    })
end)

RegisterNetEvent("cashRegister:HandlePaymentResponse")
AddEventHandler("cashRegister:HandlePaymentResponse", function(employee, amount)
    local input = lib.inputDialog('Cash Register', {
    {type = 'select', label = 'Amount Due $' .. amount, 
      options = {
        {
          value = "money",
          label = "Cash",
        },
        {
          value = "bank",
          label = "Card",
        }
      }, default = "money"},
    })

    if input then
      local method = input[1]
      TriggerServerEvent("cashRegister:ChargeCustomer", employee, method, amount)
    end
end)

RegisterNetEvent("bt-cashregister:openRegister")
AddEventHandler("bt-cashregister:openRegister", function()
  local pedCoords = GetEntityCoords(PlayerPedId())
  playersNearby = ESX.Game.GetPlayersInArea(pedCoords, Config.RegisterDistance)

  if #playersNearby == 0 then
    ShowCashRegisterDialog({{value = "none", label = "No customers nearby"}})
  else
    local playerServerIds = {}
    for i=1, #playersNearby do
      table.insert(playerServerIds, GetPlayerServerId(playersNearby[i]))
    end

    TriggerServerEvent('bt-cashregisters:getPlayerNames', playerServerIds)
  end
end)

local canSell = true

RegisterNetEvent("bt-cashregister:sellReceipts")
AddEventHandler("bt-cashregister:sellReceipts", function()
  if canSell then
    canSell = false
    TriggerServerEvent('bt-cashregisters:sellReceipts')
    Wait(2500)
    canSell = true
  end
end)

function ShowCashRegisterDialog(customerOptions)
  local input = lib.inputDialog('Cash Register', {
    {type = 'select', label = 'Customer', options = customerOptions, default = customerOptions[1].value},
    {type = 'number', label = 'Amount', description = '', icon = 'dollar-sign', min = 0, max = 1000000},
  })

  if input then
    local amount = input[2]
    local employee = GetPlayerServerId(PlayerId())

    if input[1] ~= "none" then
      closestPlayer = input[1]
      TriggerServerEvent("cashRegister:RequestPayment", closestPlayer, employee, amount)
    else
      TriggerEvent("cashRegister:Noti", Config.Strings.noti_title, 'No customer selected!', 'error')
    end
  else
    TriggerEvent("cashRegister:Noti", Config.Strings.noti_title, 'Payment input cancelled!', 'error')
  end
end

RegisterNetEvent('bt-cashregisters:setPlayerNames')
AddEventHandler('bt-cashregisters:setPlayerNames', function(playerNames)
  ShowCashRegisterDialog(playerNames)
end)

if Config.RegisterCommand then
  RegisterCommand(Config.Command, function()
    TriggerEvent("bt-cashregister:openRegister")
  end)
end

exports.ox_target:addBoxZone({
  coords = Config.ReceiptLocation,
  size = vec3(1.25, 1.25, 1.5),
  rotation = 180,
  debug = false,
  drawSprite = true,
  options = {
      {
          name = 'receiptSelling',
          event = 'bt-cashregister:sellReceipts',
          icon = 'fa-solid fa-receipt',
          label = "Cash In Receipts"
      }
  }
})

RegisterNetEvent('bt-cashregister:progressBar')
AddEventHandler('bt-cashregister:progressBar', function(amount)
  if lib.progressBar({
    duration = amount * Config.ReceiptTime,
    label = Config.Strings.selling_receipts,
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
        move = false,
    },
    anim = {
        scenario = 'PROP_HUMAN_BUM_SHOPPING_CART'
    },
  }) then 
    TriggerServerEvent("bt-cashregister:receiptSold", amount)
  end
end)
