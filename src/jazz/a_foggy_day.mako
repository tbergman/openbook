<%inherit file="/src/include/common.makoi"/>
<%
	attributes['jazzTune']=True
	attributes['type']="harmony_tune_lyrics"
	attributes['render']="Fake"
	attributes['title']="A Foggy Day"
	attributes['subtitle']="From 'A Damsel In Distress'"
	attributes['composer']="George Gershwin"
	attributes['style']="Jazz"
	attributes['piece']="Medium Swing"
	attributes['poet']="Ira Gershwin"
	attributes['copyright']="1937, Gershwin Publishing Corporation"
	attributes['copyrightextra']="Copyright Renewed, Assigned to Chappell & Co, Inc."
	attributes['completion']="5"
	attributes['uuid']="87da6ece-a26e-11df-95d7-0019d11e5a41"
	attributes['structure']="AB"
	attributes['idyoutuberemark']="Wynton Marsalis Quartet"
	attributes['idyoutube']="-P2xoeGoWMs"
	attributes['idyoutuberemark']="Mel Torme (one of the greatest vocal versions)"
	attributes['idyoutube']="tVCDZaApwV8"
	attributes['lyricsurl']="http://www.sing365.com/music/lyric.nsf/A-Foggy-Day-lyrics-Frank-Sinatra/0F2EB16090A785424825692000077664"
%>

<%doc>
	DONE:
	TODO:
	- fill out what's been done for this tune.
</%doc>

<%def name="myChordsReal()">
\chordmode {
	\startChords

	\startSong

	\mark "A"
	\startPart
	f1:maj7 | a2:m7.5- d:7.9- | g1:m7 | c:7 | \myEndLine
	f:6 | d:m7.5- | g:7 | g2:m7 c:7 | \myEndLine
	f1:maj7 | c2:m7 f:7 | bes1:6 | bes:m6 | \myEndLine
	f:maj7 | a2:m7 d:7 | g1:7 | g2:m7 c:7 | \myEndLine
	\endPart

	\mark "B"
	\startPart
	f1:maj7 | aes:m7 | g:m7 | c:7 | \myEndLine
	f:6 | d:m7.5- | g:7 | g2:m7 c:7 | \myEndLine
	c1:m7 | f:7 | bes:6 | ees:7 | \myEndLine
	f2:6 g:m7 | a:m7 bes:m6 | a:m7 d:m7 | g:m7 c:7 | f1:6 | g2:m7 c:7 | \myEndLine
	\endPart

	\endSong

	\endChords
}
</%def>

<%def name="myVoiceReal()">
\relative c' {
	%% http://veltzer.net/blog/blog/2010/08/14/musical-tempo-table/
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key f \major

	%% part "A"
	r4 c c c | ees2. ees4 | d d2. | a'1 |
	r4 f f f | aes2. aes4 | g2. g4 | d'1 |
	r4 e e e | c c2. | a a4 | f1 |
	r4 a a a | c c2 c4 | a2. a4 | d,1 |

	%% part "B"
	r4 c c c | ees2. ees4 | d d2. | a'1 |
	r4 f f f | aes2. aes4 | g2. g4 | d'1 |
	f2 f4 f | d2. d4 | c2 c | a a4 bes |
	c f, g bes | a f g bes | a2 f' | f, g | f1~ | f2. r4 |

}
</%def>

<%def name="myLyricsReal()">
%% this version of the lyrics is from the fake book but adjusted for the real book (the real book has no lyrics)...
\lyricmode {
	A Fog -- gy Day __ in Lon -- don town __ ha -- d me low __ and had me down. __
	I viewed the morn -- ing with a -- larm, __ the Brit -- ish Mu -- seum had lost its charm. __
	How long I wondered could this thing last? __ But_the age of mira -- cles had -- n't passed, __
	for sud -- den -- ly __ I saw you there __ and through fog -- gy Lon -- don town the sun was shin -- ing ev -- 'ry where.
}
</%def>

<%def name="myChordsFake()">
\chordmode {
	\startChords

	\startSong

	\repeat volta 2 {

	\partial 4 r4 |

	\mark "A"
	\startPart
	f1:maj7 | a2:m7.5- d:7.9- | g1:m7 | c:7 | \myEndLine
	f2. d4:m7.5- | d1:m7.5- | g:7 | g2:m7 c:7 | \myEndLine
	f1:maj7 | c2:m7 f:7 | bes1:maj7 | bes:m6 | \myEndLine
	f:maj7 | a2:m7 d:7 | g1:7.9 | g2:m7 c:7 | \myEndLine
	\endPart

	\mark "B"
	\startPart
	f1:maj7 | a2:m7.5- d:7.9- | g1:m7 | c:7 | \myEndLine
	f2. d4:m7.5- | d1:m7.5- | g:7 | g2:m7 c:7 | \myEndLine
	c1:m7 | f:7 | bes:maj7 | ees:7 | \myEndLine
	f2 g:m7 | a:m7 bes:m6 | a:m7 d:m7 | g:m7 c:7 |

	} \alternative {
		{
			f1 | g2:m7 c:7 | \myEndLine
		}
		{
			f1 | bes2:7 bes:m6 | f1:maj7 | \myEndLine
		}
	}

	\endPart

	\endSong
}
</%def>

<%def name="myVoiceFake()">
\relative c' {
	%% http://veltzer.net/blog/blog/2010/08/14/musical-tempo-table/
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key f \major

	\repeat volta 2 {

	\partial 4 c4 |

	%% part "A"
	c c2 ees4~ | ees2. ees4 | d d2 a'4~ | a1 | \myEndLine
	f2 f4 aes~ | aes2. aes4 | g2 g4 d'4~ | d1 | \myEndLine
	r4 e e e | c c2. | a2 a4 f~ | f2. f4 | \myEndLine
	a a a c~ | c c2 c4 | a2 a4 d,~ | d2. c4 | \myEndLine

	%% part "B"
	c2 c4 ees~ | ees ees2 ees4 | d2 d4 a'~ | a2 a4 a | \myEndLine
	f2 f4 aes~ | aes bes aes2 | g g4 d'~ | d2. d4 | \myEndLine
	f2 f4 d~ | d2. d4 | c2 c4 a~ | a2 a4 bes | \myEndLine
	c f, g bes | a f g bes | a2 f' | f, g |

	} \alternative {
		{
			f1 | r2 r4 c | \myEndLine
		}
		{
			f1~ | f~ | f | \myEndLine
		}
	}
}
</%def>

<%def name="myLyricsFake()">
\lyricmode {
	A Fog -- gy Day __ in Lon -- don town __ had me low __ and had me down. __
	I viewed the morn -- ing with a -- larm, __ the Brit -- ish Mu -- se -- um had lost its charm. __
	How long I won -- dered could this thing last? __ But the age of mir -- a -- cles had -- n't passed, __
	for sud -- den -- ly, __ I saw you there __ and through fog -- gy Lon -- don town the sun was shin -- ing ev -- 'ry where.
	A where. __
}
</%def>
