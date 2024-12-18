function onUpdate(elapsed)

    if curStep >= 525 then
  
      songPos = getSongPosition()
      local currentBeat = (songPos/1000)*(bpm/80)
      doTweenY(GfTweenY, 'gf', 300-110*math.sin((currentBeat*0.25)*math.pi),0.001)
  
    end
  
  end
  