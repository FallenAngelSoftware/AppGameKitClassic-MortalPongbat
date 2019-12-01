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

	BallScreenX[0] = ScreenWidth/2
	BallScreenY[0] = ScreenHeight/2 + (ScreenHeight/3)
	BallMovementX[0] = -5
	BallMovementY[0] = -5
	BallStillColliding[0] = FALSE

	BallScreenX[1] = ScreenWidth/2
	BallScreenY[1] = ScreenHeight/2 - (ScreenHeight/3)
	BallMovementX[1] = 5
	BallMovementY[1] = 5
	BallStillColliding[1] = FALSE

endfunction

//------------------------------------------------------------------------------------------------------------

function SetupLevel()
	WallTotal = 0

	screenX as float
	screenX = 0 + (36/2)
	screenY as float
	screenY = ( (ScreenHeight / 2) - (18*5) + (18/2) )
	indexY as integer
	indexX as integer
	if (Level > -1) // = 0)
		for indexY = 0 to 10
			for indexX = 0 to 9
				inc WallTotal, 1
				
				WallSprite[indexX, indexY] = CreateSprite ( 11250 )
				SetSpriteOffset( WallSprite[indexX, indexY], (GetSpriteWidth(WallSprite[indexX, indexY])/2) , (GetSpriteHeight(WallSprite[indexX, indexY])/2) ) 
				SetSpritePositionByOffset( WallSprite[indexX, indexY], screenX, screenY )
				SetSpriteDepth ( WallSprite[indexX, indexY], 3 )

				if (indexY = 0 or indexY = 10)
					SetSpriteColorRed(WallSprite[indexX, indexY], 255)
					SetSpriteColorGreen(WallSprite[indexX, indexY], 0)
					SetSpriteColorBlue(WallSprite[indexX, indexY], 255)
				elseif (indexY = 1 or indexY = 9)
					SetSpriteColorRed(WallSprite[indexX, indexY], 0)
					SetSpriteColorGreen(WallSprite[indexX, indexY], 0)
					SetSpriteColorBlue(WallSprite[indexX, indexY], 255)
				elseif (indexY = 2 or indexY = 8)
					SetSpriteColorRed(WallSprite[indexX, indexY], 0)
					SetSpriteColorGreen(WallSprite[indexX, indexY], 255)
					SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
				elseif (indexY = 3 or indexY = 7)
					SetSpriteColorRed(WallSprite[indexX, indexY], 255)
					SetSpriteColorGreen(WallSprite[indexX, indexY], 255)
					SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
				elseif (indexY = 4 or indexY = 6)
					SetSpriteColorRed(WallSprite[indexX, indexY], 255)
					SetSpriteColorGreen(WallSprite[indexX, indexY], 155)
					SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
				elseif (indexY = 5)
					SetSpriteColorRed(WallSprite[indexX, indexY], 255)
					SetSpriteColorGreen(WallSprite[indexX, indexY], 0)
					SetSpriteColorBlue(WallSprite[indexX, indexY], 0)
				endif

				screenX = screenX + GetSpriteWidth(WallSprite[0, 0])
			next indexX
			
			screenX = 0 + (36/2)
			screenY = screenY + 18
		next indexY
	endif

	PaddleScreenX[0] = ScreenWidth/2
	PaddleScreenY[0] = (ScreenHeight/2) + 258
	PaddleDestinationX[0] = (Screenwidth/2)
	PaddleDestinationDir[0] = JoyCENTER

	PaddleScreenX[1] = ScreenWidth/2
	PaddleScreenY[1] = (ScreenHeight/2) - 258
	PaddleDestinationX[1] = (ScreenWidth/2)
	PaddleDestinationDir[1] = JoyCENTER

	BallScreenX[0] = ScreenWidth/2
	BallScreenY[0] = ScreenHeight/2 + (ScreenHeight/3)
	BallMovementX[0] = -5
	BallMovementY[0] = -5
	BallStillColliding[0] = FALSE

	BallScreenX[1] = ScreenWidth/2
	BallScreenY[1] = ScreenHeight/2 - (ScreenHeight/3)
	BallMovementX[1] = 5
	BallMovementY[1] = 5
	BallStillColliding[1] = FALSE
endfunction

//------------------------------------------------------------------------------------------------------------

function MoveBallWithCollisionDetection()
	index as integer
	for index = 0 to 1
		inc BallScreenX[index], BallMovementX[index]	
		inc BallScreenY[index], BallMovementY[index]
		
		if (BallScreenX[index] < 13)
			BallScreenX[index] = 13
			BallMovementX[index] = BallMovementX[index] * -1
			PlaySoundEffect(2)				
		elseif ( BallScreenX[index] > (360-13) )
			BallScreenX[index] = (360-13)
			BallMovementX[index] = BallMovementX[index] * -1
			PlaySoundEffect(2)				
		endif
		
		if (BallScreenY[index] < 30)
			BallScreenY[index] = 30
			BallMovementY[index] = BallMovementY[index] * -1
			PlaySoundEffect(2)				
		elseif ( BallScreenY[index] > (640-30) )
			BallScreenY[index] = (640-30)
			BallMovementY[index] = BallMovementY[index] * -1
			PlaySoundEffect(2)				
		endif
	next index
endfunction

//------------------------------------------------------------------------------------------------------------

function RunGameplayCore()
	index as integer
