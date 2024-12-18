local shellCount = 0
local shroomCount = 0
local marioState = 0

function onBeatHit()
    if getProperty('iconP2.animation.curAnim.curFrame') == 0 then
        setProperty('iconP2.y',getProperty('iconP2.y')-20)
        doTweenY('iconP2Y','iconP2',getProperty('iconP2.y')+20,stepCrochet*0.003,'circOut')
        setProperty('iconP2.flipX',not getProperty('iconP2.flipX'))
    end
end

function createShell()
    local name = 'shell'..shellCount
    makeLuaSprite(name,'shell',getProperty('dad.x') + 72,getProperty('dad.y') + 62)
    setProperty(name..'.antialiasing',false)
    setProperty(name..'.velocity.x',1500)
    setProperty(name..'.acceleration.y',500)
    scaleObject(name,4,4)
    addLuaSprite(name,true)
    updateHitbox(name)
    shellCount = shellCount%6 + 1
end

function createPoison()
    local name = 'shroom'..shellCount
    makeLuaSprite(name,'shroom',getProperty('dad.x') + 72,getProperty('dad.y') + 62)
    setProperty(name..'.antialiasing',false)
    setProperty(name..'.velocity.x',200)
    doTweenY(name..'Y',name,getProperty(name..'.y')+500,0.5,'circIn')
    scaleObject(name,4,4)
    addLuaSprite(name,true)
    updateHitbox(name)
    shroomCount = shroomCount%6 + 1
end
function disableNotes(time,mustPress)
    if getProperty('notes.length') > 0 then
        for notes = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes',notes,'mustPress') == mustPress and getPropertyFromGroup('notes',notes,'strumTime') < getSongPosition() + time then
                setPropertyFromGroup('notes',notes,'noAnimation',true)
            end
        end
    end
