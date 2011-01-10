\include "src/include/common.lyi"
\header {
	title="They All Laughed"
	subtitle=""
	composer="George Gershwin"
	style="Jazz"
	piece="Medium Swing"
	remark="copied from the ultimate fake book"
	poet="Ira Gershwin"
	copyright="1937, Gershwin Publishing Corporation"
	%% Copyright Renewed, Assigned to Chappell & Co, Inc.
	structure="AA'BA''"

	completion="4"
	uuid="fd79d974-e230-42f5-8067-709d6a97e2d6"
	lyricsurl="http://www.sing365.com/music/lyric.nsf/They-All-Laughed-lyrics-Ella-Fitzgerald/2123DA2C32C02AF848256AAB000AB847"

}
%{
	TODO:
%}

myChords=\chordmode {
	\startChords

	\startSong

	\mark "A"
	\startPart
	g2 e:m | a:m7 d:7 | a:m7 d:7.9- | g4 bes:7 a:7 d:7 | \myEndLine
	g2 e:m | a:m7 d:7 | g:6 e:m7 | a:m7 d:7 | \myEndLine
	\endPart

	\mark "A'"
	g2 e:m | a:m7 d:7 | cis:7.9- fis:7.9- | b:m7 e:7 | \myEndLine
	d1:6 | a:7 | d:7 | d:7 | \myEndLine

	\mark "B"
	\startPart
	g:7 | g:7 | g2.:7 b4:7 | e1:7.5+ | \myEndLine
	a1:7 | a:7 | a:m7 | ees2:7 d2:7 | \myEndLine
	\endPart

	\mark "A''"
	\startPart
	g2 e:m | a:m7 d:7 | b:7 e:7 | a1:7 | \myEndLine
	g2 e:7 | a:m7 d:7 | g e:7.9+ | a:7.9- d:7.9- | \myEndLine
	\endPart

	\endSong
}

myVoice=\relative c' {
	%% http://en.wikipedia.org/wiki/Tempo
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key g \major

	% Bar 1
	r8 d e4 g a | b8 b a g a b4. | b8 b a g a b4 d,8 ~ | d1 |
	r8 d e4 g a | b8 b a g a b4 g8 ~ | g1 ~ | g2. r4 |

	% Bar 9
	r8 d e4 g a | b8 b a g a b4. | b8 b a g a b4 d,8 ~ | d1 |
	r8 d e4 g a | b8 b a g a b4 g8 ~ | g1 | g2. r4 |

	% Bar 17

}
myLyrics=\lyricmode {
	They all laughed at Chris -- to -- pher Co -- lum -- bus
	When he said the world was round.
	They all laughed when Ed -- i -- son re -- cor -- ded sound.

	They all laughed at Wil -- bur and his bro -- ther,
	When they said that man could fly.
	They told Mar -- co -- ni wire -- less was a pho -- ny;
	It's the same old cry.

	They laughed at me wanting you
	Said I was reaching for the moon
	But oh, you came through
	Now they'll have to change their tune

	They all said we never could be happy
	They laughed at us and how!
	But ho, ho, ho!
	Who's got the last laugh now?

	They all laughed at Rockefeller Center
	Now they're fighting to get in
	They all laughed at Whitney and his cotton gin
	They all laughed at Fulton and his steamboat
	Hershey and his chocolate bar

	Ford and his Lizzie
	Kept the laughers busy
	That's how people are
	They laughed at me wanting you
	Said it would be, "Hello, Goodbye."
	And oh, you came through
	Now they're eating humble pie

	They all said we'd never get together
	Darling, let's take a bow
	For ho, ho, ho!
	Who's got the last laugh?
	Hee, hee, hee!
	Let's at the past laugh
	Ha, ha, ha!
	Who's got the last laugh now?"
}
%% score for printing
\score {
	<<
		\new ChordNames="mychords" \myChords
		\new Voice="myvoice" \myVoice
		\new Lyrics \lyricsto "myvoice" \myLyrics
	>>
	\layout {
	}
}
%% score for midi
\score {
	\unfoldRepeats
	<<
		\new ChordNames="mychords" \myChords
		\new Voice="myvoice" \myVoice
	>>
	\midi {
	}
}
