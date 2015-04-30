#!/bin/bash

# Check if config exists. If not, copy in the sample config
if [ -f /opt/calibre/calibre-server ]; then
  echo "Using existing install."
else
  echo "Installing Clean - Apply any Custom Edits"
  cd /opt
  wget --no-check-certificate -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/opt/', True)"
  cp -ar /downloads/calibre-edits/calibre/resources /opt/calibre/
fi
