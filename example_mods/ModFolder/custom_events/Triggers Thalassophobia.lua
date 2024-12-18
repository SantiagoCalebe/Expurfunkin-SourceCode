local allowFill = nil
local curFill = 8
function onCreate()
    makeAnimatedLuaSprite('Fill64','mario/lisfalse/health',0,(downscroll and screenHeight + 200 or -100))
    setObjectCamera('Fill64','hud')
    setProperty('Fill64.antialiasing',false)
    

    for hp = 0,8 do
        addAnimationByPrefix('Fill64','life'..hp,'health '..hp,0,false)
    end
    playAnim('Fill64','life8')
    setProperty('Fill64.scale.x',0.6)
    setProperty('Fill64.scale.y',0.6)
    screenCenter('Fill64','x')
    setProperty('Fill64.alpha',0.001)
    setProperty('Fill64.offset.x',60)
    addLuaSprite('Fill64',false)
end
function onEvent(name,v1,v2)
    if name == 'Triggers Thalassophobia' then
        if v1 == '2' then
            allowFill = not allowFill
        elseif v1 == '6' then
            if allowFill == nil then
                doTweenY('Fill64Y','Fill64',(downscroll and screenHeight - 150 or 0),2,'expoOut')
                doTweenAlpha('Fill64Alpha','Fill64',1,2,'expoOut')
                allowFill = true
            end
        elseif v1 == '7' then
            setFill(8)
        end
    end
end
function onUpdate(el)
    if curFill == -1 then
        setHealth(getHealth()-(el*0.5))
    end
end
function setFill(fill)
    curFill = fill
    playAnim('Fill64','life'..math.max(0,fill))
end
function goodNoteHit(id,data,type,sus)
    if type == 'Coin Note' then
        setFill(math.min(8,math.max(0,curFill) + 1))
    end
end
function onSectionHit()
    if allowFill and curSection % 2 == 0 then
        setFill(math.max(-1,curFill - 1))
    end
end