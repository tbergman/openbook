\include "src/include/common.lyi"
\header {
	title="Memory"
	subtitle=""
	composer="Andrew Lloyd Webber"
	copyright="Copyright 1981 by the Really Useful Group plc. and Faber Music Ltd."
	style="Musical"
	piece=""
	remark="Taken from Scribd url http://www.scribd.com/doc/9491593/Sheet-Music-Cats-Memory"
	poet="Trevor Nunn after T.S. Eliot"

	completion="1"
	uuid="cc3c46c7-908d-4b3e-b90f-1e01a942ef27"

}
%{
	NOTES:
		- this tune is an example of how to create different outputs for midi and
		printing. This is required here since I want the chord names to appear in the
		print but not be heard in the midi. In order situations you want to the midi
		to play the voltas correclty and so need to unfold the music but in the print
		version you want the voltas.
	TODO:
		- I don't want to see the vocal staff in the opening.
		- rests for entire bars (like in the begining) are not centered.
		- what's the deal with setting the key per voice?
%}

chordsMain=\chordmode {
	\time 12/8

	\startChords

	\startSong
	
	\startIntro

	bes1. | bes |

	\endIntro

	\startPart

	bes | g:m | ees | d:m |
	c:m | g:m | f8*9 ees8*3/f | bes1. |

	\endPart

	\endSong

	\endChords
}
voiceBass=\relative c' {
	\clef bass
	\key bes \major
	\time 12/8
	bes,8 f'8 d'8~ d8 f,8 d'8 bes,8 f'8 d'8~ d8 f,8 d'8 |
	bes,8 f'8 d'8~ d8 f,8 d'8 bes,8 f'8 d'8~ d8 f,8 d'8 |
	bes,8 f'8 d'8~ d8 f,8 d'8 bes,8 f'8 d'8~ d8 f,8 d'8 |
	g,,8 d'8 g8~ g8 d8 g8 g,8 d'8 g8~ g8 d8 g8 |
}
voiceTreble=\relative c'' {
	\clef treble
	\key bes \major
	\time 12/8
	r1. | r1. |
	bes8*3 bes~ bes8 a bes c bes g | bes8*3 bes~ bes8 a bes c bes f |
}
voiceVocal=\relative c'' {
	\clef treble
	\key bes \major
	\time 12/8
	r1. | r1. |
	\mark "GRIZABELLA"
	bes8*3 bes~ bes8 a bes c bes g | bes8*3 bes~ bes8 a bes c bes f |
}
pianoMain={
	%% This is the instrument name that will appear before the staff.
	%% it has nothing to do with the midi instrument that will be used to
	%% render this voice in midi format...
	%%\set PianoStaff.instrumentName=#Piano
	%% The instrument that will be used to render this voice in midi
	%% list of instruments can be found at
	%% http://lilypond.org/doc/v2.11/Documentation/user/lilypond/MIDI-instruments#MIDI-instruments
	\set PianoStaff.midiInstrument=#"acoustic grand"
	%% The tempo of the tune
	%% http://veltzer.net/blog/blog/2010/08/14/musical-tempo-table/
	\tempo Freely 4.=50
	<<
		%% you can move voiceB from below to the treble clef if you prefer
		%% the notation not to match the hands but rather the music...
		\new Staff=up {
			\clef treble
			<<
				\voiceTreble
			>>
		}
		\new Staff=down {
			\clef bass
			<<
				\voiceBass
			>>
		}
	>>
}
%% lyrics
myLyrics=\lyricmode {
%%	This verse not a part of the song but rather some intro before the song...
%%	Daylight
%%	See the dew on the sunflower
%%	And a rose that is fading
%%	Roses whither away
%%	Like the sunflower
%%	I yearn to turn my face to the dawn
%%	I am waiting for the day...

	Mid -- night
	Not a sound from the pave -- ment
	Has the moon lost her memory?
	She is smiling alone
	In the lamplight
	The withered leaves collect at my feet
	And the wind begins to moan

	Memory
	All alone in the moonlight
	I can smile at the old days
	I was beautiful then
	I remember the time I knew what happiness was
	Let the memory live again

	Every streetlamp
	Seems to beat a fatalistic warning
	Someone mutters
	And the streetlamp gutters
	And soon it will be morning

	Daylight
	I must wait for the sunrise
	I must think of a new life
	And I musn't give in
	When the dawn comes
	Tonight will be a memory too
	And a new day will begin

	Burnt out ends of smoky days
	The stale cold smell of morning
	The streetlamp dies, another night is over
	Another day is dawning

	Touch me
	It's so easy to leave me
	All alone with the memory
	Of my days in the sun
	If you touch me
	You'll understand what happiness is

	Look
	A new day has begun
}
%% score for printing
\score {
	<<
		\new Voice=myv \voiceVocal
		\new Lyrics \lyricsto myv \myLyrics
		\new PianoStaff=piano \pianoMain
		\new ChordNames=chords \chordsMain
	>>
	\layout {
		\context { \RemoveEmptyStaffContext }
	}
}
%% score for midi
\score {
	<<
		\new VoiceStaff=voiceVocal \voiceVocal
		\new PianoStaff=piano \pianoMain
	>>
	\midi {
	}
}
