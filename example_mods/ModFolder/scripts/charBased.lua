function rgbToHex(r, g, b) 
	return string.format("%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b)) 
end 

function healthBarColor(char) 
	return rgbToHex(getProperty(char..'.healthColorArray[0]'), getProperty(char..'.healthColorArray[1]'), getProperty(char..'.healthColorArray[2]'))
end

-- re-texture on this note line 
-- only from "rgbShader.b"

function darkRgbToHex(r, g, b)
	return string.format("%02x%02x%02x", math.min(r), math.min(g), math.min(b))
end

function darkHealthBarCol(dChar)
	return darkRgbToHex(getProperty(dChar..'.healthColorArray[0]')/2, getProperty(dChar..'.healthColorArray[1]')/2, getProperty(dChar..'.healthColorArray[2]')/2)
end


function onCreatePost() -- first to make a strum
	for i = 0,7 do
	    -- dad
		setPropertyFromGroup("opponentStrums", i, "rgbShader.r", getColorFromHex(healthBarColor("dad")))
		setPropertyFromGroup("opponentStrums", i, "rgbShader.b", getColorFromHex(darkHealthBarCol("dad")))
		setPropertyFromGroup("opponentStrums", i, "rgbShader.enabled", false)
		-- bf
		setPropertyFromGroup("playerStrums", i, "rgbShader.r", getColorFromHex(healthBarColor("boyfriend")))
		setPropertyFromGroup("playerStrums", i, "rgbShader.b", getColorFromHex(darkHealthBarCol("boyfriend")))
		setPropertyFromGroup("playerStrums", i, "rgbShader.enabled", false)
	end
end

function onUpdatePost()
	for i = 0, getProperty("notes.length") -1 do
		local press = getPropertyFromGroup("notes", i, "mustPress")
		local gfPress = getPropertyFromGroup("notes", i, "gfNote")
		local shitHurtNote = getPropertyFromGroup("notes", i, "noteType") == "Hurt Note"
		
		-- my steps very clear
		
		if press then
			setPropertyFromGroup("notes", i, "rgbShader.r", getColorFromHex(healthBarColor("boyfriend")))
			setPropertyFromGroup("notes", i, "rgbShader.b", getColorFromHex(darkHealthBarCol("boyfriend")))
		end
		
		if not press then
			setPropertyFromGroup("notes", i, "rgbShader.r", getColorFromHex(healthBarColor("dad")))	
			setPropertyFromGroup("notes", i, "rgbShader.b", getColorFromHex(darkHealthBarCol("dad")))	
		end
		
		if gfPress then
			setPropertyFromGroup("notes", i, "rgbShader.r", getColorFromHex(healthBarColor("gf")))	
			setPropertyFromGroup("notes", i, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))	
		end
		
		if shitHurtNote then
			setPropertyFromGroup("notes", i, "rgbShader.r", 0x000000)
			setPropertyFromGroup("notes", i, "rgbShader.g", 0xFF0000)
			setPropertyFromGroup("notes", i, "rgbShader.b", 0x350000)
		end
	end
	
end


function goodNoteHit(id, noteData, noteType, isSustainNote)

	if noteData == 0 then
		setPropertyFromGroup("strumLineNotes", 4, "rgbShader.r", getColorFromHex(healthBarColor("boyfriend")))
		setPropertyFromGroup("strumLineNotes", 4, "rgbShader.b", getColorFromHex(darkHealthBarCol("boyfriend")))
	end
			
	if noteData == 1 then
		setPropertyFromGroup("strumLineNotes", 5, "rgbShader.r", getColorFromHex(healthBarColor("boyfriend")))
		setPropertyFromGroup("strumLineNotes", 5, "rgbShader.b", getColorFromHex(darkHealthBarCol("boyfriend")))
	end
			
	if noteData == 2 then
		setPropertyFromGroup("strumLineNotes", 6, "rgbShader.r", getColorFromHex(healthBarColor("boyfriend")))
		setPropertyFromGroup("strumLineNotes", 6, "rgbShader.b", getColorFromHex(darkHealthBarCol("boyfriend")))
	end
			
	if noteData == 3 then
		setPropertyFromGroup("strumLineNotes", 7, "rgbShader.r", getColorFromHex(healthBarColor("boyfriend")))
		setPropertyFromGroup("strumLineNotes", 7, "rgbShader.b", getColorFromHex(darkHealthBarCol("boyfriend")))
	end
		
	-- make a gf thing to work
			
	if noteType == "GF Sing" then
		if noteData == 0 then
			setPropertyFromGroup("strumLineNotes", 4, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 4, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
			end
				
		if noteData == 1 then
			setPropertyFromGroup("strumLineNotes", 5, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 5, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
				
		if noteData == 2 then
			setPropertyFromGroup("strumLineNotes", 6, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 6, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
				
			if noteData == 3 then
			setPropertyFromGroup("strumLineNotes", 7, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 7, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
	end
	
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)

	if noteData == 0 then
		setPropertyFromGroup("strumLineNotes", 0, "rgbShader.r", getColorFromHex(healthBarColor("dad")))
		setPropertyFromGroup("strumLineNotes", 0, "rgbShader.b", getColorFromHex(darkHealthBarCol("dad")))
	end
				
	if noteData == 1 then
		setPropertyFromGroup("strumLineNotes", 1, "rgbShader.r", getColorFromHex(healthBarColor("dad")))
		setPropertyFromGroup("strumLineNotes", 1, "rgbShader.b", getColorFromHex(darkHealthBarCol("dad")))
	end
				
	if noteData == 2 then
		setPropertyFromGroup("strumLineNotes", 2, "rgbShader.r", getColorFromHex(healthBarColor("dad")))
		setPropertyFromGroup("strumLineNotes", 2, "rgbShader.b", getColorFromHex(darkHealthBarCol("dad")))
	end

	if noteData == 3 then
		setPropertyFromGroup("strumLineNotes", 3, "rgbShader.r", getColorFromHex(healthBarColor("dad")))
		setPropertyFromGroup("strumLineNotes", 3, "rgbShader.b", getColorFromHex(darkHealthBarCol("dad")))
	end
			
	if noteType == "GF Sing" then
		if noteData == 0 then
			setPropertyFromGroup("strumLineNotes", 0, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 0, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
					
		if noteData == 1 then
			setPropertyFromGroup("strumLineNotes", 1, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 1, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
					
		if noteData == 2 then
			setPropertyFromGroup("strumLineNotes", 2, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 2, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
				
		if noteData == 3 then
			setPropertyFromGroup("strumLineNotes", 3, "rgbShader.r", getColorFromHex(healthBarColor("gf")))
			setPropertyFromGroup("strumLineNotes", 3, "rgbShader.b", getColorFromHex(darkHealthBarCol("gf")))
		end
	end
	
end
