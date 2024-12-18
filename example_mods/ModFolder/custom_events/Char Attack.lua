local dodge = false
function onCreate()
    makeLuaSprite('charWarning','mario/star/warning')
    setObjectCamera('charWarning','other')
    setProperty('charWarning.alpha',0.001)
    updateHitbox('charWarning')
    addLuaSprite('charWarning',true)

    precacheSound('psPre')
    precacheSound('psAtt')

        
    makeLuaSprite('charVignette','modstuff/126',0,0)
    setObjectCamera('charVignette','hud')
    addLuaSprite('charVignette',false)
    setProperty('charVignette.alpha',0.001)

    precacheImage('mario/star/Powerstar_Mario_v2_AssetsFINAL1')

    makeAnimatedLuaSprite('marioAttack','mario/star/Powerstar_Mario_v2_AssetsFINAL1',0,0)
    scaleObject('marioAttack',2.0,2.0)
    addAnimationByPrefix('marioAttack','pre','AttackPrev',16,false)
    addOffset('marioAttack','pre',-260,-155)
    setProperty('marioAttack.alpha',0.001)
    addAnimationByPrefix('marioAttack','attack','AttackFinal',24,false)
    addOffset('marioAttack','attack',-520,-295)
    addLuaSprite('marioAttack',false)
    setObjectOrder('marioAttack',getObjectOrder('boyfriendGroup')+1)
end
function onUpdate()
    if not botplay and not dodge and keyboardJustPressed('SPACE') then
        bfDodge()
    end
    if dodge and (getProperty('boyfriend.animation.curAnim.finished') and getProperty('boyfriend.animation.curAnim.finished') or getProperty('boyfriend.animation.curAnim.name') ~= 'dodge') then
        dodge = false
    end
end
function onEvent(name,v1,v2)
    if name == 'Char Attack' then
        if getProperty('dad.curCharacter') == 'devilmario' then
            cancelTimer('marioBack')
            setProperty('dad.visible',false)
            setProperty('marioAttack.alpha',1)
            playAnim('marioAttack','pre',true)
        end
        playSound('psPre')
        doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom')+0.2,0.7,'quadOut')
        runTimer('charAttack',0.7)
        doTweenAlpha('charVignette','charVignette',1,0.7,'quadOut')
    elseif name == 'Triggers No Hope' then
        if v1 == '3' then
            playSound('psPre')
            
            cancelTween('charWarningAlpha')
            cancelTimer('charWarningExit')
            setProperty('charWarning.alpha',1)
            scaleObject('charWarning',0.4,0.4)
            updateHitbox('charWarning')
            screenCenter('charWarning')
            setProperty('charWarning.y',getProperty('charWarning.y')-1000)
            doTweenY('charWarningY','charWarning',getProperty('charWarning.y')+1000,1,'expoOut')
            runTimer('charWarningExit',1.5)

        end
    end
end
function bfDodge()
    dodge = true
    playAnim('boyfriend','dodge',true)
    setProperty('boyfriend.specialAnim',true)
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'strumTime')-getSongPosition() < 400 then
            setPropertyFromGroup('notes',notes,'noAnimation',true)
        end
    end
    runTimer('stopBfDodge',0.4)
end
function onTimerCompleted(tag)
    if tag == 'charAttack' then
        doTweenAlpha('charVignette','charVignette',0,0.5,'quadOut')
        cameraShake('game',0.15,0.007)
        cameraShake('hud',0.15,0.007)
        doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom'),0.5,'quadOut')
        playSound('psAtt')
        playAnim('marioAttack','attack',true)
        runTimer('marioBack',0.5)
        if botPlay then
            bfDodge()
        else
            if not dodge then
                setHealth(getHealth()-1)
            end
        end
    elseif tag == 'marioBack' then
        setProperty('dad.visible',true)
        setProperty('marioAttack.alpha',0)
    elseif tag == 'charWarningExit' then
        doTweenAlpha('charWarningAlpha','charWarning',0,1,'expoOut')
    elseif tag == 'stopBfDodge' then
        setProperty('boyfriend.specialAnim',false)
        dodge = false
    end
end