/*	if (PerformancePercent > 1)
		for index = 0 to 1
			if (BallMovementX[index] < 0)
				BallMovementX[index] = -5 * PerformancePercent
			elseif (BallMovementX[index] > 0)
				BallMovementX[index] = 5 * PerformancePercent
			endif
				
			if (BallMovementY[index] < 0)
				BallMovementY[index] = -5 * PerformancePercent
			elseif (BallMovementY[index] > 0)
				BallMovementY[index] = 5 * PerformancePercent
			endif
		next index
	endif
*/
	if (Platform <> Android and Platform <> iOS)
		if ( JoystickDirection = JoyLEFT and PaddleScreenX[0] > (40) )
			PaddleDestinationDir[0] = JoyLEFT
			dec PaddleScreenX[0], 5
			SetSpritePositionByOffset( PaddleSprite[0], PaddleScreenX[0], PaddleScreenY[0] )
		elseif ( JoystickDirection = JoyRIGHT and PaddleScreenX[0] < (360-40) )
			PaddleDestinationDir[0] = JoyRIGHT
			inc PaddleScreenX[0], 5
			SetSpritePositionByOffset( PaddleSprite[0], PaddleScreenX[0], PaddleScreenY[0] )
		else
			PaddleDestinationDir[0] = JoyCENTER
		endif
		
		if (MouseButtonLeft = ON)
			if (MouseScreenY < ScreenHeight/2)
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
		if GetMultiTouchExists()=1
			if GetRawTouchCount(1)=2
				if ( TapCurrentY[0] < (ScreenHeight/2) )
					PaddleDestinationX[1] = TapCurrentX[0]

					if (PaddleScreenX[1] > TapCurrentX[0])
						PaddleDestinationDir[1] = JoyLEFT
					elseif (PaddleScreenX[1] < TapCurrentX[0])
						PaddleDestinationDir[1] = JoyRIGHT
					else
						PaddleDestinationDir[1] = JoyCENTER
					endif
				elseif ( TapCurrentY[0] > (ScreenHeight/2) )
					PaddleDestinationX[0] = TapCurrentX[0]

					if (PaddleScreenX[0] > TapCurrentX[0])
						PaddleDestinationDir[0] = JoyLEFT
					elseif (PaddleScreenX[0] < TapCurrentX[0])
						PaddleDestinationDir[0] = JoyRIGHT
					else
						PaddleDestinationDir[0] = JoyCENTER
					endif
				endif

				if ( TapCurrentY[1] < (ScreenHeight/2) )
					PaddleDestinationX[1] = TapCurrentX[1]

					if (PaddleScreenX[1] > TapCurrentX[1])
						PaddleDestinationDir[1] = JoyLEFT
					elseif (PaddleScreenX[1] < TapCurrentX[1])
						PaddleDestinationDir[1] = JoyRIGHT
					else
						PaddleDestinationDir[1] = JoyCENTER
					endif
				elseif ( TapCurrentY[1] > (ScreenHeight/2) )
					PaddleDestinationX[0] = TapCurrentX[1]

					if (PaddleScreenX[0] > TapCurrentX[1])
						PaddleDestinationDir[0] = JoyLEFT
					elseif (PaddleScreenX[0] < TapCurrentX[1])
						PaddleDestinationDir[0] = JoyRIGHT
					else
						PaddleDestinationDir[0] = JoyCENTER
					endif
				endif
			elseif (MouseButtonLeft = ON)
				if (MouseScreenY < ScreenHeight/2)
					PaddleDestinationX[1] = MouseScreenX

					if (PaddleScreenX[1] > MouseScreenX)
						PaddleDestinationDir[1] = JoyLEFT
					elseif (PaddleScreenX[1] < MouseScreenX)
						PaddleDestinationDir[1] = JoyRIGHT
					else
						PaddleDestinationDir[1] = JoyCENTER
					endif
				elseif (MouseScreenY > ScreenHeight/2)
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
		endif	
	endif

	for index = 0 to 1
		if (Platform <> Android and Platform <> iOS) then index = 1
				
		if (PaddleDestinationDir[index] = JoyLEFT)
			dec PaddleScreenX[index], 5
			if ( PaddleScreenX[index] < (40) ) then PaddleScreenX[index] = (40)
					
			SetSpritePositionByOffset( PaddleSprite[index], PaddleScreenX[index], PaddleScreenY[index] )

			if (PaddleScreenX[index] < PaddleDestinationX[index])
				PaddleScreenX[index] = PaddleDestinationX[index]
				PaddleDestinationDir[index] = JoyCENTER
			endif
		elseif (PaddleDestinationDir[index] = JoyRIGHT)
			inc PaddleScreenX[index], 5
			if ( PaddleScreenX[index] > (360-40) ) then PaddleScreenX[index] = (360-40)

			SetSpritePositionByOffset( PaddleSprite[index], PaddleScreenX[index], PaddleScreenY[index] )

			if (PaddleScreenX[index] > PaddleDestinationX[index])
				PaddleScreenX[index] = PaddleDestinationX[index]
				PaddleDestinationDir[index] = JoyCENTER
			endif
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
						BallMovementY[ballIndex] = BallMovementY[ballIndex] * -1

						PlaySoundEffect(3)				
						
						SetSpritePositionByOffset(WallSprite[indexX, indexY], -9999, -9999)
						
						indexX = 10
						indexY = 5
						
						dec WallTotal, 1
						if (WallTotal = 0)
							NextScreenToDisplay = PlayingScreen
							ScreenFadeStatus = FadingToBlack
						endif
					endif
				endif
			next indexX
		next indexY
	next ballIndex
endfunction

//------------------------------------------------------------------------------------------------------------
