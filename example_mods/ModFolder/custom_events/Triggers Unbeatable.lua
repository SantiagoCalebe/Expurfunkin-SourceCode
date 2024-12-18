local fellasFlip = 1
local fellasCount = 3
local enableHeadVelocity = true
local ropeFlip = 1
local duckTrick = -1
local disableFireBar = false
function onCreatePost()
    --[[
    local loadedFellas = false
    local loadedDuckShot = false
    for events = 0,getProperty('eventNotes.length')-1 do
        if getPropertyFromGroup('eventNotes',events,'event') == 'Triggers Unbeatable' then
            local event = getPropertyFromGroup('eventNotes',events,'value1')
            if event == '28' and not loadedFellas then
                createFellas('Left',10,-200)
                createFellas('Right',screenWidth-200,-200)
                loadedFellas = true
            elseif event == '29' and not loadedDuckShot then
                loadedDuckShot = true
                makeLuaSprite('duckShot','mario/beatus/duckCrosshair',0,0)
                setProperty('duckShot.antialiasing',false)
                scaleObject('duckShot',17,14.4)
                setObjectCamera('duckShot','other')
                setProperty('duckShot.alpha',0.001)
                addLuaSprite('duckShot',true)
            end
        end
    end]]--
    createFellas('Left',10,-200)
    createFellas('Right',screenWidth-200,-200)

    makeLuaSprite('duckShot','mario/beatus/duckCrosshair',0,0)
    setProperty('duckShot.antialiasing',false)
    scaleObject('duckShot',17,14.4)
    setObjectCamera('duckShot','other')
    setProperty('duckShot.alpha',0.001)
    addLuaSprite('duckShot',true)

    precacheImage('mario/beatus/fireBar')
    makeAnimatedLuaSprite('fireBar','mario/beatus/fireBar',0,0)
    addAnimationByPrefix('fireBar','anim','firebar loop',10,false)
    setObjectCamera('fireBar','hud')
    scaleObject('fireBar',6,6)
    setProperty('fireBar.antialiasing',false)
    addLuaSprite('fireBar',true)
    setProperty('fireBar.visible',false)
    setProperty('fireBar.flipY',downscroll)
end
function resetHeadVelocity()
    for fellas = 0,fellasCount do
        if enableHeadVelocity then
            setProperty('FellasLeft'..fellas..'.velocity.y',500)
            setProperty('FellasRight'..fellas..'.velocity.y',-500)
        else
            setProperty('FellasLeft'..fellas..'.velocity.y',0)
            setProperty('FellasRight'..fellas..'.velocity.y',0)
        end
    end
end

function createFellas(side,x,y)
    local rope = 'Rope'..side
    makeAnimatedLuaSprite(rope,'mario/beatus/ycbu_lightning',x,y)
    addAnimationByPrefix(rope,'rope','lightning',24,true)
    setScrollFactor(rope,0,0)
    scaleObject(rope,1,1.2)
    addLuaSprite(rope,true)
    setProperty(rope..'.alpha',0.001)
    for fellas = 0,fellasCount do
        local name = 'Fellas'..side..fellas
        makeAnimatedLuaSprite(name,'mario/beatus/YouCannotBeatUS_Fellas_Assets',x - 100,y + (300*fellas))
        setScrollFactor(name,0,0)
        setObjectOrder(name,math.min(getObjectOrder('boyfriendGroup'),getObjectOrder('dadGroup'),getObjectOrder('gfGroup'))-1)
        scaleObject(name,0.6,0.6)
        
        addAnimationByPrefix(name,'Bird','Bird Up',24,true)
        addOffset(name,'Bird',30,30)

        addAnimationByPrefix(name,'Lakitu','Lakitu',24,true)
        addOffset(name,'Lakitu',40,40)

        addAnimationByPrefix(name,'Rotat','Rotat e',24,true)
        addOffset(name,'Rotat',100,100)

        if side == 'Right' then
            setProperty(name..'.velocity.y',500)
        else
            setProperty(name..'.velocity.y',-500)
        end
        addLuaSprite(name,true)
        
        setProperty(name..'.y',y + (500*fellas))
        setProperty(name..'.alpha',0.001)
    end
