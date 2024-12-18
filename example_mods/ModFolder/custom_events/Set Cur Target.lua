local stayType = 0 --0 = don't stay, 1 = stay, 2 = only dad section, 3 = only bf section, 4 = only gf section;
local times = -1
local curTarget = ''

local targets = {
    boyfriend = nil,
    dad = nil,
    gf = nil,
    all = nil
}
function onEvent(name,v1,v2)
    if name == 'Set Cur Target' then
        local target = ''
        if v2 == '1' then
            target = 'all'
        elseif v2 == '2' then
            target = 'dad'
        elseif v2 == '3' then
            target = 'boyfriend'
        elseif v2 == '4' then
            target = 'gf'
        end
        if v1 ~= '' then
            if v1 == 'bf' then
                v1 = 'boyfriend'
            end
            if target ~= '' then
                targets[target] = v1
                if getCurSection() == target then
                    setTarget(v1)
                end
            else
                setTarget(v1)
            end
        else
            if target ~= '' then
                targets[target] = nil
            else
                targets = {}
                setTarget(getCurSection())
            end
        end
    end
end

function setTarget(focus)
    if focus ~= nil then
        callOnLuas('onMoveCamera',{focus})
    end
    --callScript('scripts/cameraMoviment','setCamTarget',{focus})
end
function onMoveCamera(focus)
    if targets[focus] ~= nil then
        setTarget(targets[focus])
    elseif targets.all ~= nil then
        setTarget(targets.all)
    end
end

function getCurSection()
    if gfSection ~= true then
        if mustHitSection then
            return 'boyfriend'
        else
            return 'dad'
        end
    else
        return 'gf'
    end
    return ''
end