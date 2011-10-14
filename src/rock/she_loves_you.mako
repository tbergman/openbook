<%inherit file="/src/include/common.makoi"/>
\header {
	default_header

	title="She Loves You"
	composer="John Lennon & Paul McCartney"
	poet="John Lennon & Paul McCartney"
	style="Rock"
	piece="Moderato"

	structure="ABABAB"

	completion="0"
	uuid="32a5cb0e-431f-11e0-b9fa-0019d11e5a41"
}
jazzTune

<%doc>
	TODO:
	- make the headers for this song comply with the jazz headers.
	- add performances from youtube.
	- add lyrics and melody.
</%doc>

%% this is taken from "The Beatles Complete" book page 175
myChords=\chordmode {
	\startChords

	\startSong

	\partial 8 r8 |
	\repeat volta 3 {
		\mark "A"
		\startPart
		f1 | d:m | a:m | c:7 | \myEndLine
		f | d:m | a:m | c:7 | \myEndLine
		f | f | d:m | d:m | \myEndLine
		bes:m6 | bes:m6 | c:7 | c:7 | \myEndLine
		\endPart
		\mark "B"
		\startPart
		d:m | d:m | g:7 | g:7 | \myEndLine
		bes:m6 | c2:7.5+ c:7 | f1 | f | \myEndLine
		\endPart
	}

	\endSong

	\endChords
}

%% this is taken from "The Beatles Complete" book page 175
myVoice=\relative c {
	\time 4/4
	\key f \major
	%% http://veltzer.net/blog/blog/2010/08/14/musical-tempo-table/
	\tempo "Moderato" 4 = 112

	\partial 8 c'8-2 |
	f4-1 g a bes8 <f a>~ | <f a>2. a8-3 a | << { c4-5 a a4. g8 } \\ { e1-1 } >> | <e a>8 c' <e, a>2 r8 c' |
	f,4-1 g a bes8 <f a>~ | <f a>2. a8 a | << { c4 a a4. g8 } \\ { e1 } >> | <e a>8 c' <e, a>4 r8 c'-2 c c |
	d4-3 f2 f,8-3 g |

}

%% this is taken from "The Beatles Complete" book page 175
myLyrics=\lyricmode {
	You think you've lost your love, __
	Well, I saw her yesterday.
	It's you she's thinking of
	And she told me what to say.

	She loves you, yeah, yeah, yeah
	She loves you, yeah, yeah, yeah
	She loves you, yeah, yeah, yeah, yeah

	She says she loves you
	And you know that can't be bad.
	Yes, she loves you
	And you know you should be glad.

	She said you hurt her so
	She almost lost her mind.
	But now she said she knows
	You're not the hurting kind.

	She says she loves you
	And you know that can't be bad.
	Yes, she loves you
	And you know you should be glad. Ooh!

	She loves you, yeah, yeah, yeah
	She loves you, yeah, yeah, yeah
	And with a love like that
	You know you should be glad.

	You know it's up to you,
	I think it's only fair,
	Pride can hurt you, too,
	Apologize to her

	Because she loves you
	And you know that can't be bad.
	Yes, she loves you
	And you know you should be glad. Ooh!

	She loves you, yeah, yeah, yeah
	She loves you, yeah, yeah, yeah

	with a love like that
	You know you should
	Be Glad!

	with a love like that
	You know you should
	Be Glad!

	With a love like that
	You know you should
	be glad!

	Yeah, yeah, yeah.
	Yeah, yeah, yeah Ye-ah.
}

include(src/include/harmony_tune_lyrics.lyi)
