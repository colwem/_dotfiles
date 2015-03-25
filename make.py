#!/usr/bin/env python

from path import Path
from tempfile import mkstemp, mktemp

repo_root = Path(__file__).abspath()
home = Path( repo_root + '/home/')
usr_home = Path('~').abspath()

fn1 = mktemp()
fn2 = mktemp()
p = Path(fn1)
f = p.open('w')
f.write(u'blah')
f.close()
link = True
try:
    p.symlink(fn2)
    link = True
except:
    link = False

p.remove()

if link:
    for f in home.listdir():
        link = usr_home + '/' + f.name
        if link.exists():
            if link.islink() or link.isfile():
                link.remove()
            elif link.isdir():
                link.rmtree()
        f.symlink(link)
else:
    for f in home.files():
        f.copy(usr_home)
    for d in home.dirs():
        cp_path = usr_home + '/' + d.name
        if cp_path.exists():
            cp_path.rmtree()
        d.copytree(cp_path)
