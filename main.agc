// "main.agc"...

remstart
---------------------------------------------------------------------------------------------------
                                           JeZxLee's
                                                              TM
                                AppGameKit "NightRider" Engine
                                        (Version 2.0.0)
           _  _   __  ____  ____  __   __      ____   __   __ _   ___  ____   __  ____ TM
          ( \/ ) /  \(  _ \(_  _)/ _\ (  )    (  _ \ /  \ (  ( \ / __)(  _ \ / _\(_  _)
          / \/ \( () ))   /  )( /    \/ (_/\   ) __/( () )/    /( (_ \ ) _ (/    \ )(  
          \_)(_/ \__/(__\_) (__)\_/\_/\____/  (__)   \__/ \_)__) \___/(____/\_/\_/(__) 

                                     Retail1 110% - v0.0.31         TURBO!

---------------------------------------------------------------------------------------------------     

           Google Android SmartPhones/Tablets & HTML5 Desktop/Notebook Internet Browsers

---------------------------------------------------------------------------------------------------                       

                     (C)opyright 2020, By Team "www.FallenAngelSoftware.com"

---------------------------------------------------------------------------------------------------
remend

#include "audio.agc"
#include "data.agc"
#include "input.agc"
#include "interface.agc"
#include "logic.agc"
#include "screens.agc"
#include "visuals.agc"

global GameVersion as string
GameVersion = "''Retail1 110% - Turbo! - v0.0.30''"
global DataVersion as string
DataVersion = "MP110-Retail1-110-Turbo-v0_0_30.cfg"
global HTML5DataVersion as String
HTML5DataVersion = "MP-v0_0_30-"

global MaximumFrameRate as integer
MaximumFrameRate = 0

global PerformancePercent as float

#option_explicit
SetErrorMode(2)

global ScreenWidth = 360
global ScreenHeight = 640
global ExitGame as integer
ExitGame = 0

SetWindowTitle( "Mortal Pongbat 110%[TM]" )
SetWindowSize( ScreenWidth, ScreenHeight, 0 )
SetWindowAllowResize( 1 )

SetScreenResolution( ScreenWidth, ScreenHeight ) 
SetVirtualResolution( ScreenWidth, ScreenHeight )
SetOrientationAllowed( 1, 0, 0, 0 )

#constant FALSE		0
#constant TRUE		1

global DEBUG = FALSE

#constant Web		0
#constant Android	1
#constant iOS		2
#constant Windows	3
#constant Linux		4
global Platform as integer

global OnMobile as integer
global ShowCursor as integer
if ( GetDeviceBaseName() = "android" or GetDeviceBaseName() = "ios" )
	if ( GetDeviceBaseName() = "android" )
		Platform = Android
	elseif ( GetDeviceBaseName() = "ios" )
		Platform = iOS
	endif

	SetSyncRate( 60, 0 )
	SetScissor( 0,0,0,0 )
	OnMobile = TRUE
	ShowCursor = FALSE
else
	Platform = Web
	if (MaximumFrameRate = 0)
		SetVSync( 1 )
	else
		SetSyncRate( 0, 1 )
	endif
	SetScissor( 0, 1, ScreenWidth, ScreenHeight )
	OnMobile = FALSE
	ShowCursor = TRUE
endif

if (GetDeviceBaseName() = "windows")
	Platform = Windows
elseif (GetDeviceBaseName() = "linux")
	Platform = Linux
endif

global GameUnlocked as integer
GameUnlocked = 2

global LoadPercent as float
global LoadPercentFixed as integer

// Uncomment below three lines to test Android version on desktop																			
// Platform = Android
// OnMobile = TRUE
// ShowCursor = FALSE

global PlayingSyncRate as integer
PlayingSyncRate = 30

SetClearColor( 0, 0, 0 ) 
ClearScreen()

global FingerPlayfieldX as integer
global FingerPlayfieldY as integer

global GameIsPlaying as integer
GameIsPlaying = FALSE

global GameOverTimer as integer

global GameOverSprite as integer

global PlayfieldIsDirty as integer

global WonGame as integer
WonGame = FALSE

global MouseScreenX = 0
global MouseScreenY = 0
#constant OFF						0
#constant ON						1
global MouseButtonLeft = OFF
global MouseButtonLeftJustClicked as integer
global MouseButtonLeftReleased as integer
MouseButtonLeftReleased = TRUE
global MouseButtonRight = OFF
global MouseButtonRightJustClicked as integer
global MouseButtonRightReleased as integer
MouseButtonRightReleased = TRUE

global ShiftKeyPressed as integer
ShiftKeyPressed = FALSE

#constant JoyCENTER			0
#constant JoyUP				1
#constant JoyRIGHT			2
#constant JoyDOWN     		3
#constant JoyLEFT			4
global JoystickDirection as integer
JoystickDirection = JoyCENTER

global JoystickButtonOne as integer
JoystickButtonOne = OFF
global JoyButtonOneReleased as integer
JoyButtonOneReleased = TRUE
global JoystickButtonTwo as integer
JoystickButtonTwo = OFF
global JoyButtonTwoReleased as integer
JoyButtonTwoReleased = TRUE

global KeyboardControls as integer

global LastKeyboardChar = -1

global DelayAllUserInput as integer
DelayAllUserInput = 0

#constant FadingIdle				-1
#constant FadingFromBlack			0
#constant FadingToBlack				1
global ScreenFadeStatus as integer
ScreenFadeStatus = FadingFromBlack
global ScreenFadeTransparency as integer
ScreenFadeTransparency = 255

global BlackBG as integer
global FadingBlackBG as integer
LoadImage ( 1, "\media\images\backgrounds\FadingBlackBG.png" )
FadingBlackBG = CreateSprite ( 1 )
SetSpriteDepth ( FadingBlackBG, 1 )
SetSpriteOffset( FadingBlackBG, (GetSpriteWidth(FadingBlackBG)/2) , (GetSpriteHeight(FadingBlackBG)/2) ) 
SetSpritePositionByOffset( FadingBlackBG, ScreenWidth/2, ScreenHeight/2 )
SetSpriteTransparency( FadingBlackBG, 1 )
global FadingToBlackCompleted as integer
FadingToBlackCompleted = FALSE

UseNewDefaultFonts( 1 )
LoadFont( 999, "\media\fonts\yorkbailehill.ttf" )
global CurrentMinTextIndex = 1

global AppGameKitLogo as integer

global TitleBG as integer

global SixteenBitSoftLogo as integer

global MP110Logo as integer
global MP110LogoBG as integer
global MP110LogoFlash as integer

global LogoFlashScreenX as float

global NewNameText as integer
global NewHighScoreCurrentName as String
NewHighScoreCurrentName = " "
global NewHighScoreNameIndex as integer
NewHighScoreNameIndex = 1

global PauseGame as integer
PauseGame = FALSE

#constant SteamOverlayScreen						0
#constant AppGameKitScreen							1
#constant SixteenBitSoftScreen						2
#constant TitleScreen								3
#constant OptionsScreen								4
#constant HowToPlayScreen							5
#constant HighScoresScreen							6
#constant AboutScreen								7
#constant IntroSceneScreen							8
#constant PlayingScreen								9
#constant EndingSceneScreen							10
#constant NewHighScoreNameInputScreen				11
#constant NewHighScoreNameInputAndroidScreen		12
#constant MusicPlayerScreen							13
global ScreenToDisplay = 3
global NextScreenToDisplay = 4
global ScreenDisplayTimer as integer

if (Platform <> Windows)
	ScreenToDisplay = 3
	NextScreenToDisplay = 4
endif
	
global MusicPlayerScreenIndex as integer
MusicPlayerScreenIndex = 0

global LeftArrow
LoadImage ( 100, "\media\images\gui\ButtonSelectorLeft.png" )
global RightArrow
LoadImage ( 101, "\media\images\gui\ButtonSelectorRight.png" )

LoadImage ( 103, "\media\images\gui\Button.png" )
global ButtonText as string[8]
ButtonText[0] = "START!"
ButtonText[1] = "Options"
ButtonText[2] = "How To Play"
ButtonText[3] = "High Scores"
ButtonText[4] = "About"
ButtonText[5] = "Exit"
ButtonText[6] = "Back"
ButtonText[7] = "Clear Scores"

global ButtonSprite as integer[8]
for index = 0 to 7
	ButtonSprite[index] = 680+index
next index

global ButtonIndex as integer[8]
global ButtonScreenX as integer[8]
global ButtonScreenY as integer[8]
global ButtonAnimationTimer as integer[8]
global ButtonScale as float[8]
global NumberOfButtonsOnScreen = 0
global ButtonSelectedByKeyboard = 0
index as integer
for index = 0 to 7
    ButtonIndex[index] = -1
    ButtonScreenX[index] = (ScreenWidth/2)
    ButtonScreenY[index] = (ScreenHeight/2)
    ButtonAnimationTimer[index] = 0
    ButtonScale[index] = 1
next index

LoadImage ( 120, "\media\images\gui\ButtonSelectorRight.png" )
LoadImage ( 121, "\media\images\gui\ButtonSelectorLeft.png" )
global LeftArrowSet as integer[10]
global RightArrowSet as integer[10]

LoadImage ( 122, "\media\images\gui\SelectorLine.png" )
global SelectorLine as integer

LoadImage ( 130, "\media\images\gui\NameInputButton.png" )

LoadImage ( 131, "\media\images\gui\NameInputChar.png" )
global NameInputCharSprite as integer
global NameInputCharSpriteChar as integer
global MouseButtonLeftWasReleased as integer

global NumberOfArrowSetsOnScreen as integer = 0
global ArrowSetSelectedByKeyboard as integer = 0
global ArrowSetScreenY as integer[10]
global ArrowSetLeftAnimationTimer as integer[10]
global ArrowSetRightAnimationTimer as integer[10]
global ArrowSetLeftScale as float[10]
global ArrowSetRightScale as float[10]
global ArrowSetTextStringIndex as integer[10]
for index = 0 to 9
    ArrowSetScreenY[index] = (ScreenHeight/2)
    ArrowSetLeftAnimationTimer[index] = 0
    ArrowSetRightAnimationTimer[index] = 0
    ArrowSetLeftScale[index] = 1
    ArrowSetRightScale[index] = 1
    ArrowSetTextStringIndex[index] = -1
next index

LoadImage ( 140, "\media\images\gui\ScreenLine.png" )
global ScreenLine as integer[10]

global Icon as integer[100]
LoadImage ( 300, "\media\images\gui\SpeakerOFF.png" )
LoadImage ( 301, "\media\images\gui\SpeakerON.png" )
LoadImage ( 302, "\media\images\logos\GooglePlayLogo.png" )
LoadImage ( 303, "\media\images\logos\ReviewGooglePlayLogo.png" )
LoadImage ( 304, "\media\images\gui\Exit.png" )
LoadImage ( 305, "\media\images\gui\Pause.png" )
LoadImage ( 306, "\media\images\gui\Play.png" )

global IconIndex as integer[100]
global IconSprite as integer[100]
global IconScreenX as integer[100]
global IconScreenY as integer[100]
global IconAnimationTimer as integer[100]
global IconScale as float[100]
global IconText as string[100]
global NumberOfIconsOnScreen as integer
NumberOfIconsOnScreen = 0
for index = 0 to 99
	IconIndex[index] = -1
    IconSprite[index] = -1
    IconScreenX[index] = (ScreenWidth/2)
    IconScreenY[index] = (ScreenHeight/2)
    IconAnimationTimer[index] = 0
    IconScale[index] = 1
    IconText[index] = " "
next index

LoadInterfaceSprites()
PreRenderButtonsWithTexts()

global CurrentlyPlayingMusicIndex = -1
#constant MusicTotal						10
global MusicTrack as integer[MusicTotal]
LoadAllMusic()

#constant EffectsTotal						6
global SoundEffect as integer[EffectsTotal]
LoadAllSoundEffects()

global MusicSoundtrack	as integer
MusicSoundtrack = 0

#constant ChildStoryMode				0
#constant TeenStoryMode					1
#constant AdultStoryMode				2
#constant ChildTwoPlayerMode			3
#constant TeenTwoPlayerMode				4
#constant AdultTwoPlayerMode			5
global GameMode = AdultStoryMode

global MusicVolume as integer
MusicVolume = 100
global EffectsVolume as integer
EffectsVolume = 100

global SecretCode as integer[4]
SecretCode[0] = 0
SecretCode[1] = 0
SecretCode[2] = 0
SecretCode[3] = 0
global SecretCodeCombined as integer
SecretCodeCombined = ( (SecretCode[0]*1000) + (SecretCode[1]*100) + (SecretCode[2]*10) + (SecretCode[3]) )
global HowToPlayLegend as integer
global HowToPlayFingerTouch as integer[4]

//==========================================
global BoardBG as integer

global PaddleSprite as integer[2]
global PaddleScreenX as float[2]
global PaddleScreenY as float[2]
global PaddleDestinationX as float[2]
global PaddleDestinationDir as float[2]

global BallSprite as integer[2]
global BallScreenX as float[2]
global BallScreenY as float[2]
global BallMovementX as float[2]
global BallXmove as float[2]
global BallMovementY as float[2]

global BallStillColliding as integer[2]

global WallSprite as integer[10, 11]
global WallSpriteBackup as integer[10, 11]
global WallTotal as integer

global BallOffsetYArray as float[6]
BallOffsetYArray[0] = 2
BallOffsetYArray[1] = 6
BallOffsetYArray[2] = 4
BallOffsetYArray[3] = 2
BallOffsetYArray[4] = 6
BallOffsetYArray[5] = 4

global BallOffsetY as float

global BallParticle as integer[2, 5]
global BallParticleScreenX as float[2, 5]
global BallParticleScreenY as float[2, 5]
global BallParticleIndex as integer[2]

global FrameSkipWhenPlaying as float
FrameSkipWhenPlaying = 0

global PausedText as integer[2]
global GameOverText as integer[2]

global PlayerLostLife as integer[2]
global Lives as integer[2]

global PlayerWithHighestScore as integer
//==========================================

global PlayerLostALife as integer
PlayerLostALife = FALSE

global GameOver as integer
GameOver = 0

global PlayerRankOnGameOver as integer
PlayerRankOnGameOver = 999

mode as integer
global HighScoreName as string[6, 10]
global HighScoreLevel as integer[6, 10]
global HighScoreScore as integer[6, 10]

global LevelSkip as integer[6]
LevelSkip[0] = 0
LevelSkip[1] = 0
LevelSkip[2] = 0
LevelSkip[3] = 0
LevelSkip[4] = 0
LevelSkip[5] = 0
global StartingLevel as integer
StartingLevel = 0

ClearHighScores()

global AboutTexts as string[99999]
global AboutTextsScreenY as integer[99999]
global AboutTextsBlue as integer[99999]
global AboutTextVisable as integer[99999]
for index = 0 to 99998
	AboutTexts[index] = "Should Not See"
	AboutTextsScreenY[index] = 99999
	AboutTextsBlue[index] = 255
	AboutTextVisable[index] = 0
next index

global ATindex = 0

global NumberOfAboutScreenTexts
NumberOfAboutScreenTexts = ATindex
global StartIndexOfAboutScreenTexts
StartIndexOfAboutScreenTexts = 0

global AboutScreenOffsetY as float
global AboutScreenBackgroundY as float
global AboutScreenFPSY as float
AboutScreenFPSY = -200

global AboutScreenTextFrameSkip as integer

LoadAboutScreenTexts()

global ChangingBackground as integer
ChangingBackground = FALSE
global GameSpeed as integer
GameSpeed = 30

global Score as integer[2]
global ScoreText as integer[2]
global Level as integer
global LevelText as integer
global LevelTextTwo as integer

global GamePausedBG as integer
global GamePaused as integer

global BonusSprite as integer
global PlayfieldLow as integer

global FrameCount as integer
FrameCount = 0
global SecondsSinceStart as integer
SecondsSinceStart = 0

global QuitPlaying as integer
QuitPlaying = FALSE

global GUIchanged as integer
GUIchanged = TRUE

global roundedFPS as float

SetPrintColor ( 255, 255, 255 )
SetPrintSize(17)

global PrintColor as integer
PrintColor = 255
global PrintColorDir as integer
PrintColorDir = 0

global FPSChangeDelay as integer

global FramesPerSecond as integer
FramesPerSecond = 30

LoadOptionsAndHighScores()
SetVolumeOfAllMusicAndSoundEffects()

if (Platform = Web)
	major as integer
	minor as integer
	for major = 0 to 99
		for minor = 0 to 99
			DeleteSharedVariable( "MP-v0_"+str(major)+"_"+str(minor)+ "-" ) 
		next minor
	next major
endif

SaveOptionsAndHighScores()

if (DEBUG = TRUE)
	SecretCode[0] = 2
	SecretCode[1] = 7
	SecretCode[2] = 7
	SecretCode[3] = 7
endif

SecretCodeCombined = ( (SecretCode[0]*1000) + (SecretCode[1]*100) + (SecretCode[2]*10) + (SecretCode[3]) )

global ScreenIsDirty as integer
ScreenIsDirty = TRUE

global LoadPercentText as integer

global GameQuit as integer

PlayNewMusic(0, 1)

global CurrentIconBeingPressed as integer
CurrentIconBeingPressed = -1
global CurrentKeyboardKeyPressed as integer
CurrentKeyboardKeyPressed = -1

global Tap as integer[2]
global TapStartX as integer[2]
global TapStartY as integer[2]
global TapCurrentX as integer[2]
global TapCurrentY as integer[2]

global multiplier as float

do
	inc FrameCount, 1
		
	GetAllUserInput()
	
	select ScreenToDisplay
		case SteamOverlayScreen:
			DisplaySteamOverlayScreen()
		endcase

		case AppGameKitScreen:
			DisplayAppGameKitScreen()
		endcase

		case SixteenBitSoftScreen:
			DisplaySixteenBitSoftScreen()
		endcase

		case TitleScreen:
			DisplayTitleScreen()
		endcase

		case OptionsScreen:
			DisplayOptionsScreen()
		endcase

		case HowToPlayScreen:
			DisplayHowToPlayScreen()
		endcase

		case HighScoresScreen:
			DisplayHighScoresScreen()
		endcase

		case AboutScreen:
			DisplayAboutScreen()
		endcase

		case PlayingScreen:
			DisplayPlayingScreen()
		endcase

		case NewHighScoreNameInputScreen:
			DisplayNewHighScoreNameInputScreen()
		endcase

		case NewHighScoreNameInputAndroidScreen:
			DisplayNewHighScoreNameInputAndroidScreen()
		endcase

		case MusicPlayerScreen:
			DisplayMusicPlayerScreen()
		endcase
	endselect

	if (GUIchanged = TRUE or ScreenToDisplay = NewHighScoreNameInputAndroidScreen)
		if NumberOfButtonsOnScreen > 0 then DrawAllButtons()
		if NumberOfIconsOnScreen > 0 then DrawAllIcons()
	
		ScreenIsDirty = TRUE
		GUIchanged = FALSE
	endif

	if ScreenFadeStatus <> FadingIdle
		ScreenIsDirty = TRUE
		ApplyScreenFadeTransition()
	endif

	roundedFPS = Round( ScreenFPS() )

	if (roundedFPS > 0)
		PerformancePercent = (60 / roundedFPS)
	else
		PerformancePercent = 1
	endif

	if (PerformancePercent < 1) then PerformancePercent = 1

	if (FrameCount > roundedFPS)
		FrameCount = 0
		inc SecondsSinceStart, 1
	endif

	if (FrameCount = 1)
		FrameSkipWhenPlaying = PerformancePercent
		FrameSkipWhenPlaying = Round(FrameSkipWhenPlaying)
	endif

	if (SecretCodeCombined = 2777 and ScreenIsDirty = TRUE)
		if (ScreenFadeStatus = FadingIdle)
			if (ScreenToDisplay = AboutScreen)
				SetSpritePositionByOffset( FadingBlackBG,  -80, AboutScreenFPSY )
			else
				SetSpritePositionByOffset( FadingBlackBG,  -80, -200 )
			endif			
			SetSpriteColorAlpha( FadingBlackBG, 200 )
		else
			SetSpritePositionByOffset( FadingBlackBG,  ScreenWidth/2, ScreenHeight/2 )
		endif

		if (PrintColorDir = 0)
			if (PrintColor > 0)
				dec PrintColor, 51
			else
				PrintColor = 0
				PrintColorDir = 1
			endif
		elseif (PrintColorDir = 1)
			if (PrintColor < 255)
				inc PrintColor, 51
			else
				PrintColor = 255
				PrintColorDir = 0
			endif
		endif
		
		SetPrintColor (PrintColor, PrintColor, PrintColor)
		
		if (ScreenToDisplay <> PlayingScreen)
			DisplayDebugInfo()
		elseif ( mod(FrameCount, FrameSkipWhenPlaying) = 0 )
			DisplayDebugInfo()
		endif
	endif

	if (ScreenIsDirty = TRUE)
		if (ScreenToDisplay <> PlayingScreen)
			Sync()
		else
			if ( mod(FrameCount, FrameSkipWhenPlaying) = 0 )
				Sync()
			else
				Update(0)
			endif
		endif
		ScreenIsDirty = TRUE
	endif

	if ExitGame = 1
		exit
	endif
loop
rem                                      [TM]
rem "A 110% By Team Fallen Angel Software!"
