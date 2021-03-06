// "logic.agc"...

function SetupForNewGame()
	
	PaddleScreenX[0] = ScreenWidth/2
	PaddleScreenY[0] = (ScreenHeight/2) + 258
	PaddleDestinationX[0] = (Screenwidth/2)
	PaddleDestinationDir[0] = JoyCENTER

	PaddleScreenX[1] = ScreenWidth/2
	PaddleScreenY[1] = (ScreenHeight/2) - 258
	PaddleDestinationX[1] = (ScreenWidth/2)
	PaddleDestinationDir[1] = JoyCENTER

	BallOffsetY = BallOffsetYArray[GameMode]

	BallScreenX[0] = ScreenWidth/2
	BallScreenY[0] = ScreenHeight/2 + (ScreenHeight/3)
	BallMovementX[0] = (BallOffsetY * -1)
	BallMovementY[0] = (BallOffsetY * -1)
	BallStillColliding[0] = FALSE

	BallScreenX[1] = ScreenWidth/2
	BallScreenY[1] = ScreenHeight/2 - (ScreenHeight/3)
	BallMovementX[1] = BallOffsetY
	BallMovementY[1] = BallOffsetY
	BallStillColliding[1] = FALSE
	
	Score[0] = 0
	Score[1] = 0
	Level = -1

	Lives[0] = 5
	Lives[1] = 5

	PlayerLostLife[0] = FALSE
	PlayerLostLife[1] = FALSE

	arrayY as integer
	arrayX as integer
	for arrayY = 0 to 10
		for arrayX = 0 to 9
			WallSpriteBackup[arrayX, arrayY] = 0
		next arrayX
	next arrayY

	if (StartingLevel > 0)
		Level = StartingLevel

		if (Level < 4)
			PlayNewMusic(1, 1)
		elseif (Level < 7)
			PlayNewMusic(2, 1)
		elseif (Level < 9)
			PlayNewMusic(3, 1)
		elseif (Level > 8)
			PlayNewMusic(4, 1)
		endif
	endif
	
	GamePaused = FALSE
	
	GameOver = -1
endfunction

//------------------------------------------------------------------------------------------------------------

function InitializeBrickForNewLevel(color as integer, indexX as integer, indexY as integer, screenX as float, screenY as float)
	inc WallTotal, 1
	if ( GetSpriteExists(WallSprite[indexX, indexY]) = 1 ) 
		SetSpritePositionByOffset( WallSprite[indexX, indexY], screenX, screenY )
		if (color = 1) // Red
			SetSpriteColorRed(WallSprite[indexX, indexY], 255)
			SetSpriteColorGreen(WallSprite[indexX, indexY], 0)
			SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
		elseif (color = 2) // Orangle
			SetSpriteColorRed(WallSprite[indexX, indexY], 255)
			SetSpriteColorGreen(WallSprite[indexX, indexY], 155)
			SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
		elseif (color = 3) // Yellow
			SetSpriteColorRed(WallSprite[indexX, indexY], 255)
			SetSpriteColorGreen(WallSprite[indexX, indexY], 255)
			SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
		elseif (color = 4) // Green
			SetSpriteColorRed(WallSprite[indexX, indexY], 0)
			SetSpriteColorGreen(WallSprite[indexX, indexY], 255)
			SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
		elseif (color = 5) // Blue
			SetSpriteColorRed(WallSprite[indexX, indexY], 0)
			SetSpriteColorGreen(WallSprite[indexX, indexY], 0)
			SetSpriteColorBlue(WallSprite[indexX, indexY], 255)
		elseif (color = 6) // Purple
			SetSpriteColorRed(WallSprite[indexX, indexY], 255)
			SetSpriteColorGreen(WallSprite[indexX, indexY], 0)
			SetSpriteColorBlue(WallSprite[indexX, indexY], 255)
		endif
		
		WallSpriteBackup[indexX, indexY] = color
	endif
endfunction

//------------------------------------------------------------------------------------------------------------

