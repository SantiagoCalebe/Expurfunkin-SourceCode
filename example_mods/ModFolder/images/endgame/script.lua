local precache = false
function onCreate()
    if precache then
        addCharacterToList('omega','dad')
        addCharacterToList('mario_ultra1','dad')
        addCharacterToList('mario_ultra2','dad')
        addCharacterToList('bf_behind','boyfriend')
        addCharacterToList('gx','dad')
        addCharacterToList('bfsad','boyfriend')
        addCharacterToList('bf_ultrafinale','boyfriend')
        precacheImage('mario/allfinal/act4/memory')
        precacheImage('mario/allfinal/act4/she got infected with the exe')
    end

    addLuaScript('extra_scripts/camFade')
    addLuaScript('extra_scripts/extraIcon')
    addLuaScript('extra_scripts/extraCharacter')
    addLuaScript('custom_events/Set Cam Zoom')

    makeAnimatedLuaSprite('starsIntro','mario/allfinal/act1/All_Stars_Intro')
    addAnimationByPrefix('starsIntro','anim','intro anim',21,false)
    setObjectCamera('starsIntro','other')
    addLuaSprite('starsIntro',true)
    setProperty('starsIntro.alpha',0.001)

    makeAnimatedLuaSprite('act4intro','mario/allfinal/act4/Act_4_Voiceline')
    addAnimationByPrefix('act4intro','anim','thingy',24,false)
    setProperty('act4intro.alpha',0.001)
    setObjectCamera('act4intro','other')
    addLuaSprite('act4intro',true)

    makeAnimatedLuaSprite('act4end','mario/allfinal/act4/Act_4_FINALE_DEATH',100)
    addAnimationByPrefix('act4end','anim','Death',24,false)
    scaleObject('act4end',0.8,0.8)
    setScrollFactor('act4end',0,0)
    setProperty('act4end.alpha',0.001)
    addLuaSprite('act4end',true)

    makeLuaSprite('gameover','mario/allfinal/act4/Act_4_FINALE_Gameover')
    setScrollFactor('gameover',0,0)
    setProperty('gameover.alpha',0.001)
    setProperty('gameover.antialiasing',false)
    screenCenter('gameover')
    addLuaSprite('gameover',true)


    makeAnimatedLuaSprite('starsIcons','mario/allfinal/act4/iconAct4',0,0)
    for i, icons in pairs({'beta2','costume','devil','gb','hally','luigiH2','mrl','2MX','omega','cdpeach','secret','stanley','sys','turmoil','v','wario','wdwluigi','yoshiex'}) do
        addAnimationByPrefix('starsIcons',icons,icons,0,false)
    end
    setProperty('starsIcons.alpha',0.001)
    setObjectCamera('starsIcons','hud')
    addLuaSprite('starsIcons',true)

    callScript('extra_scripts/extraCharacter','createCharacter',{'yoshi','y0shi',-100,1590})

    --setProperty('skipCountdown',true)
    setProperty('introSoundsSuffix','-silence')
end

function onCreatePost()
    setZoom(0.65,'gf')
    setZoom(0.65,'bf')
    setZoom(0.4,'dad')
    addExtraIcon('gfIcon','gf',true)
    setCamPos('bfX+100','bfY-30','gf')
    setProperty('camGame.alpha',0.001)
    setProperty('camHUD.alpha',0.001)
end

function onSongStart()
    setProperty('starsIntro.alpha',1)
    playAnim('starsIntro','anim',true)
end

function removeFromMemory(image,isCharacter)
    --[[if version >= '0.7' then
        if not isCharacter then
            callOnHScript('removeFromMemory',{image})
        else
            callOnHScript('removeCharacterFromMemory',{image})
        end
    else]]--
    if not isCharacter then
        callScript('scripts/optimization','removeFromMemory',{image})
    else
        callScript('scripts/optimization','removeCharacterFromMemory',{image})
    end
        
    --end
end
function onUpdate()
    setProperty('starsIcons.x',getProperty('iconP2.x') - 60)
    setProperty('starsIcons.y',getProperty('iconP2.y') - 75)
    setProperty('starsIcons.scale.x',getProperty('iconP2.scale.x') - 0.25)
    setProperty('starsIcons.scale.y',getProperty('iconP2.scale.y') - 0.25)
