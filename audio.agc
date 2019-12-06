// "audio.agc"...

function LoadAllSoundEffects ( )
	SoundEffect[ 0] = LoadSoundOGG("\media\sound\MenuMove.ogg")
	SoundEffect[ 1] = LoadSoundOGG("\media\sound\MenuClick.ogg")
	
	SoundEffect[ 2] = LoadSoundOGG("\media\sound\BallHitOne.ogg")
	SoundEffect[ 3] = LoadSoundOGG("\media\sound\BallHitTwo.ogg")
	
endfunction

//------------------------------------------------------------------------------------------------------------

function LoadAllMusic ( )
	MusicTrack[ 0] = LoadMusicOGG( "\media\music\TitleBGM.ogg" )

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
