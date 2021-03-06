// "input.agc"...

function GetAllUserInput ( )
	if (ScreenToDisplay <> PlayingScreen or GamePaused = TRUE)
		MouseButtonLeft = OFF
	endif

	MouseButtonRight = OFF
	LastKeyboardChar = -1
	ShiftKeyPressed = FALSE
	JoystickDirection = JoyCENTER
	JoystickButtonOne = OFF
	JoystickButtonTwo = OFF
	
	if (DelayAllUserInput > 0)
		dec DelayAllUserInput, 1
		exitfunction
	endif

	if GetRawKeyState(16) = 1 then ShiftKeyPressed = TRUE

	if (OnMobile = FALSE)
		MouseScreenX = GetRawMouseX()
		MouseScreenY = GetRawMouseY()

		if ( GetRawMouseLeftState() )
			if (MouseButtonLeftReleased = TRUE)
				MouseButtonLeft = ON
				MouseButtonLeftJustClicked = 0
				MouseButtonLeftReleased = FALSE
			endif
		else
			MouseButtonLeftReleased = TRUE
		endif

		if ( GetRawMouseRightState() )
			if (MouseButtonRightReleased = TRUE)
				MouseButtonRight = ON
				MouseButtonRightJustClicked = 0
				MouseButtonRightReleased = FALSE
			endif
		else
			MouseButtonRightReleased = TRUE
		endif
	else
		MouseScreenX = GetPointerX()
		MouseScreenY = GetPointerY()

		if ( GetPointerState() = 1 )
			MouseButtonLeft = ON
			MouseButtonLeftJustClicked = 0
		else
			MouseButtonLeft = OFF
		endif
	endif

	if (MouseButtonLeft = OFF and MouseButtonLeftJustClicked = 0)
		MouseButtonLeftJustClicked = 1
	elseif (MouseButtonLeft = OFF and MouseButtonLeftJustClicked = 1)
		MouseButtonLeftJustClicked = -1
	endif

	index as integer
	for index = 1 to 255
		if GetRawKeyState(index) = 1
			LastKeyboardChar = index
		endif
	next index

	select LastKeyboardChar
		case 32:
			if (ScreenToDisplay = PlayingScreen)
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
				elseif (GamePaused = TRUE)
					GamePaused = FALSE
					SetSpritePositionByOffset( BoardBG, -9999, -9999 )
					SetSpriteColorAlpha(BoardBG, 200)
					SetTextStringOutlined ( PausedText[0], " " )
					SetTextStringOutlined ( PausedText[1], " " )
					MouseButtonLeft = OFF
					DelayAllUserInput = 50
					PlaySoundEffect(2)
					if CurrentlyPlayingMusicIndex > -1 then ResumeMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
				endif
			endif
		endcase
		case 38:
			JoystickDirection = JoyUP
		endcase
		case 39:
			JoystickDirection = JoyRIGHT
		endcase
		case 40:
			JoystickDirection = JoyDOWN
		endcase
		case 37:
			JoystickDirection = JoyLEFT
		endcase
	endselect
	
	if ( GetRawKeyPressed(90) )
		if (JoyButtonOneReleased = TRUE)
			JoystickButtonOne = ON
			JoyButtonOneReleased = FALSE
		endif
	else
		JoyButtonOneReleased = TRUE
	endif

	if ( GetRawKeyPressed(88) )
		if (JoyButtonTwoReleased = TRUE)
			JoystickButtonTwo = ON
			JoyButtonTwoReleased = FALSE
		endif
	else
		JoyButtonTwoReleased = TRUE
	endif
	
	JoyButtonOneReleased = TRUE
	JoyButtonTwoReleased = TRUE
	
	if LastKeyboardChar = 27
		SetDelayAllUserInput()
		PlayNewMusic(0, 1)
		QuitPlaying = TRUE
		GameIsPlaying = FALSE
		NextScreenToDisplay = TitleScreen
		ScreenFadeStatus = FadingToBlack
	endif
	
    if GetMultiTouchExists()=1
        if GetRawTouchCount(1)=2
            Tap[0] = GetRawFirstTouchEvent(1)
            TapStartX[0] = GetRawTouchStartX(Tap[0])
            TapStartY[0] = GetRawTouchStarty(Tap[0])
            TapCurrentX[0] = GetRawTouchCurrentX(Tap[0])
            TapCurrentY[0] = GetRawTouchCurrenty(Tap[0])
             
            Tap[1] = GetRawNextTouchEvent()
            TapStartX[1] = GetRawTouchStartX(Tap[1])
            TapStartY[1] = GetRawTouchStarty(Tap[1])
            TapCurrentX[1] = GetRawTouchCurrentX(Tap[1])
            TapCurrentY[1] = GetRawTouchCurrenty(Tap[1])
        endif
    endif
endfunction
