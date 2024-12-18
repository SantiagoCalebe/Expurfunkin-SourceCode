local activated = false
function onCreate()
    makeAnimatedLuaSprite('wetWater','mario/abandoned/Flood_Assets',0,screenHeight)
    scaleObject('wetWater', 2.0, 2.0);
    addAnimationByPrefix('wetWater','anim','water overlay',24,true)
    setObjectCamera('wetWater','hud')
    setProperty('wetWater.alpha',0.7)
    addLuaSprite('wetWater',false)
end
function onUpdate(el)
    if activated then
        setHealth(getHealth() - (el*0.25*(100/math.max(1,(getProperty('wetWater.y')/2)))))
    end
    if getProperty('wetWater.y') <= -100 then
        setProperty('wetWater.y',-100)
    end
end
function onEvent(name,v1,v2)
    if name == 'Wet Water' then
        if v1 ~= '0' and v1 ~= '2' then
            activated = true
            cancelTween('wetWaterY')
            if getProperty('wetWater.y') > screenHeight + 100 or getProperty('wetWater.y') <= 0 then
                setProperty('wetWater.y',screenHeight)
            end
            doTweenY('wetWaterY','wetWater',getProperty('wetWater.y')-200,0.5,'cubeOut')
            setProperty('wetWater.velocity.y',-60)
            setProperty('wetWater.acceleration.y',0)
        elseif v1 == '0' then
            cancelTimer('resetWetWaterY')
            activated = false
            setProperty('wetWater.velocity.y',0)
            setProperty('wetWater.acceleration.y',80)
        elseif v1 == '2' then
            activated = false
            setProperty('wetWater.acceleration.y',0)
            doTweenY('wetWaterY','wetWater',-150,0.7,'sineIn')
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'resetWetWaterY' then
        if activated then
            setProperty('wetWater.velocity.y',-60)
        end
        setProperty('wetWater.acceleration.y',0)
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Water Note' and activated then
        setProperty('wetWater.velocity.y',math.max(300,getProperty('wetWater.velocity.y') + 50))
        
        setProperty('wetWater.acceleration.y',-1200)
        runTimer('resetWetWaterY',0.3)
    end
end