end
function onUpdate(el)
   for shells = 0,6 do
        local name = 'shell'..shells
        if luaSpriteExists(name) then
            if getProperty(name..'.velocity.x') >= 0  then
                if getProperty(name..'.x') >= getProperty('boyfriend.x') + 150 then
                    setProperty(name..'.velocity.x',-100)
                    setProperty(name..'.velocity.y',-500)
                    setProperty(name..'.acceleration.y',1200)
                    disableNotes(350,true)
                    setHealth(getHealth()-0.25)
                    playAnim('boyfriend','gf hit',true)
                    setProperty('boyfriend.specialAnim',true)
                    playSound('hit')
                end
            else
                setProperty(name..'.angle',getProperty(name..'.angle')+(el*1000))
            end
        end
   end
   if marioState == 1 then
        if getProperty('dad.animation.curAnim.name') == 'run' and getProperty('dad.x') >= 200 then
            playAnim('dad','jump3',true)
            setProperty('dad.specialAnim',true)
            setProperty('dad.velocity.y',-1200)
            setProperty('dad.acceleration.y',2700)
            playSound('hit')
        elseif getProperty('dad.animation.curAnim.name') == 'jump3' and getProperty('dad.velocity.y') > 0 and getProperty('dad.y') > 250 and getProperty('dad.x') < 1280 then
            playAnim('bf','gf hit',true)
            setProperty('gf.specialAnim',true)
            setProperty('dad.velocity.y',-1000)
            marioState = 0
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Triggers Bad Day' then
        if v1 == '2' then
            doTweenX('marioX','twitternotes',screenWidth/2 - 300,0.8,'quadOut')
            doTweenY('marioYJump','twitternotes',200,0.45,'quadOut')
            playAnim('twitternotes','jump')
        elseif v1 == '3' then
            if version <= '0.6.3' then
                setProperty('camFollowPos.x',-200)
                setProperty('camFollowPos.y',100)
            else
                setProperty('camGame.scroll.x',-400)
                setProperty('camGame.scroll.y',0)
            end
            setProperty('camGame.zoom',2)
            doTweenAlpha('blackAlpha','black',0,2,'circOut')
            setProperty('marioArrows.alpha',0)
        elseif v1 == '4' then
            callScript('scripts/cameraMoviment','doCamTween',{'dadX-100',nil,1.3,'expoOut'})
            doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom')+0.15,1.3,'sineOut')
        elseif v1 == '5' then
            setProperty('sideBarBf.alpha',0.5)
            setProperty('sideBarDad.alpha',0.5)
            setProperty('sideBarBf.visible',true)
            setProperty('sideBarDad.visible',true)
        elseif v1 == '6' then
            disableNotes(1000,false)
            if v2 == '1' then
                runTimer('createPoison'..shellCount,0.35)
                playAnim('dad','shroom',true)
                setProperty('dad.specialAnim',true)
            else
                runTimer('createShell'..shellCount,0.35)
                playAnim('dad','shell',true)
            end
            setProperty('dad.specialAnim',true)
        elseif v1 == '7' then

            setProperty('dad.velocity.x',-400)
            setProperty('dad.flipX',true)
            playAnim('dad','walk',true)
            setProperty('dad.specialAnim',true)
            runTimer('marioRunning',1.1)
            marioState = 1
        elseif v1 == '8' then
            cancelTimer('marioRunning')
            marioState = 2
            setProperty('dad.acceleration.y',0)
            setProperty('dad.flipX',false)
            setProperty('dad.velocity.x',0)
            setProperty('dad.velocity.y',0)

            setProperty('dad.x',getProperty('dadGroup.x')+ getProperty('dad.positionArray[0]') - 200)
            setProperty('dad.y',getProperty('dadGroup.y') + getProperty('dad.positionArray[1]'))
            doTweenX('dadX','dad',getProperty('dad.x')+200,0.5,'linear')
            playAnim('dad','walk')
        elseif v1 == '10' then
            setProperty('marioArrows.flipX',false)

            setProperty('marioArrows.x',screenWidth-50)
            scaleObject('marioArrows',4,4)
            setProperty('marioArrows.alpha',1)


            setObjectCamera('marioArrows','hud')
            setProperty('marioArrows.velocity.x',-280)
            if not downscroll and not middlescroll then
                setProperty('marioArrows.y',50)
                playSound('hit')
                playAnim('marioArrows','spin')
                setProperty('marioArrows.velocity.y',-750)
                setProperty('marioArrows.acceleration.y',1900)
            else
                setProperty('marioArrows.y',screenHeight)
            end
        elseif v1 == '11' then
            if v2 ~= '4' then
                local id = 3 - tonumber(v2)
                local noteY = getPropertyFromGroup('playerStrums',id,'y')

                if not downscroll and not middlescroll then
                    noteTweenY('noteUniY'..(id+4),id+4,noteY+80,0.3,'circOut')
                    setProperty('marioArrows.velocity.y',-400)
                    playSound('hit')
                    createMarioFlash()
                else
                    runTimer('noteGoUp'..(id+4),0.1)
                    playSound('hit')


                    playAnim('twitternotes','jump')
                    cancelTween('marioArrowY')

                    if middlescroll and not downscroll then
                        setProperty('marioArrows.y',-150)
                        setProperty('marioArrows.flipY',true)
                        doTweenY('marioArrowY','twitternotes',noteY - 60,0.2,'linear')
                    else
                        setProperty('marioArrows.y',screenHeight)
                        doTweenY('marioArrowY','twitternotes',noteY,0.2,'linear')
                    end
                    
                    setProperty('marioArrows.x',getPropertyFromGroup('playerStrums',id,'x')+40)
                    
                end
                
            else
                playSound('hit')
                if not downscroll then
                    doTweenAngle('healthBarAngle','healthBar',50,2,'circOut')
                    doTweenY('healthBarY','healthBar',screenHeight+200,2,'circIn')
                end
            end
        elseif v1== '14' then
            if not downscroll and not middlescroll then
                hpGoDown()
                setProperty('marioArrows.velocity.y',-350)
                createMarioFlash()
            else
                if downscroll then
                    makeLuaSprite('shellHP','mario/BadMario/shell',0,screenHeight)
                    doTweenY('shellHPY','shellHP',getProperty('healthBar.y'),0.3,'linear')
                else
                    makeLuaSprite('shellHP','mario/BadMario/shell',0,-50)
                    doTweenY('shellHPY','shellHP',getProperty('healthBar.y')-50,0.3,'linear')
                    setProperty('shellHP.flipY',true)
                end
                scaleObject('shellHP',4,4)
                setProperty('shellHP.antialiasing',false)
                setObjectCamera('shellHP','hud')
                screenCenter('shellHP','x')

                addLuaSprite('shellHP',true)
            end
        end
    end
