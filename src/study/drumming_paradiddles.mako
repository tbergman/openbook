<%inherit file="/src/include/common.makoi"/>
\header {
	default_header

	title="Drumming paradiddles"
	style="Jazz"

	copyright=copyright_val_study

	completion="5"
	uuid="eb2be7a4-6f42-11e0-a53d-0019d11e5a41"
}

<%doc>
	TODO:
	- add more text here about paradiddles.
	- add a reference to wikipedia: http://en.wikipedia.org/wiki/Rudiment
	- get more examples from wikipedia coded here.
</%doc>

\markuplines {
	\wordwrap-lines { \italic {
	This is some text about paradiddles...
	} }
}
\markup {
Single Paradiddle (starting with the right hand).
}
\score {
<<
	\new DrumStaff \with {
		\remove Time_signature_engraver
		%% you don't really need this (have yet to see this do anything useful...)
		%%\remove Forbid_line_break_engraver
		\remove Bar_engraver
		drumStyleTable = #percussion-style
		\override StaffSymbol #'line-count = #0
		%%\override Stem #'Y-extent = ##f
		%%\override Stem #'transparent = ##t
	} <<
		\set Score.timing = ##f
		\new DrumVoice {
			\time 2/4
			\stemUp
			\drummode {
				sn16->^"R"\( sn^"L" sn^"R" sn^"R"\)
				sn->^"L"\( sn^"R" sn^"L" sn^"L"\)
			}
		}
	>>
>>
	\layout {
	}
	\midi {
		\context {
			\Score
			tempoWholesPerMinute = #(ly:make-moment 130 4)
		}
	}
}
\markup {
Double Paradiddle (starting with the right hand)
}
\score {
<<
	\new DrumStaff \with {
		\remove Time_signature_engraver
		%% you don't really need this (have yet to see this do anything useful...)
		%%\remove Forbid_line_break_engraver
		\remove Bar_engraver
		drumStyleTable = #percussion-style
		\override StaffSymbol #'line-count = #0
		%%\override Stem #'Y-extent = ##f
		%%\override Stem #'transparent = ##t
	} <<
		\set Score.timing = ##f
		\new DrumVoice {
			\time 6/8
			\stemUp
			\drummode {
				sn16->^"R"\( sn^"L" sn^"R" sn^"L" sn^"R" sn^"R"\)
				sn->^"L"\( sn^"R" sn^"L" sn^"R" sn^"L" sn^"L"\)
			}
		}
	>>
>>
	\layout {
	}
	\midi {
		\context {
			\Score
			tempoWholesPerMinute = #(ly:make-moment 130 4)
		}
	}
}
\markup {
Triple Paradiddle (starting with the right hand).
}
\score {
<<
	\new DrumStaff \with {
		\remove Time_signature_engraver
		%% you don't really need this (have yet to see this do anything useful...)
		%%\remove Forbid_line_break_engraver
		\remove Bar_engraver
		drumStyleTable = #percussion-style
		\override StaffSymbol #'line-count = #0
		%%\override Stem #'Y-extent = ##f
		%%\override Stem #'transparent = ##t
	} <<
		\set Score.timing = ##f
		\new DrumVoice {
			\time 8/4
			\stemUp
			\drummode {
				sn16->^"R"\( sn^"L" sn^"R" sn^"L" sn^"R" sn^"L" sn^"R" sn^"R"\)
				sn->^"L"\( sn^"R" sn^"L" sn^"R" sn^"L" sn^"R" sn^"L" sn^"L"\)
			}
		}
	>>
>>
	\layout {
	}
	\midi {
		\context {
			\Score
			tempoWholesPerMinute = #(ly:make-moment 130 4)
		}
	}
}
\markup {
Paradiddle-Diddle (starting with the right hand).
}
\score {
<<
	\new DrumStaff \with {
		\remove Time_signature_engraver
		%% you don't really need this (have yet to see this do anything useful...)
		%%\remove Forbid_line_break_engraver
		\remove Bar_engraver
		drumStyleTable = #percussion-style
		\override StaffSymbol #'line-count = #0
		%%\override Stem #'Y-extent = ##f
		%%\override Stem #'transparent = ##t
	} <<
		\set Score.timing = ##f
		\new DrumVoice {
			\time 6/8
			\stemUp
			\drummode {
				sn16->^"R"\( sn^"L" sn^"R" sn^"R" sn^"L" sn^"L"\)
				sn->^"L"\( sn^"R" sn^"L" sn^"L" sn^"R" sn^"R"\)
			}
		}
	>>
>>
	\layout {
	}
	\midi {
		\context {
			\Score
			tempoWholesPerMinute = #(ly:make-moment 130 4)
		}
	}
}