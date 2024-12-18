function onMoveCamera(focus)
	if focus == 'boyfriend' then
		setProperty('defaultCamZoom', 1)

	elseif focus == 'dad' then
		setProperty('defaultCamZoom', 0.9)
	end
end