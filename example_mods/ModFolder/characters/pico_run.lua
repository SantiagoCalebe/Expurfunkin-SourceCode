local whoispico = ''
local isON = false

function detectLegs()
    if getProperty('boyfriend.curCharacter') == 'pico_run' then
        whoispico = 'boyfriend'
    elseif getProperty('dad.curCharacter') == 'pico_run' then
        whoispico = 'dad'
    elseif getProperty('gf') ~= nil and getProperty('gf.curCharacter') == 'pico_run' then
        whoispico = 'gf'
    else
        return
    end
    createLegs()
end
function createLegs()
    setObjectOrder('picoarm',getObjectOrder(whoispico..'Group')-1)
    setObjectOrder('picolegs',getObjectOrder(whoispico..'Group')-1)
    isON = true
end
function removeLegs()
    --removeLuaSprite('picoarm',true)
    --removeLuaSprite('picolegs',true)
    isON = false
    setProperty('picolegs.alpha',0)
    setProperty('picoarm.alpha',0)
end
function onCreate()
    makeAnimatedLuaSprite('picoarm', 'characters/Too_Late_Pico_FINALSEQUENCE_assets', 0, 0);
    addAnimationByPrefix('picoarm', 'singLEFT', 'TopLeftBack', 24, false);
    addAnimationByPrefix('picoarm', 'singUP', 'TopUpBack', 24, false);
    addAnimationByPrefix('picoarm', 'singRIGHT', 'TopRightBack', 24, false);
    scaleObject('picoarm', 2.0, 2.0);
    setProperty('picoarm.alpha',0.001)
    addLuaSprite('picoarm', false);


    makeAnimatedLuaSprite('picolegs','characters/Too_Late_Pico_FINALSEQUENCE_assets', 0, 0);
    addAnimationByPrefix('picolegs', 'exist', 'Legs', 32, true);
    scaleObject('picolegs', 2.0, 2.0);
    setProperty('picolegs.alpha',0.001)
    addLuaSprite('picolegs', false);
    setProperty('picolegs.offset.x', 35);
    setProperty('picolegs.offset.y', -275);

    setProperty('picoarm.origin.x', 170);
    setProperty('picoarm.origin.y', 160);
end
-- fuck you
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        detectLegs()
    end
end

function goodNoteHit()
    if getProperty(whoispico..'.animation.curAnim.name') ~= 'singDOWN' then
        objectPlayAnimation('picoarm', getProperty(whoispico..'.animation.curAnim.name'), true)
    end
end

function onUpdatePost()
    if isON then
        setProperty('picoarm.alpha',getProperty(whoispico..'.alpha'))

        setProperty('picolegs.visible',getProperty(whoispico..'.visible'))
        setProperty('picolegs.alpha',getProperty(whoispico..'.alpha'))
        if getProperty(whoispico..'.animation.curAnim.name') ~= 'idle' and getProperty(whoispico..'.animation.curAnim.name') ~= 'dialog1' then
            if getProperty(whoispico..'.animation.curAnim.name') ~= 'singDOWN' then
                setProperty('picoarm.visible', getProperty(whoispico..'.visible'));
                if getProperty('picoarm.animation.curAnim.name') == 'singUP' then
                    setProperty('picoarm.offset.x', -73);
                    setProperty('picoarm.offset.y', -380);
                end
                if getProperty('picoarm.animation.curAnim.name') == 'singRIGHT' then
                    setProperty('picoarm.offset.x', -50);
                    setProperty('picoarm.offset.y', -200);
                end
                if getProperty('picoarm.animation.curAnim.name') == 'singLEFT' then
                    setProperty('picoarm.offset.x', -222);
                    setProperty('picoarm.offset.y', -207);
                end
            else
                setProperty('picoarm.visible', false);
            end

            if getProperty('picolegs.animation.frameIndex') == 0 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500);
                setProperty(whoispico..'.angle', -0.4)
                setProperty('picoarm.y', getProperty(whoispico..'.y'));
                setProperty('picoarm.angle', -0.4)
            end
            if getProperty('picolegs.animation.frameIndex') == 2 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + -3.75);
                setProperty(whoispico..'.angle', 0.8)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + -3.75);
                setProperty('picoarm.angle', 0.8)
            end
            if getProperty('picolegs.animation.frameIndex') == 4 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + 2.4);
                setProperty(whoispico..'.angle', 1.8)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + 2.4);
                setProperty('picoarm.angle', 1.8)
            end
            if getProperty('picolegs.animation.frameIndex') == 6 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + 6);
                setProperty(whoispico..'.angle', 0.3)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + 6);
                setProperty('picoarm.angle', 0.3)
            end
            if getProperty('picolegs.animation.frameIndex') == 8 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + 1.1);
                setProperty(whoispico..'.angle', -0.7)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + 1.1);
                setProperty('picoarm.angle', -0.7)
            end
            if getProperty('picolegs.animation.frameIndex') == 10 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + -6.4);
                setProperty(whoispico..'.angle', 1.2)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + -6.4);
                setProperty('picoarm.angle', 1.2)
            end
            if getProperty('picolegs.animation.frameIndex') == 12 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + -4.4);
                setProperty(whoispico..'.angle', 2.2)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + -4.4);
                setProperty('picoarm.angle', 2.2)
            end
            if getProperty('picolegs.animation.frameIndex') == 14 then
                setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500 + 2.15);
                setProperty(whoispico..'.angle', 1.5)
                setProperty('picoarm.y', getProperty(whoispico..'.y') + 2.15);
                setProperty('picoarm.angle', 1.5)
            end
        else
            if getProperty(whoispico..'.animation.curAnim.name') ~= 'dialog1' then
                setProperty(whoispico..'.animation.frameIndex', getProperty('picolegs.animation.frameIndex') + 89)
            end
            setProperty('picoarm.visible', false);
            setProperty(whoispico..'.angle', 0);
            setProperty(whoispico..'.y', getProperty(whoispico..'Group.y') + 500);
            
        end
        setProperty('picolegs.x', getProperty(whoispico..'.x'));
        setProperty('picolegs.y', getProperty(whoispico..'.y'));
        setProperty('picoarm.x', getProperty(whoispico..'.x'));
        setProperty('picoarm.y', getProperty(whoispico..'.y'));
    end
end