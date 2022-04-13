forge.clear()

position  = {0,  0, 0}
rotation  = {0, 90, 0}
direction = {1,  0, 0}

courseLength = math.random(10, 20)

for s = 0, courseLength do

	previousDirection = direction

	position = {position[1] + direction[1], position[2] + direction[2], position[3] + direction[3]}
	
	if s == courseLength then
	
		randomGoals = { "Golf/end_hole", "Golf/end_roundHole", "Golf/end_roundHoleLarge" }
		randomGoal  = randomGoals[math.random(#randomGoals)]
	
		forge.build(randomGoal, position, {rotation[1], rotation[2] + 180, rotation[3]})
		
	else
	
		randomDirection = math.random(0, 2)
		
		if randomDirection == 0 then
		
			direction = {0, 0, 1}
			rotation  = {0, 0, 0}
		
		end
		
		if randomDirection == 1 then
		
			direction = {1, 0, 0}
			rotation  = {0, 90, 0}
		
		end
		
		if s == 0 then
		
			randomStarts = { "Golf/start", "Golf/start_closed" }
			randomStart  = randomStarts[math.random(#randomStarts)];
		
			forge.build(randomStart, position, rotation)
		
		else
		
			if previousDirection[1] == direction[1] and previousDirection[2] == direction[2] and previousDirection[3] == direction[3] then
			
				randomTracks = { "Golf/straight", "Golf/straight", "Golf/straight", "Golf/straight_bump", "Golf/bump", "Golf/straight_obstacleRound", "Golf/valley" }
				randomTrack  = randomTracks[math.random(#randomTracks)];
			
				forge.build(randomTrack, position, rotation)
				
				if math.random(0, 2) == 0 then
				
					forge.build("Fences/poles_garlandFlags", position, rotation)
				
				end
				
			else
			
				randomBends = { "Golf/bend", "Golf/corner_square" }
				randomBend  = randomBends[math.random(#randomBends)]
			
				if direction[1] == 1 and direction[2] == 0 and direction[3] == 0 then
			
					forge.build(randomBend, position, {0, 0, 0})
					
				end
				
				if direction[1] == 0 and direction[2] == 0 and direction[3] == 1 then
			
					forge.build(randomBend, position, {0, 180, 0})
					
				end
			
			end
			
		end
		
	end

end