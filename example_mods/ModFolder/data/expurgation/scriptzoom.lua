function onMoveCamera(focus)
	if focus == 'boyfriend' then
		setProperty('defaultCamZoom', 0.5)

	elseif focus == 'dad' then
		setProperty('defaultCamZoom', 0.9)

    elseif focus == 'gf' then
		setProperty('defaultCamZoom', 0.5)
	end
end