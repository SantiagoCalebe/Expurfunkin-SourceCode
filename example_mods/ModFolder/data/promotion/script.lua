local cameraTilt = 0

local defaultY = {}
function onCreate()
    setProperty('iconP1.visible',false)
    setProperty('iconP2.visible',false)
    setProperty('healthBar.visible',false)
    setProperty('timeBar.visible',false)
    setProperty('timeTxt.visible',false)
    setProperty('timeBar.visible',false)
    setProperty('scoreTxt.visible',false)
    setProperty('comboGroup.alpha', '0')
    addHaxeLibrary('Math')-- For 0.6.3

    for strums = 0,3 do
        makeLuaSprite('noteModchart'..strums,nil,0,0)
    end
end

local noteBackTime = 0
local noteBackEasing = 'expoIn'
function onCreatePost()
    noteBackTime = stepCrochet*0.002
    for strums = 0,7 do
        table.insert(defaultY,getPropertyFromGroup('playerStrums',strums,'y'))
    end
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'strumTime') > 80000 and not getPropertyFromGroup('unspawnNotes',notes,'mustPress') then
            setPropertyFromGroup('unspawnNotes',notes,'visible',false)
        end
    end
    
end
function lerp(a,b,c)
    return a + (b-a)*c
end

local force = 0
local ofs = 0
local pos = 0


function onUpdate(el)
    if curBeat >= 243 then
        local songPos = getSongPosition()
        if curBeat < 411 then
            if curBeat >= 340 and curBeat < 376 then
                force = lerp(force,0,0.15)
            else
                force = lerp(force,1,0.001)
            end
            if curBeat < 344 then
                pos = lerp(pos,(songPos - 106370)/bpm/5,force)
                ofs = -250*(math.sin(pos))
            elseif curBeat >= 376 and curBeat < 408 then
                pos = lerp(pos,(songPos - 156860)/bpm/5,force)
                ofs = -250*(math.sin(pos))
            elseif curBeat >= 408 then
                ofs = lerp(ofs,0,0.1)
            end
            
        end
        for i = 0,3 do
            local x = 432 + (112*i)
            if curBeat >= 343 then
                setPropertyFromGroup('opponentStrums',i,'x',x + ofs + getProperty('noteModchart'..i..'.x'))
                setPropertyFromGroup('playerStrums',i,'x',x - ofs + getProperty('noteModchart'..i..'.x'))
                setPropertyFromGroup('opponentStrums',i,'y',(downscroll and 50 or screenHeight - 150) - getProperty('noteModchart'..i..'.y'))
                setPropertyFromGroup('playerStrums',i,'y',(downscroll and screenHeight - 150 or 50) + getProperty('noteModchart'..i..'.y'))

            else
                setPropertyFromGroup('playerStrums',i,'x',x + ofs)
                setPropertyFromGroup('opponentStrums',i,'x',x - ofs)
            end
        end
    end
