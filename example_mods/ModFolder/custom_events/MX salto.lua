local jumping = false

local dadY = 0
function onCreate()

    precacheImage('mario/MX/MM_Boyfriend_Assets_jump')
    makeAnimatedLuaSprite('bfSalto','mario/MX/MM_Boyfriend_Assets_jump',1120,185)
    scaleObject('bfSalto', 2.0, 2.0);
    addAnimationByPrefix('bfSalto','jump','JUMP0',30,false)
    addAnimationByPrefix('bfSalto','land','JUMPLAND',30,false)
    setProperty('bfSalto.visible',false)
    addLuaSprite('bfSalto',true)

    precacheImage('modstuff/cuidao')
    makeLuaSprite('powJump','modstuff/cuidao0',0,0)
    setObjectCamera('powJump','hud')
    scaleObject('powJump',8,8)
    setProperty('powJump.alpha',0.001)
    screenCenter('powJump')
    setProperty('powJump.antialiasing',false)
    addLuaSprite('powJump')

    precacheSound('warningmx2')
end
function bfJump()
    jumping = true
    setProperty('boyfriend.visible',false)
    setProperty('bfSalto.visible',true)
    playAnim('bfSalto','jump',false)
    setProperty('bfSalto.offset.y',260)
    runTimer('bfJump',0.1)
end
function onUpdate()
   if (getMouseX('camHUD') > 1050 and getMouseX('camHUD') < 1280) and (getMouseY('camHUD') > 582.5 and getMouseY('camHUD') < 720 and mousePressed('left')) or keyPressed('space') then
        bfJump()
    end
    if jumping then
        setProperty('bfSalto.x',getProperty('boyfriend.x') - 149)
        setProperty('bfSalto.y',getProperty('boyfriend.y') - 30)
        if getProperty('bfSalto.animation.curAnim.finished') and getProperty('bfSalto.animation.curAnim.name') == 'land' then
            jumping = false
            setProperty('boyfriend.visible',true)
            setProperty('bfSalto.visible',false)
        end
    end

end
function onEvent(name,v1,v2)
    if name == 'MX salto' then
        runTimer('powMXJump',0.3)
        runTimer('powMXDodge',0.6)
        playSound('warningmx')
        dadY = getProperty('dad.y')
        doTweenY('dadY','dad',dadY - 300,0.3,'expoOut')
        loadGraphic('powJump','modstuff/cuidao0')
        setProperty('powJump.alpha',1)
    end
end
function onTimerCompleted(tag)
    if tag == 'bfJump' then
        doTweenY('bfJumpUp','bfSalto.offset',510,0.3,'expoOut')
    elseif tag == 'powMXJump' then
        doTweenY('dadY','dad',dadY,-100.4,'expoIn')
        loadGraphic('powJump','modstuff/cuidao')
    elseif tag == 'powMXDodge' then
        setProperty('powJump.alpha',0)
        cameraShake('game',0.005,0.1)
        cameraShake('hud',0.005,0.1)
        bfJump()
        if not jumping and not botPlay then
            runHaxeCode(
                [[
                    FlxTween.tween(game,{health: game.health - 1},1);
                    return;
                ]]
            )
        end
    end
end
function onTweenCompleted(tag)
    if tag == 'bfJumpUp' then
        doTweenY('bfLand','bfSalto.offset',200,0.3,'quintIn')
    elseif tag == 'bfLand' then
        playAnim('bfSalto','land')
        setProperty('bfSalto.offset.y',-80)
    end
end