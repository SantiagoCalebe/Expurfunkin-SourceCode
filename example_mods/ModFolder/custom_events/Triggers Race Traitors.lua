local shellCount = 0
local shellDestroyed = 0
local randomBox = false
local boxSetted = false
function onCreate()
    precacheImage('modstuff/redshell')

    makeAnimatedLuaSprite('cajamk','modstuff/cajamk',0,not downscroll and -200 or screenHeight + 200)
    for i, items in pairs({'1up','ghost','shell','nada','bomb'}) do
        addAnimationByPrefix('cajamk',items,'cajamk '..items,0,false)
    end
    addAnimationByPrefix('cajamk','random','cajamk random',24,true)
    setObjectCamera('cajamk','hud')
    screenCenter('cajamk','x')
    addLuaSprite('cajamk',true)
end
local fps = 0
function onUpdate(el)
    if randomBox then
        fps = fps + el
        if fps > 1/24 then
            local anims = {'1up','ghost','shell','bomb'}
            local rand = 0
            repeat
                rand = getRandomInt(1,#anims)
            until getProperty('cajamk.animation.curAnim.name') ~= anims[rand]
            playAnim('cajamk',anims[rand])
            fps = 0
        end
    end
    if shellCount > shellDestroyed then
        for reds = shellDestroyed,shellCount do
            local name = 'redshell'..reds
            if getProperty(name..'.x') >= getProperty('iconP1.x') - 40 then
                setProperty(name..'.velocity.x',-200)
                setProperty(name..'.velocity.y',-400)
                setProperty(name..'.acceleration.y',1200)
                runHaxeCode(
                    [[
                        FlxTween.tween(game,{health: game.health - 0.1},0.2,{ease: FlxEase.quartOut});
                        return;
                    ]]
                )
            end
            if getProperty(name..'.velocity.x') <= 0 then
                setProperty(name..'.angle',getProperty(name..'.angle')+(el*1000))

            end
            if getProperty(name..'.y') > screenHeight then
                removeLuaSprite(name,true)
                shellDestroyed = shellDestroyed + 1
            end
        end
    end
end
function setBoxItem(item)
    randomBox = false
    setProperty('cajamk.y',getProperty('cajamk.y')-10)
    doTweenY('cajamkY','cajamk',defaultOpponentStrumY0,0.1,'cubeIn')
    playAnim('cajamk',item)
end
function onEvent(name,v1,v2)
    if name == 'Triggers Race Traitors' then
        if v1 == '2' then
            if not boxSetted then
                doTweenY('cajamkY','cajamk',defaultOpponentStrumY0,2,'cubeOut')
            end
            randomBox = true
        elseif v1 == '3' then
            
            setBoxItem('shell')
        elseif v1 == '4' then
            setBoxItem('ghost')
        elseif v1 == '5' then
            setBoxItem('bomb')
        elseif v1 == '7' then
            makeLuaSprite('redshell'..shellCount,'modstuff/redshell',-600,getProperty('iconP1.y'))
            setObjectCamera('redshell'..shellCount,'hud')
            addLuaSprite('redshell'..shellCount,true)
            setProperty('redshell'..shellCount..'.velocity.x',3000)
            shellCount = shellCount + 1
        elseif v1 == '8' then
            setBoxItem('1up')
            runHaxeCode(
                [[
                    FlxTween.tween(game,{songSpeed: ]]..v2..[[},16);
                    return;
                ]]
            )
        end
    end
end