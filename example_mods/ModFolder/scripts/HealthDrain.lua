function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if getHealth() > 0.1 then addHealth(-0.005) end
end

function onUpdate(elapsed)
    if getHealth() == 0.1 then setHealth(0.1) end
end

function goodNoteHit(i, noteData, noteType, isSustainNote)
    if getPropertyFromGroup('notes', i, 'rating') == 'good' then addHealth(-0.050) end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if getHealth() == 0.1 then setHealth(0) end
end

function onCreatePost()
    setProperty('healthGain', 2)
end