end

function createMarioFlash()
    setProperty('arrowFlash.x',getProperty('marioArrows.x')+40)
    setProperty('arrowFlash.y',getProperty('marioArrows.y')+125)
    setProperty('arrowFlash.alpha',1)
    playAnim('arrowFlash','anim',true)
end
function hpGoDown()
    callScript('extra_scripts/extraCam','insertObjectOnCam',{'healthBar'})
    if version <= '0.6.3' then
        callScript('extra_scripts/extraCam','insertObjectOnCam',{'healthBarBG'})
    end
    callScript('extra_scripts/extraCam','insertObjectOnCam',{'iconP1'})
    callScript('extra_scripts/extraCam','insertObjectOnCam',{'iconP2'})

    if downscroll then
        doTweenY('extraCamY','extraCam',screenHeight+100,1,'backIn')
        doTweenY('scoreTxtY','scoreTxt',25,3,'cubeInOut')
    else
        doTweenY('extraCamY','extraCam',screenHeight + 500,1,'cubeIn')
    end
    doTweenAngle('extraCamAngle','extraCam',20,1,'cubeIn')
end
function onTweenCompleted(tag)
    if tag == 'marioYJump' then
        doTweenY('marioYFall','marioArrows',330,0.35,'quadIn')
        runTimer('marioFall',0.1)
        
    elseif tag == 'marioArrowY' then
        if downscroll then
            doTweenY('marioArrowYDown','twitternotes',screenHeight,0.2,'circIn')
        else
            doTweenY('marioArrowYDown','twitternotes',-150,0.2,'circIn')
        end
        playAnim('marioArrows','fall')
    elseif string.find(tag,'shroom',0,true) then
        removeLuaSprite(string.gsub(tag,'Y',''),true)

    elseif tag == 'shellHPY'  then
        
        playSound('hit')
        if not downscroll then
            doTweenY('shellHPYDown','shellHP',screenHeight,0.8,'backIn')
        else
            doTweenY('shellHPYDown','shellHP',screenHeight,1.2,'backIn')
        end
        doTweenAngle('shellHPAngle','shellHP',960,1.5,'linear')
        setProperty('shellHP.velocity.x',50)
        hpGoDown()
    elseif tag == 'shellHPYDown' then
        cancelTween('shellHPAngle')
        removeLuaSprite('shellHP',true)
    end
end
function onSectionHit()
    if curSection == 1 then
        setProperty('camZooming',true)
        playAnim('dad','singDOWN',true)
        setProperty('dad.holdTimer',0)
    end
end
function getNoteColor(data)
    if data == 0 then
        return 'D67FFF'
    elseif data == 1 then
        return '7FB2FF'
    elseif data == 2 then
        return '7FFF7F'
    elseif data == 3 then
        return 'FF7F7F'
    end
    return 'FFFFFF'
end
function goodNoteHit(id,data,type,sus)
    setProperty('sideBarBf.color',getColorFromHex(getNoteColor(data)))

end
function opponentNoteHit(id,data,type,sus)
    setProperty('sideBarDad.color',getColorFromHex(getNoteColor(data)))
end
function onTimerCompleted(tag)
    if string.find(tag,'createShell',0,true) then
        createShell()
        playSound('hit')
    elseif string.find(tag,'createPoison',0,true) then
        createPoison()
        playSound('hit')
    elseif string.find(tag,'noteGoUp',0,true) then

        local id = string.gsub(tag,'noteGoUp','')
        if downscroll then
            noteTweenY('noteUniY'..id,id,getPropertyFromGroup('strumLineNotes',id,'y')-80,0.3,'circOut')
        else
            noteTweenY('noteUniY'..id,id,getPropertyFromGroup('strumLineNotes',id,'y')+80,0.3,'circOut')
        end
    elseif tag == 'marioRunning' then
        setProperty('dad.x',-100)
        setProperty('dad.velocity.x',1000)
        playAnim('dad','run',true)
        setProperty('dad.flipX',false)
        setProperty('dad.specialAnim',true)
    elseif tag == 'marioFall' then
        playAnim('marioArrows','fall')
    end
end