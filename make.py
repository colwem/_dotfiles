#!/usr/bin/env python

from path import Path

wd = Path('.').abspath()
home = wd.parent
for f in wd.files():
	f.copy(home)
for d in wd.dirs():
	cp_path = home + '/' + d.name
	if cp_path.exists():
		cp_path.rmtree() 
	d.copytree(cp_path)
