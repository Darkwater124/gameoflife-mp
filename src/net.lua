net = {}
net.hosting = false
net.inLobby = false
net.username = "whut"

function net.startHostingLobby(port)
    port = tonumber(port)
    if not port or port < 1 then
        port = 25545
    end

    print("Started listening on port " .. port)

    net.host = enet.host_create("localhost:" .. port)
    net.hosting = true
    net.inLobby = true

    lobby.show()
end

function net.joinLobby(ip, port)
    port = tonumber(port)
    if not ip or #ip < 1 or not port or port < 1 then
        print(ip, port)
        error("Trying to join an invalid address.")
    end

    print("Joining " .. ip .. ":" .. port)

    net.client = enet.host_create()
    net.server = net.client:connect(ip .. ":" .. port)
    net.hosting = false
    net.inLobby = true

    lobby.show()
end

function net.update(dt)
    if net.inLobby then
        if net.hosting then

            -- Hosting a lobby
            local event = net.host:service(0)

            if event then
                if event.type == "connect" then

                    -- Client connected
                    print("Client connected", event.peer, event.peer:connect_id(), event.peer:index())
                    event.peer:send(net.hostname)


                elseif event.type == "receive" then

                    -- Client sent a message
                    print("Client sent msg ", event.peer, event.peer:connect_id(), event.peer:index(), event.data)
                    ui.getElementById("lobby_players"):addString(event.data)

                end
            end

        else

            -- In another lobby
            local event = net.client:service(0)
            if event then
                if event.type == "connect" then

                    -- Connected
                    event.peer:send(net.username)

                elseif event.type == "receive" then

                    -- Message received
                    lobby.setHostname(event.data)

                end
            end

        end
    end
end

function net.shutdown()
    if net.server then
        net.server:disconnect()
    end

    if net.client then
        net.client:flush()
    end
end
