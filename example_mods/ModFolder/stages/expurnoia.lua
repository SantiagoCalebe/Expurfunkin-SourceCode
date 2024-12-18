function onCreate()
    makeLuaSprite("twitter","modstuff/expurnoia/twitter", -1000, -500) --BG
    addLuaSprite("twitter", false)
    setLuaSpriteScrollFactor("twitter", 0.2,0.2)
    scaleObject('twitter', 10, 10)

    makeLuaSprite("twitter2","modstuff/expurnoia/twitter2", -500, -500) --BG2
    setLuaSpriteScrollFactor("twitter2", 0.2,0.2)
    --addLuaSprite("twitter2", false)
    scaleObject('twitter2', 2, 2)

    makeLuaSprite('VG', 'modstuff/expurnoia/ving', 0, 0) --VINGETTE FUCK
    setScrollFactor("VG", 1, 1)
    setObjectCamera('VG', 'Other')
    addLuaSprite("VG", false)
end
