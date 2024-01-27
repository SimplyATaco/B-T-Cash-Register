# B&T Cash Register
 Elevate your FiveM server with B&T Cash Register, a streamlined billing system designed for efficient in-game transactions. This script enhances commercial interactions, making it a must-have for servers focused on immersive gameplay.


## Preview

[https://www.youtube.com/watch?v=GKHEDW6_lB8]

## Features



## Requirements

* ESX (Legacy 1.2+)
* [PolyZone](https://github.com/mkafrin/PolyZone/releases/tag/v2.6.1)
* [Ox Lib](https://github.com/overextended/ox_lib/releases/tag/v3.16.2)
* [Ox Target](https://github.com/overextended/ox_target/releases/tag/v1.13.1)

## Installation Instructions

### Item Code for OX-Inventory:
```lua
['receipt'] = {
    label = 'Receipt',
    weight = 15,
    stack = true,
},

```

### If Logs is enabled

Go to es_extended > config.logs.lua
Add the following code to Webhooks

```lua
 CashRegister = 'DISCORD_WEBHOOK'
```

Example:

```lua
Config.DiscordLogs = {
    Webhooks = {
        default = 'DISCORD_WEBHOOK',
        test = 'DISCORD_WEBHOOK',
        Chat = 'DISCORD_WEBHOOK',
        UserActions = 'DISCORD_WEBHOOK',
        Resources = 'DISCORD_WEBHOOK',
        Paycheck = 'DISCORD_WEBHOOK',
        CashRegister = 'DISCORD_WEBHOOK'
    },

    Colors = { -- https://www.spycolor.com/
        default = 14423100,
        blue = 255,
        red = 16711680,
        green = 65280,
        white = 16777215,
        black = 0,
        orange = 16744192,
        yellow = 16776960,
        pink = 16761035,
        lightgreen = 65309
    }
}

```

To make a cash register work use the following event

```lua  
    TriggerEvent("bt-cashregister:openRegister)
```

Example:

```lua
    exports.ox_target:addBoxZone({
    coords = vec3(-432.5, 277.06, 83.42),
    size = vec3(1.0, 1.0, 1.25),
    rotation = 355,
    debug = false,
    drawSprite = true,
    options = {
        {
            name = 'bennysRegister',
            event = 'bt-cashregister:openRegister',
            icon = 'fa-solid fa-money-bill',
            label = "Cash Register", 
            groups = {['bennys'] = 0} -- Job Name
        }
    }
    })
```

## Need Support?

[https://discord.gg/bntscripts]

