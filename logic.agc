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

	BallScreenX = ScreenWidth/2
	BallScreenY = ScreenHeight/2
	BallMovementX = -5
	BallMovementY = -5

	BallStillColliding = FALSE

	
endfunction

//------------------------------------------------------------------------------------------------------------

function MoveBallWithCollisionDetection()
	inc BallScreenX, BallMovementX	
	inc BallScreenY, BallMovementY
	
	if (BallScreenX < 13)
		BallMovementX = BallMovementX * -1
	elseif ( BallScreenX > (360-13) )
		BallMovementX = BallMovementX * -1
	endif
	
	if (BallScreenY < 30)
		BallMovementY = BallMovementY * -1
	elseif ( BallScreenY > (640-30) )
		BallMovementY = BallMovementY * -1
	endif
endfunction

//------------------------------------------------------------------------------------------------------------

function RunGameplayCore()
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

	index as integer
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
	
	SetSpritePositionByOffset( BallSprite, BallScreenX, BallScreenY )

	if (BallStillColliding = TRUE)
		MoveBallWithCollisionDetection ( )
		
		SetSpritePositionByOffset( BallSprite, BallScreenX, BallScreenY )
		
		if ( BallScreenY > (ScreenHeight/2) and GetSpriteCollision(BallSprite, PaddleSprite[0]) <> 1 ) then BallStillColliding = FALSE
		if ( BallScreenY < (ScreenHeight/2) and GetSpriteCollision(BallSprite, PaddleSprite[1]) <> 1 ) then BallStillColliding = FALSE
	elseif (BallStillColliding = FALSE)
		for index = 0 to 1
			If ( BallStillColliding = FALSE and GetSpriteCollision(BallSprite, PaddleSprite[index]) = 1 )
				if (BallMovementX < 0)
					BallMoveMentX = BallMovementX * -1
				else
					BallMoveMentX = BallMovementX * -1
				endif
				
				if (BallMovementY < 0)
					BallMovementY = BallMovementY * -1
				else
					BallMovementY = BallMovementY * -1
				endif
				
				if ( BallScreenY > (ScreenHeight/2) )
					if (PaddleDestinationDir[0] = JoyLEFT)
						dec BallMovementX, 1
					elseif (PaddleDestinationDir[0] = JoyRIGHT)
						inc BallMovementX, 1
					endif
				elseif ( BallScreenY < (ScreenHeight/2) )
					if (PaddleDestinationDir[1] = JoyLEFT)
						dec BallMovementX, 1
					elseif (PaddleDestinationDir[1] = JoyRIGHT)
						inc BallMovementX, 1
					endif
				endif
				
				BallStillColliding = TRUE
			endif
		next index
	endif
endfunction

//------------------------------------------------------------------------------------------------------------
