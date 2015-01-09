



% lets emit the definitions

% end verbatim - this comment is a hack to prevent texinfo.tex
% from choking on non-European UTF-8 subsets

% this version tag will keep me compiling only on this version of lilypond.
%=====================================================================

\version "2.18.2"

% lets define a variable to hold the formatted build date (man 3 strftime):
%date=#(strftime "%T %d-%m-%Y" (localtime (current-time)))
%lilyver=#(lilypond-version)

% setting instruments for midi generation (bah - this doesn't work...)
%=====================================================================
%\set ChordNames.midiInstrument = #"acoustic grand"
%\set Staff.midiInstrument = #"flute"
%\set PianoStaff.instrumentName = #"acoustic grand"
% do not show chords unless they change...
%\set chordChanges = ##t

% number of staffs per page (this does not work because of my breaks)
%\paper {
%	system-count = #7
%}

\paper {
%% reduce spaces between systems and the bottom (taken from the lilypond
%% documentation and found the relevant variable)
%% the result of this is that I can fit 8 single staffs in one page
%% which is ideal for Jazz (think 32 bar divided into 8 lines of 4 bars each...).
%% I should really only apply this thing for Jazz tunes but that is a TODO item.
%% default is 4\mm - 3 already causes 8 staffs to take 2 pages
	between-system-padding = 2\mm
%% default is 20\mm
%% between-system-space = 16\mm
%% ragged-last-bottom = ##f
%% ragged-bottom = ##f

%% make lilypond increase the distance of the footer from the bottom of the page
%% it seems that if you don't do something like this you're going to have
%% a real problem seeing the footer in postscript printing....
%%bottom-margin = 2.5\cm

%% from /usr/share/lilypond/2.12.3/ly/titling-init.ly
%% to stop lilypond from printing footers...
	oddFooterMarkup = \markup {}

%% prevent lilypond from printing the headers...

	scoreTitleMarkup = \markup {}
	bookTitleMarkup = \markup {}
}
\layout {
%% don't have the fist line indented
	indent = 0.0 \cm
%% don't know what this is (taken from Laurent Martelli...)
%%textheight = 1.5\cm

	\context {
		\Score
	%% change the size of the text fonts
	%%\override LyricText #'font-family = #'typewriter
		\override LyricText #'font-size = #'-2

	%% set the style of the chords to Jazz - I don't see this making any effect
		\override ChordName #'style = #'jazz
	%%\override ChordName #'word-space = #2

	%% set the chord size and font
	%%\override ChordName #'font-series = #'bold
	%%\override ChordName #'font-family = #'roman
	%%\override ChordName #'font-size = #-1

	%% don't show bar numbers (for jazz it makes it too cluttery)
		\remove "Bar_number_engraver"
	}
}
% reduce the font size (taken from the lilypond info documentation, default is 20)
#(set-global-staff-size 17.82)

% There is no need to set the paper size to a4 since it is the default.
% make lilypond use paper of size a4 (Is this the default ?!?)
%#(set-default-paper-size "a4")
%)

% chord related matters
myChordDefinitions={
	<c ees ges bes des' fes' aes'>-\markup \super {7alt}
	<c e g bes f'>-\markup \super {7sus}
	<c e g bes d f'>-\markup \super {9sus}
	<c e g f'>-\markup \super {sus}
	<c ees ges bes>-\markup { "m" \super { "7 " \flat "5" } }
	<c ees ges beses>-\markup { "dim" \super { "7" } }
	<c ees ges>-\markup { "dim" }
%%<c e g b>-\markup { "maj7" }
	<c e gis bes d'>-\markup { \super { "9 " \sharp "5" } }
	<c e g bes d' a'>-\markup \super {13}
	<c e g bes d' fis'>-\markup { \super { "9 " \sharp "11" } }
}
myChordExceptions=#(append
	(sequential-music-to-chord-exceptions myChordDefinitions #t)
	ignatzekExceptions
)