end
function onBeatHit()
    if cameraTilt ~= 0 then
        if curBeat % 2 == 0 then
            if curBeat % 4 == 0 then
                setProperty('camGame.angle',-cameraTilt)
            else
                setProperty('camGame.angle',cameraTilt)
            end
            doTweenAngle('gameAngle','camGame',0,stepCrochet*0.004,'expoIn')
        end
    end
    
    if curBeat >= 180 and curBeat < 244 and curBeat % 2 == 0 then
        local beat = stepCrochet*0.008
        
        local code = [[
            for(i in 0...4){
                for(n in ['noteUniX'+i,'noteUniScale'+i]){
                    var t = getVar(n);
                    if(t != null){
                        t.cancel();
                        t.destroy();
                    }
                }
                if(game.playerStrums.members[i] != null){
                    var strum = game.playerStrums.members[i];
                    strum.x -= 50 * Math.cos(i); //Math.cos was not used for compatibility with 0.6.3
            ]]
        
        if curBeat % 4 == 0 then
            code = code..[[
                    if((i == 0 || i == 2)){
                        strum.angle = 30;
                        strum.scale.set(1.1,1.1);
                        setVar('noteUniX'+i,FlxTween.tween(strum,{x: 432+(112*i), angle: 0},]]..beat..[[,{ease: FlxEase.quadOut}));
                        setVar('noteUniScale'+i,FlxTween.tween(strum.scale,{x: 0.7,y: 0.7},]]..beat..[[,{ease: FlxEase.quadOut}));
                    }
                    else{
                        setVar('noteUniX'+i,FlxTween.tween(strum,{x: 432+(112*i)},]]..beat..[[,{ease: FlxEase.quadOut}));
                    }
                }
            }
            ]]
        elseif curBeat % 4 == 2 then
            code = code..[[
                    if((i == 1 || i == 3)){
                        strum.angle = -30;
                        strum.scale.set(1.1,1.1);
                        setVar('noteUniX'+i,FlxTween.tween(strum,{x: 432+(112*i), angle: 0},]]..beat..[[,{ease: FlxEase.quadOut}));
                        setVar('noteUniScale'+i,FlxTween.tween(strum.scale,{x: 0.7,y: 0.7},]]..beat..[[,{ease: FlxEase.quadOut}));
                    }
                    else{
                        setVar('noteUniX'+i,FlxTween.tween(strum,{x: 432+(112*i)},]]..beat..[[,{ease: FlxEase.quadOut}));
                    }
                }

            }
            ]]
        end
        runHaxeCode(code)
    elseif curBeat >= 244 and curBeat < 303 then
        if curBeat % 2 == 0 then
            for strums = 0,3 do
                if curBeat % 4 == 2 then
                    setPropertyFromGroup('playerStrums',strums,'angle',-30*math.cos(strums*3.14))
                    noteTweenAngle('noteUniAngle'..(strums+4),strums+4,0,stepCrochet*0.007,'sineOut')
                else
                    if curBeat % 8 == 4 then
                        setPropertyFromGroup('playerStrums',strums,'y',getPropertyFromGroup('playerStrums',strums,'y') - (50*math.cos(strums%2*math.pi)))
                    else
                        setPropertyFromGroup('playerStrums',strums,'y',getPropertyFromGroup('playerStrums',strums,'y') + (50*math.cos(strums%2*math.pi)))
                    end
                    if downscroll then
                        noteTweenY('noteUniY'..(strums+4),strums+4,screenHeight-150,stepCrochet*0.007,'quadOut')
                    else
                        noteTweenY('noteUniY'..(strums+4),strums+4,50,stepCrochet*0.007,'quadOut')
                    end
                end
            end
        end
    elseif curBeat >= 344 and curBeat < 406 then
        if curBeat % 2 == 1 then
            local i = 1
            if curBeat % 4 == 3 then
                i = -1
            end
            cancelTween('noteModChartBack1')
            cancelTween('noteModChartBack2')
            doTweenY('noteModchartGoY1','noteModchart1',-45*i,stepCrochet*0.002,'quadOut')
            doTweenY('noteModchartGoY2','noteModchart2',45*i,stepCrochet*0.002,'quadOut')
        else
            cancelTween('noteModChartBack0')
            cancelTween('noteModChartBack3')
            doTweenX('noteModchartGoX0','noteModchart0',-30,stepCrochet*0.002,'quadOut')
            doTweenX('noteModchartGoX3','noteModchart3',30,stepCrochet*0.002,'quadOut')
        end
    elseif curBeat >= 411 and curBeat < 435 and curSection % 4 ~= 0 and curBeat % 4 == 0 then 
        for strums = 0,3 do
            local cal = math.cos(strums*1.1)
            setPropertyFromGroup('playerStrums',strums,'angle',0)
            setPropertyFromGroup('opponentStrums',strums,'angle',0)
            doTweenX('noteModchartGoX'..strums,'noteModchart'..strums,-20*cal,stepCrochet*0.004,'quadOut')
            noteTweenAngle('noteModchartAngleGo'..(strums+4),strums+4,-30*cal,stepCrochet*0.004,'quadOut')
            noteTweenAngle('noteModchartAngleGo'..strums,strums,-30*cal,stepCrochet*0.004,'quadOut')
        end
    end
end
function onTweenCompleted(tag)
    if string.find(tag,'noteModchartGoX',0,true) then
        local note = string.gsub(tag,'noteModchartGoX','')
        doTweenX('noteModchartBack'..note,'noteModchart'..note,0,noteBackTime,noteBackEasing)
    elseif string.find(tag,'noteModchartGoY',0,true) then
        local note = string.gsub(tag,'noteModchartGoY','')
        doTweenY('noteModchartBack'..note,'noteModchart'..note,0,noteBackTime,noteBackEasing)
    elseif string.find(tag,'noteModchartAngleGo',0,true) then
        local note = string.gsub(tag,'noteModchartAngleGo','')
        noteTweenAngle('noteModchartAngleBack'..note,tonumber(note),0,noteBackTime,noteBackEasing)

    end
end


