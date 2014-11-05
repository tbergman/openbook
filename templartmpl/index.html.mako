<html>
	<!-- vim: set filetype=html : -->
	<head>
		<meta charset="UTF-8"/>
		<title>OpenBook</title>
		<link rel="shortcut icon" href="static/favicon.ico"/>
		<meta name="Description" content="jazz real book open source project that produces beautiful jazz standards for musicians"/>
		<meta name="Keywords" content="${attr.personal_fullname}, ${attr.personal_slug}, ${attr.project_name}, ${attr.project_keywords}"/>
	</head>
	<body>
		<h1>Welcome to The ${attr.project_name} web site</h1>

		<h2>A demo for the impatient...</h2>
		<!--iframe src="viewer/viewer.html" width="100%" height="1700px"></iframe-->
		<embed src="static/openbook.pdf" width="100%" height="1700px"></embed>
		<!--embed style="height: 100%; width: 100%;" src="static/au_privave.svg" type="image/svg+xml"/-->
		<!--img src="static/au_privave.png" title="Sample output from the ${attr.project_name} project in the form of an image"/-->
		<p>You can download the latest version of the ${attr.project_name} from <a href="static/openbook.pdf">here</a>.</p>

		<p>Openbook is a open source project to build a free, high quality "real book"
		for Jazz musicians. A real book simply means a big book with lots of Jazz tunes or standards as they are more widely known. Open book will always remain free and is guarateed so by it's license. The goal of production is beautiful and lightweight postscript and PDF real books with Jazz tunes. The idea is that the end user can control the final output and decide if he/she wants lyrics, size of paper, transposition for trumpet, selection of tunes and more. In addition you can produce midi, mp3 and ogg outputs. The end user can also, obviously, modify add or remove tunes or use the tunes in ${attr.project_name} as the basis of arrangements.
		</p>

		<p>The project is developed by me, ${attr.personal_fullname}, and you can contact me at <a href="mailto:${attr.personal_email}">${attr.personal_email}</a>. Currently there are no other contributors but I am hoping that this will change. Anyone is welcome to contribute.</p>

		<p>The license for the project is currently GPL V3. This is only so because I did not have time to think more deeply about the issue. It may change in the future as a result of future thinking on my part and the fact that I am the only copyright holder. The fact that the tunes inside the book have their own copyright holders complicates matters. In any case I am committed to keeping the project free in the free software sense and you are well within your rights to take a snapshot of it and continue developing it on your own when and if you feel that a future license selection does not match your expectations.</p>

		<p>
		Why did I start this ?
		<ul>
			<li>
			I wanted to learn Jazz and a good way to do that is to write down the tunes (amongst many many other things).
			</li>
			<li>
			I wanted beautiful sheet music that I could fiddle with.
			</li>
			<li>
			I did not want to pay for the overly expensive real or fake books out there.
			</li>
			<li>
			I believe in free software and wanted free (in the sense of freedom) sheet music.
			</li>
			<li>
			Jazz is a prime example of a free type of art so combining it with free software seems a match made in heaven.
			</li>
			<li>
			Jazz musicians may need beautiful electronic Real books because electronic books are starting to be used by Jazz musicians both for practice and for performance.
			</li>
		</ul>


		<p>Future ideas include:
		<ul>
			<li>
			supporting mobile reading formats like epub
			</li>
			<li>
			producing a mobile application for various platforms that musicians could use on their portable pads. This app would show them their music sheets and allow them to search for standards.
			</li>
		</ul>

		<p>
		Links to tools used by this project:
		<ul>
		<li>
		The git tool used as a source control system for ${attr.project_name} is <a title="git" href="http://git-scm.com/">here</a>
		</li>
		<li>
		The GNU make system used to build ${attr.project_name} is <a title="GNU make" href="http://www.gnu.org/s/make/">here</a>
		</li>
		<li>
		The python scripting language that is used to script ${attr.project_name} is <a title="python" href="http://python.org/">here</a>
		</li>
		<li>
		The mako templating engine for python that is used in ${attr.project_name} is <a title="mako" href="http://www.makotemplates.org/">here</a>
		</li>
		<li>
		The lilypond language and compiler used to develop the tunes is <a title="lilypond" href="http://lilypond.org/">here</a>
		</li>
		<li>
		The timidity tool used in ${attr.project_name} to convert from midi to wav and ogg is <a title="timidity++" href="http://timidity.sourceforge.net/">here</a>
		</li>
		<li>
		The lame tool used to encode midi to mp3 is <a title="lame" href="http://lame.sourceforge.net/">here</a>
		</li>
	</ul></p>
	<p>Some related project links:
		<ul>
		<li>
		The ${attr.project_name} github project is <a title="${attr.project_name} github project" href="${attr.project_website_source}">here</a>
		</li>
		<li>
		The web site for the project is <a title="open book is a real book for Jazz musicians" href="${attr.project_website}">here</a>
		</li>
		<li>
		The latest stable pdf coming out of the ${attr.project_name} project is <a href="static/openbook.pdf">here</a>
		</li>
		<li>
		The latest stable postscript coming out of the ${attr.project_name} project is <a href="static/openbook.ps">here</a>
		</li>
		<li>
		The latest stable lilypond file from which the pdf and postscript were created is <a href="static/openbook.ly">here</a>
		</li>
		</ul>
		</p>
		<p>
		Copyright ${attr.personal_origin}, ${attr.project_copyright_years}
		<br/>
		<a href="mailto:${attr.personal_email}">${attr.personal_email}</a>
		</p>
	</body>
</html>
