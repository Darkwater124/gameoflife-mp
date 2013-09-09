lobby = {}

function lobby.show()
    ui.clear()
    ui.add(elements.text({ text  = "game of", x = 280, y = 20, scale = 10 }))
    ui.add(elements.text({ text  = "lIfe mp", x = 280, y = 80, scale = 10 }))

    ui.add("lobby_host", elements.text({ text  = "host: ...", x = 394, y = 170, width = 300, height = 400, scale = 4}))
    ui.add("lobby_players", elements.list({ x = 510, y = 200, width = 300, height = 400, scale = 4 }))
end

function lobby.setHostname(name)
    net.hostname = name
    ui.getElementById("lobby_host").text = "host: " .. name
end
