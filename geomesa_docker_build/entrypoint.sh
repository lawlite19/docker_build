#!/usr/bin/env bash
set -x
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x


export JAVA_HOME="${JAVA_HOME:-/usr}"

echo "================================================================================"
echo "                              Geomesa-Hbase Docker Container"
echo "================================================================================"
echo

start_geomesa_hbase_shell(){
    echo "geomesa-hbase shell"
    "$GEOMESA_HBASE_HOME/bin/geomesa-hbase"
}

trap_func(){
    echo -e "\n\nShutting down HBase:"
    "$HBASE_HOME/bin/hbase-daemon.sh" stop rest || :
    "$HBASE_HOME/bin/hbase-daemon.sh" stop thrift || :
    "$HBASE_HOME/bin/local-regionservers.sh" stop 1 || :
    # let's not confuse users with superficial errors in the Apache HBase scripts
    "$HBASE_HOME/bin/stop-hbase.sh" |
        grep -v -e "ssh: command not found" \
                -e "kill: you need to specify whom to kill" \
                -e "kill: can't kill pid .*: No such process"
    sleep 2
}
trap trap_func INT QUIT TRAP ABRT TERM EXIT

if [ -n "$*" ]; then
    if [ "$1" = bash ]; then
        bash
    elif [ "$1" = shell ]; then
        start_geomesa_hbase_shell 
    else
        echo "usage:  must specify one of: shell, bash"
    fi
else
    if [ -t 0 ]; then
        start_geomesa_hbase_shell
    else
        echo " Running non-interactively, will not open HBase shell For HBase shell start this image with 'docker run -t -i' switches"
        tail -f /dev/null "$HBASE_HOME/logs/"* &
        # this shuts down from Control-C but exits prematurely, even when +euo pipefail and doesn't shut down HBase
        # so I rely on the sig trap handler above
    fi
fi
wait || :
