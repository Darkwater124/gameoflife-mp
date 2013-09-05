function love.conf(t)
    t.title             = "Game of Life MP"
    t.author            = "Darkwater"
    t.url               = "https://github.com/Darkwater124/gameoflife-mp"
    t.identity          = "golmp"
    t.version           = "0.9.0"
    t.window.width      = 800
    t.window.height     = 600
    t.window.fullscreen = false
    t.window.vsync      = true
    t.window.fsaa       = 0
    t.modules.joystick  = false
    t.modules.audio     = true
    t.modules.keyboard  = true
    t.modules.event     = true
    t.modules.image     = true
    t.modules.graphics  = true
    t.modules.timer     = true
    t.modules.mouse     = true
    t.modules.sound     = true
    t.modules.physics   = false
end
