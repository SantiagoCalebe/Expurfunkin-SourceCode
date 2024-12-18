function onCreate()
    setProperty('skipCountdown', true);
    
end

function onBeatHit()
	if curBeat >= 300 then
        noteTweenX('left',4,200,1)
        noteTweenX('down',5,400,1)
        noteTweenX('up',6,800,1)
        noteTweenX('right',7,1000,1)

        for i = 0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
        end
    end
end
