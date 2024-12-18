function onCreatePost()
    makeAnimatedLuaSprite('lavaHUD','modstuff/Luigi_IHY_Background_Assets_Lava',-10,not downscroll and screenHeight or -300)
    scaleObject('lavaHUD', 2.0, 2.0);
    addAnimationByPrefix('lavaHUD','anim','Lava',24,true)
    setObjectCamera('lavaHUD','hud')
    setProperty('lavaHUD.flipY',downscroll)
    --addLuaSprite('lavaHUD',false)

    makeLuaSprite('lavaHUDBG',nil,0,0)
    makeGraphic('lavaHUDBG',screenWidth,screenHeight,'B00000')
    setObjectCamera('lavaHUDBG','hud')
    --addLuaSprite('lavaHUDBG',false)
    if version <= '0.6.3' then
        runHaxeCode(
            [[
                game.insert(game.members.indexOf(game.healthBar),game.getLuaObject('lavaHUD'));
                game.insert(game.members.indexOf(game.healthBar),game.getLuaObject('lavaHUDBG'));
                return;
            ]]
        )
    else
        runHaxeCode(
            [[
                game.uiGroup.insert(game.uiGroup.members.indexOf(game.healthBar),game.getLuaObject('lavaHUD'));
                game.uiGroup.insert(game.uiGroup.members.indexOf(game.healthBar),game.getLuaObject('lavaHUDBG'));
                return;
            ]]
        )
    end
end
function onUpdate()
    setProperty("lavaHUDBG.y",getProperty('lavaHUD.y') + (not downscroll and 260 or -700))
end
function onEvent(name,v1,v2)
    if name == 'Sacar Lava' then
        local pos = tonumber(v1)
        if pos == nil then
            pos = 630
        end
        if downscroll then
            pos = 720 - pos - 300
        end
        if v2 == '' or v2 == '0' then
            doTweenY('lavaHtY','lavaHUD',pos,0.25,'quadOut')
        elseif v2 == '1' then
            doTweenY('lavaHtY','lavaHUD',pos,2,'quadInOut')
        elseif v2 == '2' then
            doTweenY('lavaHtY','lavaHUD',pos,5,'quadInOut')
        elseif v2 == '3' then
            cancelTween('lavaHtY')
        end
    end
end