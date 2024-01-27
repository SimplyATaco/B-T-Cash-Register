Config = {}

Config.JobCommisions = {
    default = {society = 0.75, employee = 0.25}, -- Default split (If job is not in this table then it will go with default commission)
    cluckinbell = {society = 0.75, employee = 0.25},
    bahama = {society = 0.75, employee = 0.25},
    bennys = {society = 0.15, employee = 0.85},
}

Config.Receipts = true -- Should employees receive receipts after every transaction
Config.ReceiptItem = "receipt" -- Name of receipt item (Only if Config.Receipts = true)
Config.ReceiptValue = 50 -- How much should each receipt be worth? (Only if Config.Receipts = true)
Config.ReceiptLocation = vector3(241.6949, 226.1834, 106.3947) -- Coordinates for turning in receipts (Only if Config.Receipts = true)
Config.ReceiptTime = 500 -- Amount of time it takes to sell each receipt (Default: 500 ms)

Config.RegisterCommand = false -- Should players have the ability to do /"Config.Command" to open cash register
Config.Command = "register" -- Name of command to open cash register (Only if Config.RegisterCommand = true)

Config.RegisterDistance = 6 -- Amount of distance that should be checked for nearby players

Config.Logs = false -- Should transactions be logged to discord? (If true follow instructions in readme.txt)

Config.Strings = {
    insufficient_funds = 'Customer has insufficient funds!',
    insufficient_funds_customer = 'You have insufficient funds!',
    customer_charged = 'You have been charged $',
    customer_paid = 'Customer has paid $',
    employee_received = ' and you have received $',
    receipt_sold = 'You have turned in your receipts for $',
    selling_receipts = 'Cashing in Receipts',
    no_receipts = 'You do not have receipts to turn in!',
    noti_title = 'Cash Register'
}