function onMoveCamera(focus)
	if focus == 'boyfriend' then
		setProperty('defaultCamZoom', 0.5)

	elseif focus == 'dad' then
		setProperty('defaultCamZoom', 1.5)

	elseif focus == 'gf' then
		setProperty('defaultCamZoom', 0.6)
	end
end