end
function onEvent(name,v1,v2)
    if name == 'Triggers All Stars' then
        if v1 == '0' then
            cameraFlash('hud','FF0000',0.5)
            setProperty('camGame.alpha',1)
            setProperty('camHUD.alpha',1)
            removeLuaSprite('starsIntro',true)
            removeFromMemory('mario/allfinal/act1/All_Stars_Intro')
        elseif v1 == '2' then
            if v2 == '1' then

                removeExtraIcon('gfIcon',true)
                if getSongPosition() < 223910 then --Used to not load the sprites if you are not in their stage, useful if you are using Skip Time on charting mode
                    addCharacterToList('w4r','dad')
                    addCharacterToList('lg2','gf')
                    
                    triggerEvent('Change Character','bf','bf_behind')
                    triggerEvent('Change Character','dad','omega')
                    triggerEvent('Change Character','gf','lg2')
                    setProperty('gf.visible',false)
                    
                    precacheImage('characters/W4R_Assets_New')



                    if not hideHud then
  
                        addExtraIcon('gfIcon','LG',false)
                        extraIcon('setIconProperty',{'gfIcon','followAlpha',false})
                        extraIcon('setIconAsPrincipal',{'gfIcon'})
                        
                        addExtraIcon('yoshiIcon','Y0SH',false)
                        extraIcon('setIconProperty',{'yoshiIcon','followAlpha',false})
                        
                        addExtraIcon('dadIcon','W4R',false)
                        extraIcon('setIconProperty',{'dadIcon','followAlpha',false})
                        


       
                        setProperty('gfIcon.offset.y',not downscroll and -700 or 700)
                        setProperty('dadIcon.offset.y',getProperty('gfIcon.offset.y'))
                        setProperty('yoshiIcon.offset.y',getProperty('gfIcon.offset.y'))
                    end
                end

                removeFromMemory('bfnew',true)
                removeFromMemory('gfplayable',true)
                removeFromMemory('mario_ultra1',true)

                setOffs(50,'yoshi')

                setZoom(0.7,'bf')
                setZoom(0.6,'dad')
                setZoom(0.6,'gf')
                setZoom(0.6,'yoshi')

                setCamPos(-500,990,'bf')
                setCamPos(-500,850,'dad')
                setCamPos(-500,880,'gf')
                setCamPos(-350,900,'yoshi')

                

            elseif v2 == '2' then



                cancelTween('yoshiY')
                callScript('extra_scripts/extraCharacter','removeCharacter',{'yoshi',true})
                removeLuaScript('extra_scripts/extraCharacter')
                
                if getSongPosition() < 350510 then --Used to not load the sprites if you are not in their stage, useful if you are using Skip Time on charting mode
                    triggerEvent('Change Character','bf','bfsad')
                    triggerEvent('Change Character','dad','gx')
                    precacheImage('characters/GX_Sprites_FINAL')
                end
                if not hideHud then
                    removeExtraIcon('all',true)
                end

                setCamPos(350,460,'bf')
                removeFromMemory('bf_behind',true)
                removeFromMemory('lg2',true)
                removeFromMemory('w4r',true)

                setZoom(0.6,'bf')
                setZoom(0.7,'dad')

                callScript('scripts/global_functions','deleteGF')
            elseif v2 == '2.5' then
                addLuaScript('extra_scripts/camLerp')
                camFade('game','000000',0.5,true)
                playAnim('boyfriend','intro',true)
                setProperty('boyfriend.specialAnim',true)
                removeLuaScript('extra_scripts/extraIcon')
                setProperty('dad.y',getProperty('dad.y')-1200)

            elseif v2 == '3' then
                cancelTween('gameZoom3')
                cancelTween('gameZoom4')
                if getSongPosition() < 480100 then --Used to not load the sprites if you are not in their stage
                    triggerEvent('Change Character','bf','bf_ultrafinale')
                    triggerEvent('Change Character','dad','mario_ultra2')

                    if not precache then--detect if the images are precached
                        addCharacterToList('mario_ultra3','dad')
                        addCharacterToList('bf_ultrafinale2','boyfriend')
                        addCharacterToList('bf_ultrafinale3','boyfriend')
                        precacheImage('mario/allfinal/act4/memory')
                        precacheImage('mario/allfinal/act4/she got infected with the exe')
                    end
                end

                removeFromMemory('bfsad',true)
                removeFromMemory('gx',true)

                setZoom(1.4,'bf')
                setZoom(1,'dad')
                setCamPos(200,300,'dad')
                setCamPos(350,350,'bf')
                setOffs(20)

            elseif v2 == '4' then
                setProperty('isCameraOnForcedPos',false)
                setZoom(nil,nil)
                setCamPos(nil,nil)-- Reset Pos


                camFade('game','000000',1,true)
                for strums = 0,3 do
                    setPropertyFromGroup('opponentStrums',strums,'alpha',0)
                    if not middlescroll then
                        setPropertyFromGroup('playerStrums',strums,'x',412 + (112*strums))
                    end
                end
                triggerEvent('Change Character','bf','bf_ultrafinale2')

                removeFromMemory('bf_ultrafinale',true)
                callScript('scripts/cameraMoviment','cancelCamTween')
                doTweenAlpha('gameAlpha','camGame',1,0.55,'circOut')

            elseif v2 == '5' then
                cancelTween('memoryAlphaEnter')
                cancelTween('memoryAlphaExit')
                cancelTween('memoryExeAlpha')
                removeLuaSprite('memory',true)
                removeLuaSprite('memoryExe',true)

                triggerEvent('Change Character','bf','bf_ultrafinale3')
                triggerEvent('Change Character','dad','mario_ultra3')

                removeFromMemory('bf_ultrafinale2',true)
                removeFromMemory('mario_ultra2',true)

                for strums = 0,3 do
                    if not middlescroll then
                        setPropertyFromGroup('opponentStrums',strums,'alpha',1)
                        setPropertyFromGroup('playerStrums',strums,'x',732 + (112*strums))
                    else
                        setPropertyFromGroup('opponentStrums',strums,'alpha',0.35)
                    end
                end

                cancelTween('gameZoom5')
                cancelTween('gameZoom6')

                setCamPos(450,350)
                if version > '0.6.3' then
                    setProperty('camGame.scroll.x',-300)
                    setProperty('camGame.scroll.y',-50)
                end
                setOffs(20)
                callScript('scripts/global_functions','hudAlpha',{1,0})
            end
        elseif v1 == '3' then
            if v2 == '' then
                playAnim('dad','scream',true)
                setProperty('dad.specialAnim',true)
                doTweenZoom('gameZoom','camGame',1,1,'circIn')
                setCamPos(-500,700,'all')
            elseif v2 == '1' then
                doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom')+0.4,0.7,'cubeIn')
                setCamPos(-500,700,'all')
            end
                
        elseif v1 == '4' then
            if v2 == '0' then
                setCamPos(nil,nil,'all')
                setProperty('gf.visible',true)
                setProperty('gfGroup.visible',true)
                doTweenAlpha('iconP2Alpha','iconP2',0,1,'sineIn')

                setProperty('gf.x',getProperty('gf.x')-50)
                setProperty('gf.y',getProperty('gf.y')+1000)
                doTweenY('gfY','gf',getProperty('gf.y')-1000,1,'sineOut')
                doTweenY('gfIconY','gfIcon.offset',0,2,'sineOut')
                --doTweenY('gfY','gf',400,1,'circOut')
                
            elseif v2 == '1.5' then
                triggerEvent('Change Character','dad','w4r')
                setProperty('dad.y',getProperty('dad.y')+1000)

                setCamPos(-700,900,'dad')
                removeFromMemory('omega',true)
            elseif v2 == '2' then
                doTweenY('dadY','dad',getProperty('dad.y')-1000,1,'sineOut')
                doTweenY('dadIconY','dadIcon.offset',0,1,'sineOut')
            
            elseif v2 == '3' then
                doTweenY('yoshiY','yoshi',630,1,'sineOut')
                doTweenY('yoshiIconY','yoshiIcon.offset',0,1,'sineOut')
                
            end
        elseif v1 == '5' then
            camFade('game','000000',0.5)
            doTweenY('hudY','camHUD',200,2,'circIn')
            doTweenAngle('hudAngle','camHUD',30,2,'circIn')
            doTweenAlpha('hudAlpha','camHUD',0,2,'circIn')
            
        elseif v1 == '6' then
            if v2 == '1' then
                cancelTween('iconP2Alpha')
                setProperty('iconP2.alpha',1)
                callScript('extra_scripts/camLerp','setLerp',{0,nil,0.05})
                setCamPos(-800,460,'dad')
            elseif v2 == '2' then
                doTweenY('dadY','dad',getProperty('dad.y')+1200,3,'sineInOut')
            
            elseif v2 == '3' then
                cancelTween('hudY')
                cancelTween('hudAngle')
                setProperty('camHUD.angle',0)
                setProperty('camHUD.y',0)
                doTweenAlpha('hudAlpha','camHUD',1,1,'linear')
            elseif v2 == '3.5' then
                setCamPos(-520,460,'dad')

            elseif v2 == '4.5' then
                setZoom(nil)
                setProperty('defaultCamZoom',0.4)
                setCamPos(-50,500)
            elseif v2 == '4.7' then
                doTweenZoom('gameZoom3','camGame',0.5,1,'circInOut')
                doTweenAlpha('hudAlpha','camHUD',0,1,'circIn')
                setCamPos(-50,650)
            elseif v2 == '5' then
                setProperty('isCameraOnForcedPos',true)
                setProperty('camFollow.x',100)
                setProperty('camFollow.y',200)
                setProperty('camOther.zoom',0.7)
                cameraFlash('other','000000',2)
                doTweenZoom('otherZoom','camOther',1,1,'cubeOut')
                doTweenX('act4ScaleX','act4intro.scale',1.3,11,'linear')
                doTweenY('act4ScaleY','act4intro.scale',1.3,11,'linear')
                doTweenAlpha('act4introAlpha','act4intro',1,0.3,'circOut')
                playAnim('act4intro','anim',true)
            elseif v2 == '6' then
                setProperty('isCameraOnForcedPos',false)
                cancelTween('gameAlpha')
                cancelTween('hudAlpha')
                cameraFlash('hud','000000',0.5)
                setProperty('camGame.alpha',1)
                setProperty('camHUD.alpha',1)
                cancelTween('act4introAlpha')
                setProperty('camGame.zoom',1.4)
                doTweenAlpha('act4introAlphaExit','act4intro',0,0.7,'circIn')
            end

        elseif v1 == '7' then
            if v2 == '' then
                camFade('game','000000',1.6,false)
                setProperty('isCameraOnForcedPos',true)
                doCamTween('bfX+140','bfY+50',1,'circInOut')
                callScript('scripts/global_functions','hudAlpha',{0,1.2,'linear'})
            elseif v2 == '1' then
                setProperty('defaultCamZoom',0.6)
                makeLuaSprite('memory','mario/allfinal/act4/memory',getProperty('boyfriend.x') - 850,getProperty('boyfriend.y') + 300)
                setProperty('memory.alpha',0)
                setProperty('memory.velocity.y',-50)
                doTweenAlpha('memoryAlphaEnter','memory',0.5,6,'quartInOut')
                addLuaSprite('memory',true)
            elseif v2 == '2' then
                makeLuaSprite('memoryExe','mario/allfinal/act4/she got infected with the exe',getProperty('boyfriend.x') + 500,getProperty('boyfriend.y') - 350)
                setProperty('memoryExe.alpha',0)
                setProperty('memoryExe.velocity.y',50)
                doTweenAlpha('memoryExeAlpha','memoryExe',0.5,6,'quartInOut')
                addLuaSprite('memoryExe',true)
            elseif v2 == '3' then
                doTweenZoom('gameZoom5','camGame',0.5,stepCrochet*0.008,'sineInOut')
            end

        elseif v1 == '8' then
            if v2 == '0' then
                doCamTween('bfX+500','bfY+50',1,'quadIn')
                doTweenZoom('gameZoom','camGame',2,1,'cubeIn')
            elseif v2 == '1' then
                cancelTween('gameZoom')
                setProperty('camGame.zoom',0.8)
                setProperty('camZooming',false)
                cameraFlash('game','FF0000',1)
                setProperty('boyfriend.visible',false)
                setProperty('dad.visible',false)
                setProperty('camHUD.visible',false)

                setProperty('act4end.alpha',1)
                playAnim('act4end','anim',true)
            elseif v2 == '2' then
                doTweenAlpha('act4endalpha','act4end',0,3,'sineIn')
                doTweenX('act4endscalex','act4end.scale',0.6,3,'sineIn')
                doTweenY('act4endscaley','act4end.scale',0.6,3,'sineIn')
            elseif v2 == '3' then
                doTweenAlpha('gameoveralpha','gameover',1,3,'sineOut')
            elseif v2 == '4' then
                cameraFade('game','000000',3)
            end
        elseif v1 == '9' then
            cancelTween('starsIconAlpha')
            playAnim('starsIcons',v2)
            setProperty('starsIcons.alpha',0.8)
            setProperty('starsIcons.angle',-360)
            doTweenAngle('starIconAngle','starsIcons',0,0.25,'backOut')

        end
    end
