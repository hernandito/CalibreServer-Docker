#!/bin/bash

# Check if config exists. If not, copy in the sample config
if [ -f /opt/calibre/calibre-server ]; then
  echo "Using existing install."
  /opt/calibre/calibre-server --with-library /config --username $CALUSER --password $CALPASSWORD
else
  echo "Installing Clean - Apply any Custom Edits"
  cd /opt
  wget --no-check-certificate -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/opt/', True)"
  cp -ar /downloads/calibre-edits/calibre/resources/content_server /opt/calibre/resources/
  /opt/calibre/calibre-server --with-library /config --username $CALUSER --password $CALPASSWORD
fi

echo "Defining Cron job from crons.conf "
crontab /root/crons.conf
echo "Launching Cron"
cron
echo "Done"