% some macros to be reused all over
% =====================================================================
myBreak=\break
% do line breaks really matter?
myEndLine=\break
%myEndLine={}
myEndLineVoltaNotLast={}
myEndLineVoltaLast=\break
partBar=\bar "||"
endBar=\bar "|."
startBar=\bar ".|"
startRepeat=\bar "|:"
endRepeat=\bar ":|"
startTune={}
endTune=\bar "|."
myFakeEndLine={}
mySegno=\mark \markup { \musicglyph #"scripts.segno" }
myCoda=\mark \markup { \musicglyph #"scripts.coda" }

% some functions to be reused all over
% =====================================================================
% A wrapper for section markers that allows us to control their formatting
myMark =
#(define-music-function
	(parser location mark)
	(markup?)
	#{
	\mark \markup { \circle #mark }
	#})
myGrace =
#(define-music-function
	(parser location notes)
	(ly:music?)
	#{
%%\grace $notes
	\appoggiatura $notes
	#})
%myGrace =
%#(define-music-function
%	(parser location notes)
%	(ly:music?)
%	#{
%	#})

% this is a macro that * really * breaks lines. You don't really need this since a regular \break will work
% AS LONG AS you have the '\remove Bar_engraver' enabled...
hardBreak={ \bar "" \break }
% a macro to make vertical space
verticalSpace=\markup { \null }

% macros to help in parenthesizing chords
% see the playground area for openbook and http://lilypond.1069038.n5.nabble.com/Parenthesizing-chord-names-td44370.html
#(define (left-parenthesis-ignatzek-chord-names in-pitches bass inversion context) (markup #:line ("(" (ignatzek-chord-names in-pitches bass inversion context))))
#(define (right-parenthesis-ignatzek-chord-names in-pitches bass inversion context) (markup #:line ((ignatzek-chord-names in-pitches bass inversion context) ")")))
#(define (parenthesis-ignatzek-chord-names in-pitches bass inversion context) (markup #:line ("(" (ignatzek-chord-names in-pitches bass inversion context) ")")))
LPC = { \once \set chordNameFunction = #left-parenthesis-ignatzek-chord-names }
RPC = { \once \set chordNameFunction = #right-parenthesis-ignatzek-chord-names }
OPC = { \once \set chordNameFunction = #parenthesis-ignatzek-chord-names }

% some macros for marking parts of jazz tunes
% =====================================================================
startSong={}
% If we want endings of parts to be denoted by anything we need
% to find a smarter function that this since this will tend
% to make other things disapper (repeat markings etc)
%endSong=\bar "|."
endSong={}
startPart={}
% If we want endings of parts to be denoted by anything we need
% to find a smarter function that this since this will tend
% to make other things disapper (repeat markings etc)
% endPart=\bar "||"
endPart={}
startChords={
%% this causes chords that do not change to disappear...
	\set chordChanges = ##t
%% use my own chord exceptions
	\set chordNameExceptions = #myChordExceptions
}
endChords={}


% lets always include guitar definitions
\include "predefined-guitar-fretboards.ly"

% book header
\book {
%% this is the title page
	\bookpart {
		\markup {
			\column {
				\null
				\null
				\null
				\null
				\null
				\null
				\null
				\null
				\null
				\null
				\fill-line { \fontsize #11 \bold "OpenBook" }
				\null
				\null
				\fill-line { \larger \larger \bold "An open source Jazz real book" }
				\null
				\null
				\null
				\fill-line {
					\huge \bold \concat {
						"Website: "
						\with-url #"https://veltzer.net/openbook" https://veltzer.net/openbook
					}
				}
				\null
				\fill-line {
					\huge \bold \concat {
						"Development: "
						\with-url #"https://github.com/veltzer/openbook" https://github.com/veltzer/openbook
					}
				}
				\null
				\fill-line {
					\huge \bold \concat {
						"Lead developer: Mark Veltzer "
						"<" \with-url #"mailto:mark.veltzer@gmail.com" mark.veltzer@gmail.com ">"
					}
				}
				\null
				\fill-line {
					\huge \bold \concat {
						"Typesetting copyright: © 2011-"
						2015
						" Mark Veltzer "
						"<" \with-url #"mailto:mark.veltzer@gmail.com" mark.veltzer@gmail.com ">"
					}
				}
				\null
				\fill-line { \huge \bold "Tune copyright: © belong to their respective holders" }
				\null
				\null
				\null
				\fill-line { \small "Git tag: 151" }
				\fill-line { \small "Git describe: 151" }
				\fill-line { \small "Git commits: 1372" }
				\fill-line { \small "Build date: 16:51:49 09-01-2015" }
				\fill-line { \small "Build user: mark" }
				\fill-line { \small "Build host: fermat" }
				\fill-line { \small "Build kernel: Linux 3.16.0-28-lowlatency" }
				\fill-line { \small "Lilypond version: 2.18.2" }
				\fill-line { \small "Number of tunes: 9" }
				\null
				\null
				\null
			}
		}
		\score {
			<<
				\new Staff="Melody" {
					\new Voice="Voice"
					\relative c' {
						\time 4/4
						\key f \major
						\set fontSize = #-3
						f8 e f c r4 a'8 aes | a c, r e~ e g f e | g f a bes a f g ees
					}
				}
			>>
			\layout {
				#(layout-set-staff-size 35)
				indent = 2.6\cm
			}
		}
	}

\markuplist \table-of-contents
\pageBreak

% from here everything needs to go into a loop

\bookpart {

% this causes the variables to be defined...










% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "איך הוא שר / דני רובס"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "איך הוא שר" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				""
				"מילים ולחן: דני רובס"
			}
			\fill-line {
				"בלדת רוק"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
%% this adds a bar engraver which does not always come with chords
%% I didn'f find a way to put this with the chords themselves...
	\with {
	%% for lilypond 2.12
	%%\override BarLine #'bar-size = #4
		\override BarLine #'bar-extent = #'(-2 . 2)
		\consists "Bar_engraver"
	}
	

\chordmode {
	\startChords
	\startSong

	\mark "Verse"
	\startPart
	\repeat volta 2 {
		a1:m | d:m/f | e:sus4 | e:7 |
	}
	f | g:7 | c | e:7 |
	a:m | d:m | e:sus4 | e:7 |
	\endPart

	\mark "Chorus"
	\startPart
	d:m | g | c | a:7 |
	d:m | e:7 | f | a:7 |
	d:m | g | c | a:7 |
	d:m | e:7 | f | a:m |
	\endPart

	\endSong
	\endChords
}


% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
	>>
	\layout {
	}
}




% Lyrics
\verticalSpace
\verticalSpace
\markup {
	\small {
		\fill-line {
			\right-column {
			%% chorus
				"איך הוא שר, איך הוא שר, הם רקדו מסביבו בטירוף הוא היה מאושר"
				"איך הוא שר, איך הוא שר, מה נשאר מהזוהר מכל השירים מה נשאר"
				\null
			%% verse
				"הם סגדו לו כמו אל, הוא היה סך הכל בן-אדם"
				"הקולות ששמע בשכונה נמוגים לאיטם"
				"רק הפחד ההוא הלבן בעורקיו מתפתל"
				"הוא חשב שימריא איתו, לא, הוא נופל"
				\null
			%% chorus
				"איך הוא שר, איך הוא שר, הם רקדו מסביבו בטירוף הוא היה מאושר"
				"איך הוא שר, איך הוא שר, מה נשאר מהזוהר מכל השירים מה נשאר"
			}
			\null
			\right-column {
			%% verse
				"מרחוק הוא שומע תפילות בית הכנסת מלא"
				"הנרות הדולקים ריח ערב שבת שוב עולה"
				"איך כולם התגאו בו הילד עם קול הזהב"
				"והסוף כמו בקרב אבוד, סוגר עליו"
				\null
			%% verse
				"ואמו לחשה לתינוק שרעד ובכה"
				"עוד תיראה לכולנו תהיה גאווה מקולך"
				"חום ידו של אביו כששר והאש בעיניו"
				"והסוף כמו בקרב אבוד, סוגר עליו"
			}
		}
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...












% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "איך זה שכוכב / מתי כספי, נתן זך"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "איך זה שכוכב" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: נתן זך"
				"לחן: מתי כספי"
			}
			\fill-line {
				"בוסה נובה"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
	\with {
		\remove "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\myMark "A"
	\startPart
	a1:maj7 | a1:maj7 | a1:maj7 | e2:m7 e2:m6 | \myEndLine
	e1:m | d1:m7 | d2:m7 d2:m6 | a1:maj7 | \myEndLine
	a1:maj7 | f1:maj7 | f1:maj7 | c1:maj7 | \myEndLine
	c1:maj7 | f2 b2:m7 | e1:7 | a1:maj7 | a1:maj7 | \myEndLine
	\endPart

	\myMark "B"
	\startPart
	d1:7 | d1:m | fis1:dim | a1:m | \myEndLine
	b1:m7 | a1:7 | d1:m/f | fis1:m | \myEndLine
	fis1:m | a1:maj7 | a1:maj7 | e2:m7 e2:m6 | \myEndLine
	e1:m | d1:m7 | d2:m6 d2:m7 | a1:maj7 | a1:maj7 | \myEndLine
	\endPart

	\endSong
	\endChords
}



% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
\new Staff="Melody" {
\new Voice="Voice"
	\relative c' 



{
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key a \major

%% Part A
	e2 e | gis4 a8 gis~ gis4 a8 gis~ | gis4 fis8 e8~ e4 fis8 g~ | g1 |
	r2 g8 fis e f~ | f1 | r4. f8 g a b cis~ | cis1 |
	r2. cis8 e~ | e4 e8 d~ d4 d8 c~ | c2. b8 d~ | d d d c~ c c c b~ |
	b4 r4 r8 a8 b d~ | d2. a8 d~ | d d~ d cis~ cis4 b8 a~ | a1~ | a2 r |

%% Part B
	c2 c | c4 c8 c~ c4 c8 c~ | c4 c8 c~ c4 c8 c~ | c2 r |
	r2 d8 d d cis~ | cis2 r | r4 r8 a b b b a~ | a4 r r2 |
	r4 r8 a b b b a~ | a4 r r2 | r2 a8 gis fis g~ | g2 r |
	r2 g8 fis e f~ | f2 r | r4 r8 f g a b a~ | a1~ | a1 |
}


}
\new Lyrics="Lyrics" \lyricsto "Voice"
	




\lyricmode {
%% Part A
	איך זה ש -- כו -- כב __ א -- חד __ ל -- בד __ מ -- עז. __
	איך הוא מ -- עז, __ ל -- מ -- ען ה -- שם. __
	כו -- כב __ א -- חד __ ל -- בד. __
	א -- ני __ לא ה -- יי -- __ תי מ -- עז. __
	ו -- א -- ני, __ ב -- ע -- __ צם, __ לא __ ל -- בד. __ __

%% Part B
	איך זה ש -- כו -- כב __ א -- חד __ ל -- בד __ מ -- עז. __
	איך הוא מ -- עז, __ ל -- מ -- ען ה -- שם. __
	ל -- מ -- ען ה -- שם. __
	לה לה לה לה __
	לה לה לה לה __
	לה לה לה לה לה __ __
}

	>>
	\layout {
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...










% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "גשם / יחיאל אמסלם, יעקב גלעד"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "גשם" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: יעקב גלעד"
				"לחן: יחיאל אמסלם"
			}
			\fill-line {
				"בלדת רוק"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
%% this adds a bar engraver which does not always come with chords
%% I didn'f find a way to put this with the chords themselves...
	\with {
	%% for lilypond 2.12
	%%\override BarLine #'bar-size = #4
		\override BarLine #'bar-extent = #'(-2 . 2)
		\consists "Bar_engraver"
	}
	

\chordmode {
	\startChords
	\startSong

	\repeat volta 2 {
		g1*2 | d | \myEndLine
		c1 | d | e1*2:m |
	}
	d | \myEndLine
	\repeat volta 2 {
		g1*2 | d | \myEndLine
		c1 | d | e1*2:m |
	}
	d | \myEndLine

	e:m | d | \myEndLine
	c1 | d | g | g2 g/fis | \myEndLine
	e1*2:m | d | \myEndLine
	c1 | d | e:m | \myEndLine
	a:m | b:m | c | des:m7.5- | \myEndLine
	b:m | g | c | e1*2 | \myEndLine

	\repeat volta 2 {
		a | e | \myEndLine
		d1 | e | fis1*2:m |
	}
	e | \myEndLine

	fis:m | e | \myEndLine
	d1 | e | fis1*2:m | \myEndLine
	fis:m | e | \myEndLine
	d1 | e | fis:m | \myEndLine
	\repeat volta 3 {
		b:m | cis:m | d | ees:m7.5- | \myEndLine
		cis:m | a | d | fis1*2 | \myEndLine
	}

%% commented in order to see the closing repeats
%%\endSong
%%\endChords
}


% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
	>>
	\layout {
	}
}




% Lyrics
\verticalSpace
\verticalSpace
\markup {
	\small { %% \teeny \tiny \small \normalsize \large \huge
		\fill-line {
			\right-column {
				"אין מקום לדאגה היי שקטה"
				"אני איתך, את לא לבד לעת עתה"
				"עכשיו הכל זורם כאן במנוחה"
				"ואת בוכה, ואת בוכה."
				\null
				"ספרי לי מה כבד עלייך"
				"את כל מה שחבוי בך ונרדם"
				"אני אמחה את דמעותייך"
				"ורק שלא תבכי עוד לעולם."
			}
			\null
			\right-column {
				"ברחובות כיבו מזמן את הניאון"
				"את נראית לי עייפה נלך לישון"
				"האור דולק בחדר השני"
				"אבל מישהו בוכה וזה לא אני."
				\null
				"אני רוצה לשמור עלייך ועלי"
				"היום עבר עלינו יום קשה מדי"
				"בחוץ יורדים עכשיו גשמי ברכה"
				"ואת בוכה, ואת בוכה."
				\null
				"ספרי לי מה כבד עלייך"
				"את כל מה שחבוי בך ונרדם"
				"אני אמחה את דמעותייך"
				"ורק שלא תבכי עוד לעולם."
			}
		}
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...













% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "הרדופים ליד החוף / שלמה ארצי, נתן יונתן"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "הרדופים ליד החוף" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: נתן יונתן"
				"לחן: שלמה ארצי"
			}
			\fill-line {
				"שירי ארץ ישראל"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
	\with {
		\remove "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\partial 4 s4 |

	\myMark "A"
	\startPart
	\repeat volta 2 {
		d1:m | g2:m7 c:7 | f1:maj7 | g:m | \myEndLine
		g:m7 | bes:maj7 | d2:dim7 a:7 |
	} \alternative {
		{ d1:m | }
		{ d1:m | }
	} \myEndLine
	\endPart

	\myMark "B"
	\startPart
	\repeat volta 2 {
		a2 a2:7 | d1:m | g2:m7/c c:7 | f1:maj7 | \myEndLine
	} \alternative {
		{
			bes2:maj7 a:7 | ees1:maj7 | e2:m7.5- ees:maj7 | d1:m | \myEndLine
		}
		{
			bes2:maj7 a:7 | d1:m/f | d2:dim7 a:7 | d1:m | \myEndLine
		}
	}
	\endPart

	\endSong
	\endChords
}




% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
\new Staff="Melody" {
\new Voice="Voice"
	\relative c' 



{
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key d \minor

	\set Staff.midiInstrument = #"flute"

	\partial 4 f8 e |

%% part "A"
	\repeat volta 2 {
		d4. d'8 c4 bes8 a | g2. f8 g | a4. c,8 f4 a8 g | d2. e8 f |
		g4. f8 e4 d8 d' | bes2 a4 g | f4. f8 e4. e8 |
	} \alternative {
		{ d2. f8 e | }
		{ d2. cis8 d | }
	}

%% part "B"
	\repeat volta 2 {
		e4. a,8 d4. e8 | f4 f2 e8 f | g4. c,8 f4. g8 | a4 a2 bes8 c |
	} \alternative {
		{ d4. cis8 f4. e8 | d4 d2 c8 bes | a4. a8 bes8 c bes4 | a2. cis,8 d | }
		{ d'4. cis8 f4. e8 | d4 d2 bes8 c | d4. cis8 f4. e8 | d2. f,8 e | }
	}
}



}
\new Lyrics="Lyrics" \lyricsto "Voice"
	




\lyricmode {
	לא נפ -- רח כבר פ -- ע -- מ -- יים, ו -- ה -- רו -- ח על ה -- מ -- ים,
	י -- פ -- זר דמ -- מה צו -- נ -- נת על פ -- ני -- נו ה -- חיוו -- רות

	ש -- מה _

	בלי תו -- גה, כפו -- פי צ -- מ -- רת, בלו -- ר -- יות שי -- בה נב -- ד -- רת
	ב -- א -- שר י -- פות ה -- תו -- אר, בין שרי -- קות ה -- ע -- _ ד -- רים.

	תפ -- נו --

	לא נוסיפה עוד לנוע, משתאים נביט ברוח
	איך הוא יחד עם המים, מפרקים את הסלעים.
	תאנה חנטה פגיה, והנשר היגע -
	אל קינו חזר בחושך מדרכי האלוהים.

	הרדופים שלי, כמוני, וכמוך שכל ימייך,
	את פרחי האור שלנו את פיזרת לכל רועה.
	לא עופות מרום אנחנו, ואל גובה השמיים,
	גם אתם, גם אנוכי - לא נגיע כנראה.

	רק בהר על קו הרכס מישהו מוסיף ללכת,
	מן הואדי והאבן, לרכסים, אל הרוחות.
	עד אשר בכסות הערב, יחזור נוגה אלייך,
	עם פכפוך פלגים, עם רחש הרדופים ליד החוף.
}


\new Lyrics="Lyrics" \lyricsto "Voice"
	





\lyricmode {
	ש -- מה בין אי -- בי ה -- נ -- חל, ב -- ש -- עה א -- חת נש -- כ -- חת,
	זכ -- רו -- נות א -- זוב ש -- ל -- נו מת -- רפ -- קים על ה -- קי -- _ _ _ רות.

	_ _ קי ג -- וון יר -- טי -- טו, ב -- לכ -- תן לר -- חוץ ב -- ז -- רם
	נכ -- ל -- _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ מים נש -- פיל עי -- נ -- נו, אל ה -- מ -- ים ה -- קרי -- רים.
}

	>>
	\layout {
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...












% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "היא חזרה בתשובה / מתי כספי, יעקב רוטבליט"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "היא חזרה בתשובה" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: יעקב רוטבליט"
				"לחן: מתי כספי"
			}
			\fill-line {
				"בוסה נובה"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
	\with {
		\remove "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\partial 2. s2. |

	\myMark "A"
	\startPart
	c1*2:m | g:7/b | c:7/bes | f1:m9/a | f1:m | \myEndLine
	g:m7.5- | c:7 | f1*2:m |
	\endPart

	\myMark "B"
	\startPart
	\endPart

	\endSong
	\endChords
}



% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
\new Staff="Melody" {
\new Voice="Voice"
	\relative c' 



{
	\tempo "Allegro" 4 = 130
	\time 4/4
	\key c \minor
}


}
\new Lyrics="Lyrics" \lyricsto "Voice"
	




\lyricmode {
}

	>>
	\layout {
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...











% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "לא יכולתי לעשות כלום / אילן וירצברג, יונה וולך"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "לא יכולתי לעשות כלום" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: יונה וולך"
				"לחן: אילן וירצברג"
			}
			\fill-line {
				"בלדת רוק"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
%% this adds a bar engraver which does not always come with chords
%% I didn'f find a way to put this with the chords themselves...
	\with {
	%% for lilypond 2.12
	%%\override BarLine #'bar-size = #4
		\override BarLine #'bar-extent = #'(-2 . 2)
		\consists "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\mark "בית"
	\startPart
	a1 | fis:m | d | g | a | \myEndLine
	d | d:m | g | a | \myEndLine
	a1 | fis:m | d | g | a | \myEndLine
	a | cis:m | d | d:m | a | \myEndLine
	\endPart

	\mark "פזמון"
	\startPart
	fis1*2:m | cis:m | b:m | fis:m | \myEndLine
	a | cis:m | b:m | fis:m | \myEndLine
	\endPart

	\mark "אינסטרומנטלי"
	\startPart
	\startRepeat
	fis1*2:m | cis:m | b:m | fis:m | \myEndLine
	\endRepeat
	\endPart

	\endSong
	\endChords
}


% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
	>>
	\layout {
	}
}





% Lyrics
\verticalSpace
\verticalSpace
\markup {
	\small { %% \teeny \tiny \small \normalsize \large \huge
		\fill-line {
			\right-column {
				"לא יכולתי לעשות עם זה כלום, אתה שומע?"
				"לא יכולתי לעשות עם זה כלום."
				"זה היה אצלי בידיים..."
				"ולא יכולתי לעשות כלום."
				\null
				"אנלא יכולתי עם זה משהו, אתה שומע?"
				"יכולתי לגמגם"
				"מה רציתי להגיד"
				"יכולתי להרגיש הכי רע, שאפשר."
				\null
				"ופתאום אתה עומד כמו ילד קטן"
				"בסינור לצוואר וחוזר על השאלה"
				"מה עשית עם זה, שואלים לאן"
				"בזבזת את כל זה היה לך סיכוי"
				"ואתה תצטרך להתחיל הכל מחדש."
				\null
				"לא יכולתי לעשות עם זה כלום."
			}
			\null
			\right-column {
				"לא יכולתי לעשות עם זה כלום, אתה שומע?"
				"לא יכולתי לעשות עם זה כלום."
				"זה היה אצלי בידיים..."
				"ולא יכולתי לעשות כלום."
				\null
				"לא יכולתי לעשות משהו, אתה שומע?"
				"יכולתי לגמגם"
				"מה רציתי להגיד "
				"יכולתי להרגיש הכי רע, שאפשר."
				\null
				"לא יכולתי לעשות עם זה כלום, אתה שומע?"
				"לא יכולתי לעשות עם זה כלום."
				"זה היה אצלי בידיים..."
				"ולא יכולתי לעשות כלום."
				\null
				"לא יכולתי לעשות משהו, אתה שומע?"
				"יכולתי לגמגם"
				"מה רציתי להגיד"
				"יכולתי להרגיש הכי רע, שאפשר."
				\null
				"ופתאום אתה עומד כמו ילד קטן"
				"בסינור לצוואר וחוזר על השאלה"
				"מה עשית עם זה, שואלים לאן"
				"בזבזת את כל זה היה לך סיכוי"
				"ואתה תצטרך להתחיל הכל מחדש."
			}
		}
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...













% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "נח / מתי כספי, יורם טהרלב"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "נח" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: יורם טהרלב"
				"לחן: מתי כספי"
			}
			\fill-line {
				"סמבה"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
	\with {
		\remove "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\mark "Intro"
	\startPart
	f1:m | bes:m | f:m | c:7 | \myEndLine
	\endPart

	\myMark "A"
	\startPart
	f:m | bes:m | f:m | c:7 | \myEndLine
	f:m | bes:m | f:m | c:7 | \myEndLine
	f:7 | bes:7 | c:7 | f | \myEndLine
	f:7 | bes:7 | c:7 | f:7 | \myEndLine
	bes | ees | ees:m7 | c:7 | \myEndLine
	f:m | bes:m | f:m | c:7 | \myEndLine
	\endPart

	\endSong
	\endChords
}




% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
\new Staff="Melody" {
\new Voice="Voice"
	\relative c' 



{
	\tempo "Allegro" 4 = 160
	\time 4/4
	\key f \minor

%% Intro
	f8 aes bes b c f, c' b | bes f ees' d f, d' des f, | des' c f, c' b f bes aes | c, e g bes c4 c' |

%% A part
	f,,8 aes8~ aes2. | f'4 des8 bes4 g4 c8~ | c4 aes8 f4 c4 bes'8~ | bes4 g8 e4 c4. |
	f8 aes8~ aes2. | f'4 des8 bes4 g4 c8~ | c4 aes8 f4 c4 bes'8~ | bes4 g8 e4 c4. |
	g'4 f8 f4 c g'8~ | g f4 f2~ f8 | g4 f8 f4 c g'8~ | g f4 f c4. |
	g'4 f8 f4 c g'8~ | g f4 f bes,4. | g'4 f8 f4 c g'8~ | g f4 c'8~ c2 |
	c4 bes8 bes4 f c'8~ | c bes4 bes ees,4. | c'4 bes8 bes4 ges4 c8~ | c8 bes4 bes aes8 g aes~ |
	aes1 | f'4 des8 bes4 g f8~ | f c' bes aes bes aes f aes | c, e g bes c2 |
}



}
\new Lyrics="Lyrics" \lyricsto "Voice"
	




\lyricmode {
%% Intro
	_ _ _ _ _ _ _ _
	_ _ _ _ _ _ _ _
	_ _ _ _ _ _ _ _
	_ _ _ _ _ _

%% A part
	נ -- ח- __ לא ש -- כ -- חנו איך __ ב -- ג -- שם ו -- __ ב -- ס -- ער
	נ -- ח- __ ל -- תי -- בה א -- ספ -- __ ת את ח -- יות __ ה -- י -- ער.
	שת -- יים, שת -- יים מ -- __ כל מין __
	ה -- אר -- יה ו -- ה -- __ מ -- מו -- תה, ה -- ג -- מל ו -- ה -- __ שי -- בו -- טה
	ו -- גם ה -- הי -- פו -- __ פו -- טם. __
	איך פ -- תח -- ת את __ ה -- צו -- הר
	ו -- מ -- תוך ה -- תכ -- __ לת ה -- ל -- ב -- נה __
	ב -- אה ה -- יו -- נה. __
}


	>>
	\layout {
	}
}







% Lyrics
\verticalSpace
\verticalSpace
\markup {
	\small {
		\fill-line {
			\right-column {

			%% part
				"נח - היונה כבר שבה עם עלה של זית"
				"נח - תן לנו לצאת ולחזור לבית"
				"כי כבר נמאסנו זה על זה"
				"האריה על הממותה, הגמל על השיבוטה"
				"וגם ההיפופוטם."
				"פתח לרגע את הצוהר"
				"ונעוף לתכלת הלבנה"
				"כך עם היונה."
			}
			\null
			\right-column {

			%% part
				"נח - כמה זמן נמשיך לשוט על פני המים?"
				"נח - כל החלונות סגורים כמעט חודשיים."
				"וכבר אין לנו אויר"
				"לאריה ולממותה לגמל ולשיבוטה"
				"וגם להיפופוטם."
				"פתח לרגע את הצוהר"
				"ואל תוך התכלת הלבנה"
				"שלח את היונה."
				\null

			%% part
				"נח - מה אתה דואג, הן כבר חדל הגשם"
				"נח - פתח את החלון, אולי הופיעה קשת"
				"ויראו אותה כולם"
				"האריה והממותה, הגמל והשיבוטה"
				"וגם ההיפופוטם."
				"פתח לרגע את הצוהר"
				"ואל תוך התכלת הלבנה"
				"שלח את היונה."
			}
		}
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...













% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "סליחות / עודד לרר, לאה גולדברג"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "סליחות" }
			\fill-line { \large \smaller \bold \larger "באת אלי" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: לאה גולדברג"
				"לחן: עודד לרר"
			}
			\fill-line {
				"בלדה מתונה"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
	\with {
		\remove "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\partial 4 s4 |

	\mark "פתיחה"
	\startPart
	a2.:m | d:m7 | g:7 | c:maj7 |
	f:maj7 | b:7 | e:7 | \myEndLine
	\endPart

	\myMark "A"
	\startPart
	a2.:m | d:m7 | e:7 | a:m |
	a:m | d:m7 | e:7 | a:7 | \myEndLine
	d:m7 | g:7 | c2:maj7 c4:maj7/d | e2.:7 |
	a:m | d:m7 | e:7 | a:7 | \myEndLine
	d:m7 | g:7 | c2:maj7 c4:maj7/d | e2.:7 |
	a:m | d:m7 | e:7 | a:m | a:m | \myEndLine
	\endPart

	\myMark "B"
	\startPart
	\repeat unfold 2 {
		a2.:m | d:m7 | g:7 | c:maj7 |
		f:maj7 | b:7 | e:7 | a:m |
	}
	a:m | \myEndLine
	\endPart

	\endSong
	\endChords
}




% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
\new Staff="Melody" {
\new Voice="Voice"
	\relative c' 



{
	\tempo "Moderato" 4 = 112
	\time 3/4
	\key a \minor

	\partial 4 a'8 e |

%% part "Intro"
	c'4 a4. e8 | f2 g8 a | b4 a4. g8 | f8 e4. f8 g |
	a2 f8 e | ees2 b8 a | gis4 a b |

%% part "A"
	c'2 b8 a | g2 f8 d | e2 d4 | c8 b a2 |
	c'8 b a4 g8 f | e2 d8 e | f4 e ees | e2. |
	d4 e f | g a4. f8 | e4 e d | c b2 |
	a8 b c4 d8 e | g4 f d | e f ees | e2. |
	d4 e f | g a4. f8 | e4 e d | c b2 |
	a8 b c4 d8 e | g4 f d | e c b | a2. ~ | a2 a'8 e |

%% part "B"
	c'2 a8 e | f2 g8 a | b4 a g | f e f8 g |
	a2 f8 e | ees2 b8 a | gis4 a b | c2 a'8 e |
	c'2 a8 e | f2 g8 a | b4 a g | f e f8 g |
	a2 b8 c | d2 b8 a | gis2 a8 b | a2. ~ | a2. |
}



}
\new Lyrics="Lyrics" \lyricsto "Voice"
	




\lyricmode {
	_ _
	_ _ _ _ _ _ _ _ _ _ _ _ _
	_ _ _ _ _ _ _ _ _

	בא -- ת א -- לי את עי -- ני לפ -- ק -- ו -- ח,
	ו -- גופ -- ך לי מ -- בט ו -- ח -- לון ו -- ר -- אי,
	בא -- ת כ -- לי -- לה ה -- בא אל ה -- או -- ח
	ל -- הר -- אות לו ב -- חו -- שך את כל ה -- דב -- רים.
	בא -- ת כ -- לי -- לה ה -- בא אל ה -- או -- ח
	ל -- הר -- אות לו ב -- חו -- שך את כל ה -- דב -- רים. __

	ו -- ל -- מ -- ד -- תי: שם ל -- כל ריס ו -- צי -- פו -- רן
	ו -- ל -- כל ש -- ע -- רה ב -- ב -- שר ה -- ח -- שוף
	וריח _ _ _ יל -- דות רי -- ח ד -- בק ו -- או -- רן
	הוא ני -- חו -- ח לי -- לו של ה -- גוף, של ה -- גוף. __
}


\new Lyrics="Lyrics" \lyricsto "Voice"
	





\lyricmode {
	_ _
	_ _ _ _ _ _ _ _ _ _ _ _ _
	_ _ _ _ _ _ _ _ _

	אם ה -- יו עי -- נו -- יים - הם הפ -- לי -- גו אל -- יך
	מפר -- שי ה -- ל -- בן אל האו -- פל של -- ך
	תנני ללכת תנני ללכת
	לכרוע על חוף הסליחה.
}

	>>
	\layout {
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


\bookpart {

% this causes the variables to be defined...











% now play with the variables that depend on language



% calculate the tag line


% calculate the typesetby




\tocItem \markup "יום שישי את יודעת / יהודה פוליקר, יעקב גלעד"





% taken from "/usr/share/lilypond/2.12.3/ly/titling-init.ly"
\markup {
	\column {
		\override #'(baseline-skip . 3.5)
		\column {
			\huge \larger \bold
			\fill-line { \larger "יום שישי את יודעת" }
			\fill-line { \smaller \bold "" }
			\fill-line {
				"מלים: יעקב גלעד"
				"לחן: יהודה פוליקר"
			}
			\fill-line {
				"רוקנרול"
				""
			}
		}
	}
}
\noPageBreak


% include the preparatory stuff, if there is any

% calculate the vars



% score for printing
\score {
	<<
\new ChordNames="Chords"
%% this adds a bar engraver which does not always come with chords
%% I didn'f find a way to put this with the chords themselves...
	\with {
	%% for lilypond 2.12
	%%\override BarLine #'bar-size = #4
		\override BarLine #'bar-extent = #'(-2 . 2)
		\consists "Bar_engraver"
	}
	


\chordmode {
	\startChords
	\startSong

	\mark "פתיחה"
	f1 | g | c | a:m | \myEndLine
	f | g | c1*2 | \myEndLine

	\mark "בית"
	\repeat volta 2 {
		c1*2 | g1*2 | \myEndLine
		g1*2 | c1*2 | \myEndLine
	}
	bes1 | a | aes | g | \myEndLine
	c2 c4 d | ees1 | c1*2 | \myEndLine

	\mark "פזמון"
	\repeat volta 2 {
		f1 | g | c | a:m | \myEndLine
		d:m7 | g | c | c:7 | \myEndLine
	}
	\mark "מעבר"
	f | g | c1*2 | \myEndLine

	\mark "סיום"
	\repeat volta 2 {
		c1 | g | g | c | \myEndLine
	}

	\endSong
	\endChords
}


% this thing will only engrave voltas. This is required to put the volta under the chords.
% No great harm will happen if you don't put it, only the voltas will be above the chords.
%\new Staff \with {
%	\consists "Volta_engraver"
%}
	>>
	\layout {
	}
}





% Lyrics
\verticalSpace
\verticalSpace
\markup {
	\small { %% \teeny \tiny \small \normalsize \large \huge
		\fill-line {
			\right-column {
				"אז אני מטלפן מתכנן מתכונן"
				"מתקלח שעה מתבונן במראה"
				"מחטא יבלות ומרים משקולות"
				"משחרר כיווצים ומותח קפיצים"
				"כשהראש מסודר לא איכפת שום דבר"
				"יום שישי כבר מגיע"
				"השבוע נגמר"
				\null
				"יום שישי את יודעת..."
				\null
				"כשעובר יום שבת והזמן זז לאט"
				"אני שוב מיובש, עוד שבוע חדש"
				"בעיות, עניינים, חדשות, עיתונים"
				"והכל שגרתי, שיעמום אמיתי"
				"אז עכשיו אני כאן, מעביר את הזמן"
				"אין לי דרך לברוח, לא יודע לאן"
				\null
				"יום שישי את יודעת..."
			}
			\null
			\right-column {
				"השבוע מתחיל מאוחר כרגיל"
				"אין לי כח לקום אין לי חשק לכלום"
				"יום ראשון דיכאון יום שני עצבני"
				"יום שלישי לא ניגמר רביעי מיותר"
				"וביום חמישי מצב רוח חופשי"
				"זה כבר סוף השבוע"
				"ומחר יום שישי"
				\null
				"יום שישי את יודעת"
				"יש בעיר מסיבה"
				"נשארים כל הלילה"
				"עד הבוקר הבא"
				"יום שישי את יודעת"
				"והיום במיוחד"
				"אם תירצי כל הלילה"
				"הוא שלנו לבד"
			}
		}
	}
}


\noPageBreak
\markup \column {
%% just a little space
	\null
	\fill-line {
		\smaller \smaller { "-- עיזרו לי למלא את שורת זכויות היוצרים הזו --" }
	}
	\fill-line {
		\smaller \smaller { "תווי על ידי מרק ולצר <mark.veltzer@gmail.com>" }
	}
}



}


% book footer
}