function SetupLevel()
	arrayY as integer
	arrayX as integer

	screenX as float
	screenX = 0 + (36/2)
	screenY as float
	screenY = ( (ScreenHeight / 2) - (18*5) + (18/2) )
	indexY as integer
	indexX as integer

	if ( (PlayerLostLife[0] = FALSE and PlayerLostLife[1] = FALSE) or (WallTotal = 0) )
		WallTotal = 0
	
		if (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode = AdultStoryMode)
			if (Lives[1] = -1)
				Lives[1] = 5
			endif
		elseif (GameMode = ChildTwoPlayerMode or GameMode = TeenTwoPlayerMode or GameMode = AdultTwoPlayerMode)
			if (Lives[1] = -1)
				Lives[1] = 5
			endif
			if (Lives[0] = -1)
				Lives[0] = 5
			endif
		endif
	
		inc Level, 1
	
		if (LevelSkip[GameMode] < Level) then LevelSkip[GameMode] = Level	
		
		if (Level = 0)
			PlayNewMusic(1, 1)
		elseif (Level = 4)
			PlayNewMusic(2, 1)
		elseif (Level = 7)
			PlayNewMusic(3, 1)
		elseif (Level = 9)
			PlayNewMusic(4, 1)
		endif

		for arrayY = 0 to 10
			for arrayX = 0 to 9
				WallSpriteBackup[arrayX, arrayY] = 0
			next arrayX
		next arrayY
				
		for indexY = 0 to 10
			for indexX = 0 to 9
				select Level
					case 0:
						if (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase	
					
					case 1:
						if (indexY = 4 or indexY = 6)
							if ( mod(indexX, 2) = 0)
								InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
							endif
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
						
					case 2:
						if (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase	
				
					case 3:
						if (indexY = 3 or indexY = 7)
							if ( mod(indexX, 2) = 0)
								InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
							endif
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
						
					case 4:
						if (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
						
					case 5:
						if (indexY = 2 or indexY = 8)
							if ( mod(indexX, 2) = 0)
								InitializeBrickForNewLevel(4, indexX, indexY, screenX, screenY)
							endif
						elseif (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
					
					case 6:
						if (indexY = 2 or indexY = 8)
							InitializeBrickForNewLevel(4, indexX, indexY, screenX, screenY)
						elseif (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
						
					case 7:
						if (indexY = 1 or indexY = 9)
							if ( mod(indexX, 2) = 0)
								InitializeBrickForNewLevel(5, indexX, indexY, screenX, screenY)
							endif
						elseif (indexY = 2 or indexY = 8)
							InitializeBrickForNewLevel(4, indexX, indexY, screenX, screenY)
						elseif (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
					
					case 8:
						if (indexY = 1 or indexY = 9)
							InitializeBrickForNewLevel(5, indexX, indexY, screenX, screenY)
						elseif (indexY = 2 or indexY = 8)
							InitializeBrickForNewLevel(4, indexX, indexY, screenX, screenY)
						elseif (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
					
					case 9:
						if (indexY = 0 or indexY = 10)
							if ( mod(indexX, 2) = 0)
								InitializeBrickForNewLevel(6, indexX, indexY, screenX, screenY)
							endif
						elseif (indexY = 1 or indexY = 9)
							InitializeBrickForNewLevel(5, indexX, indexY, screenX, screenY)
						elseif (indexY = 2 or indexY = 8)
							InitializeBrickForNewLevel(4, indexX, indexY, screenX, screenY)
						elseif (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
					
					case default:
						if (indexY = 0 or indexY = 10)
							InitializeBrickForNewLevel(6, indexX, indexY, screenX, screenY)
						elseif (indexY = 1 or indexY = 9)
							InitializeBrickForNewLevel(5, indexX, indexY, screenX, screenY)
						elseif (indexY = 2 or indexY = 8)
							InitializeBrickForNewLevel(4, indexX, indexY, screenX, screenY)
						elseif (indexY = 3 or indexY = 7)
							InitializeBrickForNewLevel(3, indexX, indexY, screenX, screenY)
						elseif (indexY = 4 or indexY = 6)
							InitializeBrickForNewLevel(2, indexX, indexY, screenX, screenY)
						elseif (indexY = 5)
							InitializeBrickForNewLevel(1, indexX, indexY, screenX, screenY)
						endif
					endcase
				endselect
	
				screenX = screenX + 36
			next indexX
			
			screenX = 0 + (36/2)
			screenY = screenY + 18
		next indexY
	else
		WallTotal = 0

		for indexY = 0 to 10
			for indexX = 0 to 9
				if (WallSpriteBackup[indexX, indexY] > 0) then InitializeBrickForNewLevel(WallSpriteBackup[indexX, indexY], indexX, indexY, screenX, screenY)

				screenX = screenX + 36
			next indexX
			
			screenX = 0 + (36/2)
			screenY = screenY + 18
		next indexY
	endif

	PlayerLostLife[0] = FALSE
	PlayerLostLife[1] = FALSE

	PaddleScreenX[0] = ScreenWidth/2
	PaddleScreenY[0] = (ScreenHeight/2) + 258
	PaddleDestinationX[0] = (Screenwidth/2)
	PaddleDestinationDir[0] = JoyCENTER

	PaddleScreenX[1] = ScreenWidth/2
	PaddleScreenY[1] = (ScreenHeight/2) - 258
	PaddleDestinationX[1] = (ScreenWidth/2)
	PaddleDestinationDir[1] = JoyCENTER

	BallOffsetY = BallOffsetYArray[GameMode]

	BallScreenX[0] = ScreenWidth/2
	BallScreenY[0] = ScreenHeight/2 + (ScreenHeight/3)
	BallMovementX[0] = (BallOffsetY * -1)
	BallMovementY[0] = (BallOffsetY * -1)
	BallStillColliding[0] = FALSE

	BallScreenX[1] = ScreenWidth/2
	BallScreenY[1] = ScreenHeight/2 - (ScreenHeight/3)
	BallMovementX[1] = BallOffsetY
	BallMovementY[1] = BallOffsetY
	BallStillColliding[1] = FALSE
endfunction

//------------------------------------------------------------------------------------------------------------

function MoveBallWithCollisionDetection()
	index as integer
	arrayX as integer
	arrayY as integer
	for index = 0 to 1
		inc BallScreenX[index], BallMovementX[index]	
		inc BallScreenY[index], BallMovementY[index]
		
		if (BallScreenX[index] < 13)
			BallScreenX[index] = 13+5
			BallMovementX[index] = BallMovementX[index] * -1
			if (BallMovementX[index] > BallOffsetY) then dec BallMovementX[index], 0.34
			PlaySoundEffect(2)				
		elseif ( BallScreenX[index] > (360-13) )
			BallScreenX[index] = (360-13-5)
			BallMovementX[index] = BallMovementX[index] * -1
			if (BallMovementX[index] < BallOffsetY) then inc BallMovementX[index], 0.34
			PlaySoundEffect(2)				
		endif
		
		if (BallScreenY[index] < 30)
			BallScreenY[index] = 30
			BallMovementY[index] = BallMovementY[index] * -1
			if (SecretCodeCombined <> 9876)
				PlayerLostLife[1] = TRUE
				if (Lives[1] > 0) then dec Lives[1], 1
				
				if (Lives[1] = 0)
					Lives[1] = -1
					if (GameMode = ChildTwoPlayerMode or GameMode = TeenTwoPlayerMode or GameMode = AdultTwoPlayerMode)
						PlaySoundEffect(5)
						
						Score[1] = 0
						SetTextStringOutlined ( ScoreText[1], str(Score[1]) )
						
						if (Lives[0] < 1)
							if (CurrentlyPlayingMusicIndex > -1) then StopMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
							GameOver = 50
						endif
					elseif (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode = AdultStoryMode)
						NextScreenToDisplay = PlayingScreen
						ScreenFadeStatus = FadingToBlack
					endif
				endif
																
				if (Lives[1] > -1)
					PlaySoundEffect(4)
					NextScreenToDisplay = PlayingScreen
					ScreenFadeStatus = FadingToBlack
				endif
			endif
			PlaySoundEffect(2)
		elseif ( BallScreenY[index] > (640-30) )
			BallScreenY[index] = (640-30)
			BallMovementY[index] = BallMovementY[index] * -1
			if (SecretCodeCombined <> 9876)
				PlayerLostLife[0] = TRUE
				if (Lives[0] > 0) then dec Lives[0], 1
				
				if (Lives[0] = 0)
					Lives[0] = -1
					if (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode = AdultStoryMode)
						PlaySoundEffect(5)
						if (CurrentlyPlayingMusicIndex > -1) then StopMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
						GameOver = 50
					elseif (GameMode = ChildTwoPlayerMode or GameMode = TeenTwoPlayerMode or GameMode = AdultTwoPlayerMode)
						PlaySoundEffect(5)
						
						Score[0] = 0
						SetTextStringOutlined ( ScoreText[0], str(Score[0]) )
						
						if (Lives[1] < 1)
							if (CurrentlyPlayingMusicIndex > -1) then StopMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
							GameOver = 50
						endif
					endif
				endif

				if (Lives[0] > -1)
					PlaySoundEffect(4)
					NextScreenToDisplay = PlayingScreen
					ScreenFadeStatus = FadingToBlack
				endif
			endif
			PlaySoundEffect(2)				
		endif
	next index
endfunction

//------------------------------------------------------------------------------------------------------------

function RunGameplayCore()
	if ( SecretCodeCombined = 9876 and ShiftKeyPressed = TRUE and LastKeyboardChar = 76)
		NextScreenToDisplay = PlayingScreen
		ScreenFadeStatus = FadingToBlack
		DelayAllUserInput = 25
		exitfunction
	endif
	
	index as integer
	if (Platform <> Android and Platform <> iOS)
		if ( JoystickDirection = JoyLEFT and PaddleScreenX[0] > (40) )
			PaddleDestinationDir[0] = JoyLEFT
			dec PaddleScreenX[0], 7
			SetSpritePositionByOffset( PaddleSprite[0], PaddleScreenX[0], PaddleScreenY[0] )
		elseif ( JoystickDirection = JoyRIGHT and PaddleScreenX[0] < (360-40) )
			PaddleDestinationDir[0] = JoyRIGHT
			inc PaddleScreenX[0], 7
			SetSpritePositionByOffset( PaddleSprite[0], PaddleScreenX[0], PaddleScreenY[0] )
		else
			PaddleDestinationDir[0] = JoyCENTER
		endif

		if (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode = AdultStoryMode)
			if (BallScreenY[1] < BallScreenY[0])
				if (BallScreenX[1] < PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyLEFT
				elseif (BallScreenX[1] > PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyRIGHT
				endif

				PaddleDestinationX[1] = BallScreenX[1]
			elseif (BallScreenY[1] > BallScreenY[0])
				if (BallScreenX[0] < PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyLEFT
				elseif (BallScreenX[0] > PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyRIGHT
				endif

				PaddleDestinationX[1] = BallScreenX[0]
			endif

			if (MouseButtonLeft = ON)
				if (MouseScreenY > 640-150)
					PaddleDestinationX[0] = MouseScreenX

					if (PaddleScreenX[0] > MouseScreenX)
						PaddleDestinationDir[0] = JoyLEFT
					elseif (PaddleScreenX[0] < MouseScreenX)
						PaddleDestinationDir[0] = JoyRIGHT
					else
						PaddleDestinationDir[0] = JoyCENTER
					endif
				endif
			endif		
		elseif (MouseButtonLeft = ON)
			if (MouseScreenY < 150)
				PaddleDestinationX[1] = MouseScreenX

				if (PaddleScreenX[1] > MouseScreenX)
					PaddleDestinationDir[1] = JoyLEFT
				elseif (PaddleScreenX[1] < MouseScreenX)
					PaddleDestinationDir[1] = JoyRIGHT
				else
					PaddleDestinationDir[1] = JoyCENTER
				endif
			endif
		endif
	elseif (Platform = Android or Platform = iOS)
		if (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode = AdultStoryMode)
			if (BallScreenY[1] < BallScreenY[0])
				if (BallScreenX[1] < PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyLEFT
				elseif (BallScreenX[1] > PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyRIGHT
				endif

				PaddleDestinationX[1] = BallScreenX[1]
			elseif (BallScreenY[1] > BallScreenY[0])
				if (BallScreenX[0] < PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyLEFT
				elseif (BallScreenX[0] > PaddleScreenX[1])
					PaddleDestinationDir[1] = JoyRIGHT
				endif

				PaddleDestinationX[1] = BallScreenX[0]
			endif

			if (MouseScreenY > 640-150)
				PaddleDestinationX[0] = MouseScreenX

				if (PaddleScreenX[0] > MouseScreenX)
					PaddleDestinationDir[0] = JoyLEFT
				elseif (PaddleScreenX[0] < MouseScreenX)
					PaddleDestinationDir[0] = JoyRIGHT
				else
					PaddleDestinationDir[0] = JoyCENTER
				endif
			endif

			if (MouseButtonLeft = ON)
				if ( MouseScreenY > 200 and MouseScreenY < (640-200) )
					if (GamePaused = FALSE)
						GamePaused = TRUE
						SetSpritePositionByOffset( BoardBG, ScreenWidth/2, ScreenHeight/2 )
						SetSpriteColorAlpha(BoardBG, 200)
						SetTextStringOutlined ( PausedText[0], "GAME PAUSED!" )
						SetTextStringOutlined ( PausedText[1], "GAME PAUSED!" )
						MouseButtonLeft = OFF
						DelayAllUserInput = 50
						PlaySoundEffect(2)
						if CurrentlyPlayingMusicIndex > -1 then PauseMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
					endif
				endif
			endif		
		elseif GetMultiTouchExists()=1
			if GetRawTouchCount(1)=2
				if ( TapCurrentY[0] < 150 )
					PaddleDestinationX[1] = TapCurrentX[0]

					if (PaddleScreenX[1] > TapCurrentX[0])
						PaddleDestinationDir[1] = JoyLEFT
					elseif (PaddleScreenX[1] < TapCurrentX[0])
						PaddleDestinationDir[1] = JoyRIGHT
					else
						PaddleDestinationDir[1] = JoyCENTER
					endif
				elseif ( TapCurrentY[0] > 640-150 )
					PaddleDestinationX[0] = TapCurrentX[0]

					if (PaddleScreenX[0] > TapCurrentX[0])
						PaddleDestinationDir[0] = JoyLEFT
					elseif (PaddleScreenX[0] < TapCurrentX[0])
						PaddleDestinationDir[0] = JoyRIGHT
					else
						PaddleDestinationDir[0] = JoyCENTER
					endif
				elseif ( TapCurrentY[0] > 200 and TapCurrentY[0] < (640-200) )
					if (GamePaused = FALSE)
						GamePaused = TRUE
						SetSpritePositionByOffset( BoardBG, ScreenWidth/2, ScreenHeight/2 )
						SetSpriteColorAlpha(BoardBG, 200)
						SetTextStringOutlined ( PausedText[0], "GAME PAUSED!" )
						SetTextStringOutlined ( PausedText[1], "GAME PAUSED!" )
						MouseButtonLeft = OFF
						TapCurrentY[0] = -9999
						DelayAllUserInput = 50
						PlaySoundEffect(2)
						if CurrentlyPlayingMusicIndex > -1 then PauseMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
					endif				
				endif

				if ( TapCurrentY[1] < 150 )
					PaddleDestinationX[1] = TapCurrentX[1]

					if (PaddleScreenX[1] > TapCurrentX[1])
						PaddleDestinationDir[1] = JoyLEFT
					elseif (PaddleScreenX[1] < TapCurrentX[1])
						PaddleDestinationDir[1] = JoyRIGHT
					else
						PaddleDestinationDir[1] = JoyCENTER
					endif
				elseif ( TapCurrentY[1] > 640-150 )
					PaddleDestinationX[0] = TapCurrentX[1]

					if (PaddleScreenX[0] > TapCurrentX[1])
						PaddleDestinationDir[0] = JoyLEFT
					elseif (PaddleScreenX[0] < TapCurrentX[1])
						PaddleDestinationDir[0] = JoyRIGHT
					else
						PaddleDestinationDir[0] = JoyCENTER
					endif
				elseif ( TapCurrentY[1] > 200 and TapCurrentY[1] < (640-200) )
					if (GamePaused = FALSE)
						GamePaused = TRUE
						SetSpritePositionByOffset( BoardBG, ScreenWidth/2, ScreenHeight/2 )
						SetSpriteColorAlpha(BoardBG, 200)
						SetTextStringOutlined ( PausedText[0], "GAME PAUSED!" )
						SetTextStringOutlined ( PausedText[1], "GAME PAUSED!" )
						MouseButtonLeft = OFF
						TapCurrentY[1] = -9999
						DelayAllUserInput = 50
						PlaySoundEffect(2)
						if CurrentlyPlayingMusicIndex > -1 then PauseMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
					endif				
				endif
			elseif (MouseButtonLeft = ON)
				if (MouseScreenY < 150 )
					PaddleDestinationX[1] = MouseScreenX

					if (PaddleScreenX[1] > MouseScreenX)
						PaddleDestinationDir[1] = JoyLEFT
					elseif (PaddleScreenX[1] < MouseScreenX)
						PaddleDestinationDir[1] = JoyRIGHT
					else
						PaddleDestinationDir[1] = JoyCENTER
					endif
				elseif (MouseScreenY > 640-150 )
					PaddleDestinationX[0] = MouseScreenX

					if (PaddleScreenX[0] > MouseScreenX)
						PaddleDestinationDir[0] = JoyLEFT
					elseif (PaddleScreenX[0] < MouseScreenX)
						PaddleDestinationDir[0] = JoyRIGHT
					else
						PaddleDestinationDir[0] = JoyCENTER
					endif	
				elseif ( MouseScreenY > 200 and MouseScreenY < (640-200) )
					if (GamePaused = FALSE)
						GamePaused = TRUE
						SetSpritePositionByOffset( BoardBG, ScreenWidth/2, ScreenHeight/2 )
						SetSpriteColorAlpha(BoardBG, 200)
						SetTextStringOutlined ( PausedText[0], "GAME PAUSED!" )
						SetTextStringOutlined ( PausedText[1], "GAME PAUSED!" )
						MouseButtonLeft = OFF
						DelayAllUserInput = 50
						PlaySoundEffect(2)
						if CurrentlyPlayingMusicIndex > -1 then PauseMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
					endif				
				endif		
			endif
		endif	
	endif

	for index = 0 to 1
		if ( index = 0 and JoystickDirection <> JoyCENTER )
			PaddleDestinationX[index] = PaddleScreenX[index]
			if (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode =  AdultStoryMode) then MouseButtonLeft = OFF
		else
			paddleMoveSpeed as integer
			paddleMoveSpeed = 7

			if (index = 1)			
				if (GameMode = ChildStoryMode)
					paddleMoveSpeed = 1
				elseif (GameMode = TeenStoryMode)
					paddleMoveSpeed = 5
				elseif (GameMode = AdultStoryMode)
					paddleMoveSpeed = 3
				endif
			endif
						
			if (PaddleDestinationDir[index] = JoyLEFT)
				dec PaddleScreenX[index], paddleMoveSpeed
				if ( PaddleScreenX[index] < (40) ) then PaddleScreenX[index] = (40)
						
				SetSpritePositionByOffset( PaddleSprite[index], PaddleScreenX[index], PaddleScreenY[index] )

				if (PaddleScreenX[index] < PaddleDestinationX[index])
					PaddleScreenX[index] = PaddleDestinationX[index]
					PaddleDestinationDir[index] = JoyCENTER
				endif
			elseif (PaddleDestinationDir[index] = JoyRIGHT)
				inc PaddleScreenX[index], paddleMoveSpeed
				if ( PaddleScreenX[index] > (360-40) ) then PaddleScreenX[index] = (360-40)

				SetSpritePositionByOffset( PaddleSprite[index], PaddleScreenX[index], PaddleScreenY[index] )

				if (PaddleScreenX[index] > PaddleDestinationX[index])
					PaddleScreenX[index] = PaddleDestinationX[index]
					PaddleDestinationDir[index] = JoyCENTER
				endif
			endif
				
			if (Lives[index] = -1) then SetSpritePositionByOffset( PaddleSprite[index], -9999, -9999 )
		endif
	next index

	MoveBallWithCollisionDetection ( )

	ballIndex as integer
	for ballIndex = 0 to 1
		SetSpritePositionByOffset( BallSprite[ballIndex], BallScreenX[ballIndex], BallScreenY[ballIndex] )

		if (BallStillColliding[ballIndex] = TRUE)
			MoveBallWithCollisionDetection ( )
			
			SetSpritePositionByOffset( BallSprite[ballIndex], BallScreenX[ballIndex], BallScreenY[ballIndex] )
			
			if ( BallScreenY[ballIndex] > (ScreenHeight/2) and GetSpriteCollision(BallSprite[ballIndex], PaddleSprite[0]) <> 1 )
				BallStillColliding[ballIndex] = FALSE
			elseif ( BallScreenY[ballIndex] < (ScreenHeight/2) and GetSpriteCollision(BallSprite[ballIndex], PaddleSprite[1]) <> 1 )
				BallStillColliding[ballIndex] = FALSE
			endif
		elseif (BallStillColliding[ballIndex] = FALSE)
			paddleIndex as integer
			for paddleIndex = 0 to 1
				If ( BallStillColliding[ballIndex] = FALSE and GetSpriteCollision(BallSprite[ballIndex], PaddleSprite[paddleIndex]) = 1 )
					BallMovementY[ballIndex] = BallMovementY[ballIndex] * -1

					if (BallMovementX[ballIndex] < 0)
						if (PaddleDestinationDir[paddleIndex] = JoyRIGHT)
							BallMovementX[ballIndex] = BallMovementX[ballIndex] * -1
							inc BallMovementX[ballIndex], 1
						elseif (PaddleDestinationDir[paddleIndex] = JoyLEFT)
							inc BallMovementX[ballIndex], 1
						endif
					elseif (BallMovementX[ballIndex] > 0)
						if (PaddleDestinationDir[paddleIndex] = JoyLEFT)
							BallMovementX[ballIndex] = BallMovementX[ballIndex] * -1
							dec BallMovementX[ballIndex], 1
						elseif (PaddleDestinationDir[paddleIndex] = JoyRIGHT)
							dec BallMovementX[ballIndex], 1
						endif
					elseif (BallMovementX[ballIndex] = 0)
						if (PaddleDestinationDir[paddleIndex] = JoyLEFT)
							dec BallMovementX[ballIndex], 1
						elseif (PaddleDestinationDir[paddleIndex] = JoyRIGHT)
							inc BallMovementX[ballIndex], 1
						endif
					endif

					PlaySoundEffect(2)				
					BallStillColliding[ballIndex] = TRUE
				endif
			next paddleIndex
		endif

		indexX as integer
		indexY as integer
		for indexY = 0 to 10
			for indexX = 0 to 9
				if ( GetSpriteExists(WallSprite[indexX, indexY]) = 1 )
					if ( GetSpriteCollision(BallSprite[ballIndex], WallSprite[indexX, indexY]) = 1 )
						WallSpriteBackup[indexX, indexY] = 0
												
						if (BallMovementY[ballIndex] < 0)
							inc BallScreenY[ballIndex], BallOffsetY
						elseif (BallMovementY[ballIndex] > 0)
							dec BallScreenY[ballIndex], BallOffsetY
						endif
						SetSpritePositionByOffset( BallSprite[ballIndex], BallScreenX[ballIndex], BallScreenY[ballIndex] )

						BallMovementY[ballIndex] = BallMovementY[ballIndex] * -1

						PlaySoundEffect(3)				
						
						if ( GetSpriteExists(WallSprite[indexX, indexY]) = 1 ) then DeleteSprite(WallSprite[indexX, indexY])
												
						paddleGettingScore as integer
						paddleGettingScore = ballIndex											
						if (GameMode = ChildTwoPlayerMode or GameMode = TeenTwoPlayerMode or GameMode = AdultTwoPlayerMode)
							if (Lives[0] < 1)
								paddleGettingScore = 1
							elseif (Lives[1] < 1)
								paddleGettingScore = 0
							endif
						endif
						inc Score[paddleGettingScore], ( 10 * (1+Level) )
						SetTextStringOutlined ( ScoreText[paddleGettingScore], str(Score[paddleGettingScore]) )

						indexX = 10
						indexY = 11
						
						if (WallTotal > 0) then dec WallTotal, 1

						if (WallTotal = 0)
							if (GameMode = ChildStoryMode or GameMode = TeenStoryMode or GameMode = AdultStoryMode)
								if (Level = 10)
									WonGame = TRUE
									Level = 11
								endif
								
								NextScreenToDisplay = PlayingScreen
								ScreenFadeStatus = FadingToBlack
							elseif (GameMode = ChildTwoPlayerMode or GameMode = TeenTwoPlayerMode or GameMode = AdultTwoPlayerMode)
								if (Level = 10)
									WonGame = TRUE
									Level = 11
								endif
								
								NextScreenToDisplay = PlayingScreen
								ScreenFadeStatus = FadingToBlack
							endif							
							exitfunction
						endif
					endif
				endif
			next indexX
		next indexY

		particleIndex as integer
		for particleIndex = 4 to 1 step -1
			BallParticleScreenX[ballIndex, particleIndex] = BallParticleScreenX[ballIndex, particleIndex-1]
			BallParticleScreenY[ballIndex, particleIndex] = BallParticleScreenY[ballIndex, particleIndex-1]
			SetSpritePositionByOffset( BallParticle[ballIndex, particleIndex], BallParticleScreenX[ballIndex, particleIndex], BallParticleScreenY[ballIndex, particleIndex] )
		next particleIndex

		BallParticleScreenX[ballIndex, 0] = BallScreenX[ballIndex]
		BallParticleScreenY[ballIndex, 0] = BallScreenY[ballIndex]
		SetSpritePositionByOffset( BallParticle[ballIndex, 0], BallParticleScreenX[ballIndex, 0], BallParticleScreenY[ballIndex, 0] )

	next ballIndex
endfunction

//------------------------------------------------------------------------------------------------------------
