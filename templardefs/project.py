'''
Adds reading of static/version.ini
'''

import templar.attr # for BaseAttr
import sys # for stderr

class Attr(templar.attr.BaseAttr):

	@classmethod
	def init(cls):
		cls.read_full_ini('static/version.ini')

	@classmethod
	def getdeps(cls):
		return ' '.join([__file__, 'static/version.ini'])
