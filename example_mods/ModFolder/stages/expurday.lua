function onCreate()

    makeLuaSprite("twitter","modstuff/expurday/twitter", 0, 0) --BG
    addLuaSprite("twitter", false)
    setLuaSpriteScrollFactor("twitter", 1 ,1)
    scaleObject('twitter', 2, 2)

    makeLuaSprite('VG', 'modstuff/expurday/ving', 0, 0) --VINGETTE FUCK
    setScrollFactor("VG", 1, 1)
    setObjectCamera('VG', 'Other')
    addLuaSprite("VG", false)
end