end
function onUpdate(el)
    for fellas = 0,fellasCount do
        for i, names in pairs({'FellasLeft'..fellas,'FellasRight'..fellas}) do
            if getProperty(names..'.y') < -600 then
                setProperty(names..'.y',screenHeight)
            end
            if getProperty(names..'.y') > screenHeight then
                setProperty(names..'.y',-600)
            end
        end
    end
    if luaSpriteExists('fireBar') and getProperty('fireBar.visible') then
        setProperty('fireBar.x',getProperty('healthBar.x') - 250)
        if not downscroll then
            setProperty('fireBar.y',getProperty('healthBar.y') - 170)
        else
            setProperty('fireBar.y',getProperty('healthBar.y') - 500)
        end
        local health = 2.1
        local barFrame = getProperty('fireBar.animation.curAnim.curFrame')
        if getProperty('fireBar.animation.curAnim.finished') == true then
            if downscroll then
                setProperty('fireBar.angle',(getProperty('fireBar.angle') - 90)%360)
            else
                setProperty('fireBar.angle',(getProperty('fireBar.angle') + 90)%360)
            end
            
            playAnim('fireBar','anim',true)
        end
        if disableFireBar and (getProperty('fireBar.angle') > 90 and (barFrame > 4 or getProperty('fireBar.angle') < 270 and barFrame < 7))    then
            setProperty('fireBar.visible',false)
        end

        if barFrame < 7 and getProperty('fireBar.angle') == 0 then
            health = 2/(1 + (barFrame/7))
        elseif getProperty('fireBar.angle') == 270 and barFrame > 5 then
            health = 1.8
        end

        if(getHealth() >= health) then
            setHealth(getHealth() - el * 2)
            setProperty('iconP1.color',getColorFromHex('3B3B3B'))
            setProperty('iconP1.angle',getRandomFloat(-20, 20))
            doTweenAngle('iconP1Angle','iconP1',0,stepCrochet*0.002,'backOut');
            doTweenColor('iconP1Color','iconP1','FFFFFF', stepCrochet*0.002,'circOut');
        end
    end
end

function onEvent(name,v1,v2)
    if name == 'Triggers Unbeatable' then
        if v1 == '21' then
            disableFireBar = false
            playAnim('fireBar','anim',true)
            setProperty('fireBar.visible',true)
            setProperty('fireBar.angle',180)

        elseif v1 == '22' then
            disableFireBar = true

        elseif v1 == '28' then
            if v2 == '0' or v2 == '' then
                for head = 0,fellasCount do
                    setProperty('FellasLeft'..head..'.alpha',0)
                    setProperty('FellasRight'..head..'.alpha',0)
                end
                setProperty('RopeLeft.alpha',0)
                setProperty('RopeRight.alpha',0)

            elseif v2 == '1' then
                for head = 0,fellasCount do
                    setProperty('FellasLeft'..head..'.alpha',1)
                    setProperty('FellasRight'..head..'.alpha',1)
                    setObjectOrder('FellasLeft'..head,getObjectOrder('RopeLeft')+1)
                    setObjectOrder('FellasRight'..head,getObjectOrder('RopeRight')+1)
                end
                setProperty('RopeLeft.alpha',1)
                setProperty('RopeRight.alpha',1)


            elseif v2 == '2' then
                doFellasImpulse()
            elseif v2 == '4' then
                enableFellasVelocity(false)
                doFellasImpulse()
            elseif v2 == '5' then
                enableFellasVelocity(true)
            elseif v2 == '6' then
                local position = {10,screenWidth - 200}
                local left = 0
                local right = 0
                if ropeFlip == 1 then
                    left = position[2]
                    right = position[1]
                else
                    left = position[1]
                    right = position[2]
                end
                
                for fellas = 0,fellasCount do
                    doTweenX('FellasLeftX'..fellas,'FellasLeft'..fellas,left - 100,stepCrochet*0.003,'linear')
                    doTweenX('FellasRightX'..fellas,'FellasRight'..fellas,right - 100,stepCrochet*0.003,'linear')
                end
                doFellasImpulse()
                doTweenX('RopeLeftX','RopeLeft',left,stepCrochet*0.003,'linear')
                doTweenX('RopeRightX','RopeRight',right,stepCrochet*0.003,'linear')
                ropeFlip = ropeFlip * -1
                fellasFlip = ropeFlip
            elseif v2 == '7' then
                for fellas = 0,fellasCount do
                    playAnim('FellasRight'..fellas,'Rotat')
                    playAnim('FellasLeft'..fellas,'Rotat')
                end
            elseif v2 == '8' then
                for fellas = 0,fellasCount do
                    playAnim('FellasRight'..fellas,'Bird')
                    playAnim('FellasLeft'..fellas,'Bird')
                end
            elseif v2 == '9' then
                for fellas = 0,fellasCount do
                    playAnim('FellasRight'..fellas,'Lakitu')
                    playAnim('FellasLeft'..fellas,'Lakitu')
                end
            end
        elseif v1 == '29' then
            if v2 ~= '1'  then
                setProperty('duckShot.alpha',1)
                duckTrick = duckTrick * -1
                if duckTrick == 1 then
                    setProperty('duckShot.color',getColorFromHex("FFFFFF"))
                else
                    setProperty('duckShot.color',getColorFromHex("FF0000"))
                end
            else
                setProperty('duckShot.alpha',0)
                duckTrick = duckTrick -1
            end
        
        end
    end
end

function enableFellasVelocity(enable)
    enableHeadVelocity = enable
    resetHeadVelocity()
end
function doFellasImpulse()
    for fellas = 0,fellasCount do
        setProperty('FellasRight'..fellas..'.velocity.y',1000*fellasFlip*-1)
        setProperty('FellasLeft'..fellas..'.velocity.y',1000*fellasFlip)
    end
    runTimer('ResetFellasVelocity',stepCrochet*0.002)
    fellasFlip = fellasFlip * -1
end
function onTimerCompleted(tag)
    if tag == 'ResetFellasVelocity' then
        resetHeadVelocity()
    end
end