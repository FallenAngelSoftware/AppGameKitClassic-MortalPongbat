// "audio.agc"...

function LoadAllSoundEffects ( )
	SoundEffect[ 0] = LoadSoundOGG("\media\sound\MenuMove.ogg")
	SoundEffect[ 1] = LoadSoundOGG("\media\sound\MenuClick.ogg")
	
	SoundEffect[ 2] = LoadSoundOGG("\media\sound\BallHitOne.ogg")
	SoundEffect[ 3] = LoadSoundOGG("\media\sound\BallHitTwo.ogg")

	SoundEffect[ 4] = LoadSoundOGG("\media\sound\PaddleDie.ogg")
	SoundEffect[ 5] = LoadSoundOGG("\media\sound\GameOver.ogg")
	
endfunction

//------------------------------------------------------------------------------------------------------------

function LoadAllMusic ( )
	MusicTrack[ 0] = LoadMusicOGG( "\media\music\TitleBGM.ogg" )
	MusicTrack[ 1] = LoadMusicOGG( "\media\music\Playing0123BGM.ogg" )
	MusicTrack[ 2] = LoadMusicOGG( "\media\music\Playing456BGM.ogg" )
	MusicTrack[ 3] = LoadMusicOGG( "\media\music\Playing78BGM.ogg" )
	MusicTrack[ 4] = LoadMusicOGG( "\media\music\Playing9BGM.ogg" )
	MusicTrack[ 5] = LoadMusicOGG( "\media\music\Playing2PlayerBGM.ogg" )
	MusicTrack[ 6] = LoadMusicOGG( "\media\music\NewHighScoreBGM.ogg" )
	MusicTrack[ 7] = LoadMusicOGG( "\media\music\WinChildBGM.ogg" )
	MusicTrack[ 8] = LoadMusicOGG( "\media\music\WinTeenBGM.ogg" )
	MusicTrack[ 9] = LoadMusicOGG( "\media\music\WinAdultBGM.ogg" )

endfunction

//------------------------------------------------------------------------------------------------------------

function SetVolumeOfAllMusicAndSoundEffects()
	SetSoundSystemVolume(EffectsVolume) 	
	
	index as integer
	for index = 0 to (MusicTotal-1)
		SetMusicVolumeOGG( MusicTrack[index], MusicVolume )
	next index
endfunction

//------------------------------------------------------------------------------------------------------------

function PlayNewMusic ( index as integer, loopMusic as integer )
	if ( index > (MusicTotal-1) ) then exitfunction
	
	if CurrentlyPlayingMusicIndex > -1 then StopMusicOGG(MusicTrack[CurrentlyPlayingMusicIndex])
		
	PlayMusicOGG( MusicTrack[index], loopMusic )
	CurrentlyPlayingMusicIndex = index
endfunction

//------------------------------------------------------------------------------------------------------------

function PlaySoundEffect ( index as integer )
	if ( index > (EffectsTotal-1) ) then exitfunction
	
	PlaySound(SoundEffect[index])
endfunction