end

function opponentNoteHit(id,data,type,sus)
    if type == 'Yoshi Note' or type == 'AS Bud Note' then
        playAnim('yoshi',getProperty('singAnimations['..data..']'),true)
        setProperty('yoshi.holdTimer',0)
    end
end

function onSectionHit()
    if getSongPosition() > 323000 and getSongPosition() < 348000 then
        setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.05)
    end
    if curSection == 269 or curSection == 283 then
        doTweenAlpha('starsIconAlpha','starsIcons',0,1,'cubeIn')
    end
end
function extraIcon(func,vars)
    if not hideHud then
        callScript('extra_scripts/extraIcon',func,vars)
    end
end
function addExtraIcon(tag,image,isPlayerIcon)
    extraIcon('addExtraIcon',{tag,image,isPlayerIcon})
end
function removeExtraIcon(tag,removeFromMemory)
    callScript('extra_scripts/extraIcon','removeExtraIcon',{tag,removeFromMemory})
end
function doCamTween(x,y,time,easing)
    callScript('scripts/cameraMoviment','doCamTween',{x,y,time,easing})
end
function camFade(cam,color,time,fadeIn)
    callScript('extra_scripts/camFade','camFade',{cam,color,time,fadeIn})
end

function setCamPos(x,y,target)
    callScript('scripts/cameraMoviment','setCamPos',{x,y,target})