local stanleyLine = 0
function onEvent(name,v1,v2)
    if name == 'Triggers Promotion' then
        if v1 == '0' then
            setProperty('camGame.alpha',0.001)
            setProperty('camHUD.alpha',0)
            setProperty('tvTrans.alpha',1)
            playAnim('tvTrans','anim',true)
        elseif v1 == '1' then
            
            doTweenAlpha('hudAlpha','camHUD',1,2,'quadOut')
            for strums = 0,7 do
                cancelTween('noteUniY'..strums)
                cancelTween('noteUniAngle'..strums)
                setPropertyFromGroup('strumLineNotes',strums,'x',432 + (112*(strums%4)))
                if downscroll and strums >= 4 or not downscroll and strums < 4 then
                    setPropertyFromGroup('strumLineNotes',strums,'y',screenHeight - 150)
                elseif downscroll and strums < 4 or strums >= 4 and not downscroll then
                    setPropertyFromGroup('strumLineNotes',strums,'y',50)
                end
                if strums >= 4 then
                    cancelTween('noteUniAlpha'..strums)
                    setPropertyFromGroup('strumLineNotes',strums,'alpha',1)
                end
                setPropertyFromGroup('strumLineNotes',strums,'angle',0)
            end
            if getHealth() > 1 then
                setHealth(1)
            end
        elseif v1 == '4' then
            setProperty('stanleyLines.alpha',1)
            setProperty('stanleyLines.animation.curAnim.curFrame',stanleyLine)

            local ofsX = 0
            local ofsY = 0
            local tweenX = 150
            local tweenY = -75
            local angle = 20
            if stanleyLine == 0 or stanleyLine == 1 then
                tweenX = 10
                tweenY = -150
            elseif stanleyLine == 2 or stanleyLine == 3 then
                ofsX = -50
                angle = 40
            elseif stanleyLine == 4 or stanleyLine == 5 then
                tweenX = -100
                angle = -20
                ofsX = 150
                ofsY = -50
            elseif stanleyLine > 5 then
                tweenY = 75
                tweenX = 0
                angle = 0
            end
            setProperty('stanleyLines.x',getProperty('dadGroup.x') - 180 + ofsX)
            setProperty('stanleyLines.y',getProperty('dadGroup.y') + 250 + ofsY)
            setProperty('stanleyLines.angle',angle)
            doTweenX('stanleyX','stanleyLines',getProperty('stanleyLines.x') + tweenX,stepCrochet*0.009,'quadOut')
            doTweenY('stanleyY','stanleyLines',getProperty('stanleyLines.y') + tweenY,stepCrochet*0.009,'quadOut')
            stanleyLine = stanleyLine + 1

            doTweenAlpha('stanlineAlpha','stanleyLines',0,stepCrochet*0.009,'sineOut')
        end
    end
end

function onTimerCompleted(tag)
    if string.find(tag,'notePromoBye',0,true) then
        local note = string.gsub(tag,'notePromoBye','')
        doTweenY('noteModchartGoY'..note,'noteModchart'..note,-40,0.5,'quadOut')
        for strum = note,note+4,4 do
            noteTweenAlpha('noteUniAlpha'..strum,strum,0,1,'quadOut')
            noteTweenAngle('noteUniAngle'..strum,strum,360*math.cos(strum*3.14)*-1,1.4,'expoOut')
        end

    end
end
function onSectionHit()
    if curSection == 41 then
        for strums = 0,7 do
            local time = 1 + (0.4 * (strums%4))
            noteTweenY('noteUniY'..strums,strums,getPropertyFromGroup('strumLineNotes',strums,'y')+100,time,'quadIn')
            noteTweenAngle('noteUniAngle'..strums,strums,-30,time,'quadIn')
            noteTweenAlpha('noteUniAlpha'..strums,strums,0,1 + (0.1 * (strums%4)),'quadIn')
        end
    elseif curSection == 44 then
        doTweenAlpha('gameAlpha','camGame',1,4,'quadOut')
    elseif curSection == 47 or curSection == 54 then
        cameraTilt = 6
    elseif curSection == 77 then
        for strums = 0,3 do
            noteTweenAlpha('noteUniAlpha'..strums,strums,0.4,0.3,'quadOut')
        end
    elseif curSection == 84 then
        cameraTilt = 8
    elseif curSection == 85 then
        for strums = 0,7 do
            if strums ~= 6 then
                noteTweenAlpha('noteUniAlpha'..strums,strums,0,0.2,'quadIn')
            end
        end
    elseif curSection == 86 then
        for strums = 4,7 do
            noteTweenAlpha('noteUniAlpha'..strums,strums,1,0.2,'quadOut')
        end
        ofs = 0
        pos = 0
        cameraTilt = 6
    elseif curSection == 94 then
        for strums = 0,7 do
            setPropertyFromGroup('strumLineNotes',strums,'angle',-360)
            noteTweenAngle('noteUniAngle'..strums,strums,0,0.5,'backOut')
        end
    elseif curSection == 101 then
        cameraTilt = 2

    elseif curSection == 53 then
        cameraTilt = 0
    elseif curSection == 102 then
        cameraTilt = 0

        noteBackTime = stepCrochet * 0.004
        for strums = 0,7 do
            setPropertyFromGroup('strumLineNotes',strums,'angle',-360)
            noteTweenX('noteUniX'..strums,strums,432 + (112*(strums%4)),1,'sineOut')
            noteTweenAngle('noteUniAngle'..strums,strums,0,1,'sineOut')
        end
        noteBackEasing = 'cubeIn'
    elseif curSection == 109 then
        noteBackTime = 0.4
        noteBackEasing = 'quadIn'
    elseif curSection == 110 then
        doTweenAlpha('gameAlpha','camGame',0,3,'quadIn')
        doTweenAlpha('hudAlpha','camHUD',0,4,'quadIn')
    end
end
function onStepHit()
    if curStep == 1351 then
        cameraTilt = 10
    elseif curStep == 1358 then
        cameraTilt = 0
    elseif curStep == 1370 then
        noteTweenAlpha('noteUniAlpha6',6,0,0.2,'quadIn')
    elseif curStep == 1755 then
        runTimer('notePromoBye1',0)
        for i, strum in pairs({0,3,2}) do
            runTimer('notePromoBye'..strum,stepCrochet*0.0015*i)
        end
    end
end