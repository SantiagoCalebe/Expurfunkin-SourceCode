function onEvent(name, value1, value2)
    if name == 'Cam OFF' then
        doTweenAlpha('camGameOff' ,'camGame', value1, 0.00001, 'linear')
        doTweenAlpha('camHUDOff' ,'camHUD', value1, 0.00001, 'linear')
    end
end