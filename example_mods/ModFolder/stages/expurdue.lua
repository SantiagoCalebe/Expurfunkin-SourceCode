function onCreate()

    makeLuaSprite("twitter","modstuff/expurdue/twitter", -1000, -500) --BG
    addLuaSprite("twitter", false)
    setLuaSpriteScrollFactor("twitter", 0.2,0.2)
    scaleObject('twitter', 10, 10)
    
    createInstance('backdrop', 'flixel.addons.display.FlxBackdrop', {nil, 0x01}); --MOVING TWITTERS FUCK
    loadGraphic('backdrop', 'modstuff/expurdue/backdrop');
    setProperty('backdrop.velocity.x', 1100)
    addInstance('backdrop');
    callMethod('backdrop.setPosition',{0, 0})
    setObjectCamera('backdrop', 'HUD')
    setProperty('backdrop.alpha', 0)
    scaleObject('backdrop', 3.5, 3.5);

    makeLuaSprite('VG', 'modstuff/expurdue/ving', 0, 0) --VINGETTE FUCK
    setScrollFactor("VG", 1, 1)
    setObjectCamera('VG', 'Other')
    addLuaSprite("VG", false)

    function onEvent(name, value1, value2)
        if name == 'triggerOV' then
            if value1 == '1' then
                setProperty('backdrop.alpha', 0.7)
            elseif value1 == '2' then
                setProperty('backdrop.alpha', 0)
            end
        end
    end
end

