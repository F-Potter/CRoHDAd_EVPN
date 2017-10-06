#!/bin/bash

# Finish Function runs when the Container is being Stopped.
function finish {
  echo "CAUGHT A SIGNAL: stopping CRoHDAd"
  crohdad_proc=$(ps aux | grep crohdad.py | grep -v "grep" | awk '{print $2}')
  echo "CRoHDAd ProcID is: $crohdad_proc"
  kill $crohdad_proc &> /dev/null
  ps aux | grep crohdad.py | grep -v "grep"
  exit 0
}

trap finish HUP INT QUIT TERM

echo "RUNNING CRoHDAd: /root/crohdad.py $@ &"
/root/crohdad.py "$@" &

sleep 2
# Waiting Forever or Until Someone Presses Enter to Stop the Container
echo -e "\n\n[hit enter key to exit] or run 'docker stop <container>'"
read

# stop service and clean up here
echo "STOPPING CRoHDAd..."
crohdad_proc=$(ps aux | grep crohdad.py | grep -v "grep" | awk '{print $2}')
echo "CRoHDAd ProcID is: $crohdad_proc"
kill $crohdad_proc &> /dev/null
ps aux | grep crohdad.py | grep -v "grep"
echo "Done."
echo "exited $0"
exit 0