end
function setOffs(ofs,target)
    callScript('scripts/cameraMoviment','setOffs',{ofs,target})
end
function setZoom(zoom,target)
    callScript('custom_events/Set Cam Zoom','setZoom',{zoom,target})
end

function onTweenCompleted(tag)
    if tag == 'gameZoom3' then
        doTweenZoom('gameZoom4','camGame',10,0.5,'quintIn')
    elseif tag == 'memoryAlphaEnter' then
        doTweenAlpha('memoryAlphaExit','memory',0,2,'quartIn')
    elseif tag == 'gameZoom4' then
        setProperty('camGame.alpha',0.001)
    elseif tag == 'gameZoom5' then
        doTweenZoom('gameZoom6','camGame',0.85,stepCrochet*0.008,'circIn')
    elseif tag == 'act4introAlphaExit' then
        cancelTween('act4ScaleX')
        cancelTween('act4ScaleY')
        removeLuaSprite('act4intro',true)
    end
end



--[[
    --xx/yy is always for player characters
    --xx2/yy2 is always for opponent
--instead of having a if then festival we're just gonna have the values get set whenever certain notes are hit
local act = 1

local xx = 220
local yy = 450

local xx2 = -420
local yy2 = 150

local ofs = 30
local ofs2 = 60

local zoom1 = 0.6
local zoom2 = 0.35

local followchars = true
local zoomchars = true

local singer1 = 'boyfriend'
local singer2 = 'dad'

function onUpdate()
     if followchars == true then
         if mustHitSection == true then
             if getProperty(singer1 .. '.animation.curAnim.name') == 'idle' or getProperty(singer1 .. '.animation.curAnim.name') == 'idle-alt' then
                 triggerEvent('Camera Follow Pos',xx,yy)
             end
             if getProperty(singer1 .. '.animation.curAnim.name') == 'singLEFT' or getProperty(singer1 .. '.animation.curAnim.name') == 'singLEFT-alt' then
                 triggerEvent('Camera Follow Pos',xx - ofs,yy)
             end
             if getProperty(singer1 .. '.animation.curAnim.name') == 'singRIGHT' or getProperty(singer1 .. '.animation.curAnim.name') == 'singRIGHT-alt' then
                 triggerEvent('Camera Follow Pos',xx + ofs,yy)
             end
             if getProperty(singer1 .. '.animation.curAnim.name') == 'singUP' or getProperty(singer1 .. '.animation.curAnim.name') == 'singUP-alt' then
                 triggerEvent('Camera Follow Pos',xx,yy - ofs)
             end
             if getProperty(singer1 .. '.animation.curAnim.name') == 'singDOWN' or getProperty(singer1 .. '.animation.curAnim.name') == 'singDOWN-alt' then
                 triggerEvent('Camera Follow Pos',xx,yy + ofs)
             end
            
             if zoomchars == true then
                 setProperty('defaultCamZoom', zoom1)
             end
         else
             if getProperty(singer2 .. '.animation.curAnim.name') == 'idle' or getProperty(singer2 .. '.animation.curAnim.name') == 'idle-alt' then
                 triggerEvent('Camera Follow Pos',xx2,yy2)
             end
             if getProperty(singer2 .. '.animation.curAnim.name') == 'singLEFT' or getProperty(singer2 .. '.animation.curAnim.name') == 'singLEFT-alt' then
                 triggerEvent('Camera Follow Pos',xx2 - ofs2,yy2)
             end
             if getProperty(singer2 .. '.animation.curAnim.name') == 'singRIGHT' or getProperty(singer2 .. '.animation.curAnim.name') == 'singRIGHT-alt' then
                 triggerEvent('Camera Follow Pos',xx2 + ofs2,yy2)
             end
             if getProperty(singer2 .. '.animation.curAnim.name') == 'singUP' or getProperty(singer2 .. '.animation.curAnim.name') == 'singUP-alt' then
                 triggerEvent('Camera Follow Pos',xx2,yy2 - ofs2)
             end
             if getProperty(singer2 .. '.animation.curAnim.name') == 'singDOWN' or getProperty(singer2 .. '.animation.curAnim.name') == 'singDOWN-alt' then
                 triggerEvent('Camera Follow Pos',xx2,yy2 + ofs2)
             end

             if getProperty(singer2 .. '.animation.curAnim.name') == 'exit1' or getProperty(singer2 .. '.animation.curAnim.name') == 'exit2 ' then
                 triggerEvent('Camera Follow Pos',xx2,yy2 - (ofs2 * 2))
             end
            
             if zoomchars == true then
                 setProperty('defaultCamZoom', zoom2)
             end
         end
     else
         triggerEvent('Camera Follow Pos','','')
     end
 end

 function onBeatHit()
     if curBeat == 268 then
         act = 2
     end
     if curBeat == 396 then
         act = 2.5
     end
     if curBeat == 264 then
         zoom2 = 2
         xx2 = 480
         yy2 = -180
     end

     if curBeat == 328 then
         followchars = false
         zoomchars = false
         doTweenAlpha('tag0', 'camHUD', 0.7, 0.5, 'quadInOut')
         doTweenX('tag1', 'camFollowPos', xx2, 1.6, 'quadIn')
         doTweenY('tag2', 'camFollowPos', yy2 - 300, 1.6, 'quadIn')
         doTweenX('tag3', 'camFollow', xx2, 1.6, 'quadIn')
         doTweenY('tag4', 'camFollow', yy2 - 300, 1.6, 'quadIn')
     end

     if curBeat == 330 then
         setProperty('defaultCamZoom', 1.1)
         triggerEvent('Screen Shake','0.8, 0.004','0.8, 0.004')
     end

     if curBeat == 332 then
         followchars = true
         zoomchars =   true
         doTweenAlpha('tag5', 'camHUD', 1, 0.5, 'quadOut')
     end

     if curBeat == 580 then
         act = 3
         xx2 = -800
         yy2 = 300
         zoom2 = 0.7
         ofs2 = 20
         ofs = 20
     end

     if curBeat == 586 then
         followchars = false
         zoomchars = false
         doTweenX('tag1', 'camFollowPos', xx2, 5, 'quadInOut')
         doTweenY('tag2', 'camFollowPos', yy2, 5, 'quadInOut')
         doTweenX('tag3', 'camFollow', xx2, 5, 'quadInOut')
         doTweenY('tag4', 'camFollow', yy2, 5, 'quadInOut')
         doTweenZoom('tag5', 'camGame', zoom2, 5, 'quadInOut')
     end

     if curBeat == 604 then
         followchars = true
         zoomchars = true
         xx2 = -400
         yy2 = 300
         zoom2 = 0.6
     end

     if curBeat == 668 then
         ofs2 = 80
         ofs = 60
     end

     if curBeat == 844 then
         act = 3.5
         zoomchars = false
     end

     if curBeat == 916 then
         act = 4;
         zoomchars = true;
         xx = 720;
         yy = 480;
         ofs = 15;
         zoom1 = 1.3;
         xx2 = 570;
         yy2 = 440;
         ofs2 = 40;
         zoom2 = 1;
     end

     if curBeat == 1172 then
         xx = 1000;
         yy = 550;
         zoom1 = 1.5;
         doTweenX('tag3', 'camFollowPos', xx, 1.6, 'quadInOut')
         doTweenY('tag4', 'camFollowPos', yy, 1.6, 'quadInOut')
         doTweenZoom('cam1', 'camGame', zoom1, 1.6, 'quadInOut');
     end

     if curBeat == 1176 then
         zoom1 = 0.7;
         yy = 425;
         doTweenX('tag3', 'camFollowPos', xx, 0.05, 'quadInOut')
         doTweenY('tag4', 'camFollowPos', yy, 0.05, 'quadInOut')
     end

     if curBeat == 1208 then
         zoom1 = 0.6;
     end

     if curBeat == 1236 then
         zoom1 = 0.5;
         doTweenZoom('cam1', 'camGame', zoom1, 0.8, 'quadInOut');
     end

     if curBeat == 1238 then
         zoom1 = 1;
         doTweenZoom('cam1', 'camGame', zoom1, 0.8, 'cubeIn');
     end

     if curBeat == 1240 then
         xx = 720;
         yy = 480;
         ofs = 15;
         zoom1 = 1.3;
         xx2 = 570;
         yy2 = 440;
         ofs2 = 40;
         zoom2 = 1;
     end

 function goodNoteHit(id, noteData, noteType, isSustainNote)
     if noteType == '' or noteType == 'Alt Animation' or noteType == 'GF Duet' then
         singer1 = 'boyfriend'
         if act == 1 then
             xx = 220
             yy = 450
         end
         if act == 2 or act == 2.5 then
             xx = 520
             yy = 450
             zoom1 = 0.8
         end
         if act == 3 then
             xx = 350
             yy = 475
             zoom1 = 0.7
         end
         if act == 3.5 then
             xx = -150
             yy = 400
         end
     end
     if noteType == 'GF Sing' then
         singer1 = 'gf'
         xx = 370
         yy = 450
     end
 end

 function opponentNoteHit(id, noteData, noteType, isSustainNote)
     if noteType == '' then
         singer2 = 'dad'
         if act == 1 then
             xx2 = -420
             yy2 = 150
             zoom2 = 0.35 
         end
         if act == 2 then
             xx2 = 520
             yy2 = 250
             zoom2 = 0.6
             ofs2 = 80
         end
         if act == 2.5 then
             xx2 = 260
             yy2 = 450
             zoom2 = 0.7
             ofs2 = 60
         end
         if act == 3 then
             xx2 = -400
             yy2 = 300
             zoom2 = 0.6
         end
         if act == 3.5 then
             xx2 = -150
             yy2 = 400
             ofs2 = 30
         end
     end
     if noteType == 'GF Sing' then
         singer2 = 'gf'
         xx2 = 520
         yy2 = 350
         zoom2 = 0.7
     end
     if noteType == 'Yoshi Note' then
         singer2 = 'funnylayer0'
         xx2 = 780
         yy2 = 450
         zoom2 = 0.7
     end
     if noteType == 'AS Bud Note' then
         singer2 = 'dad'
         xx2 = 520
         yy2 = 350
         zoom2 = 0.6
     end
end
]]--