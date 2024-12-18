function onCreatePost()
    makeLuaSprite('temp') ; setSpriteShader('temp', 'multisplit')
    setShaderFloat('temp', 'multi', 1)
    runHaxeCode("camGame.filters = [new ShaderFilter(game.getLuaObject('temp').shader)];")
end

function onEvent(e, v1)
    if e == 'multiplier' then
        setShaderFloat('temp', 'multi', tonumber(v1))
        flash()
        hud()
    end
end

function flash()
           makeLuaSprite('flash', '', 0, 0);
            makeGraphic('flash',1280,720,'ff0000')
              addLuaSprite('flash', true);
              setLuaSpriteScrollFactor('flash',0,0)
              setProperty('flash.scale.x',2)
              setProperty('flash.scale.y',2)
              setProperty('flash.alpha',0)
            setProperty('flash.alpha',1)
            doTweenAlpha('flTw','flash',0,0.5,'linear')
end

function hud()
    setProperty('camHUD.alpha', 0.5)
    runTimer('a', timeGo)
end

function onTimerCompleted(tag)
    if tag == 'a' then
    setProperty('camHUD.alpha', 1)
    end
    end