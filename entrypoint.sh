#!/bin/bash
set -e

# Rails特有の問題（サーバーが異常終了した時に残るPIDファイル）を解決する
rm -f /app/tmp/pids/server.pid

# DockerfileのCMD（rails server）を実行する
exec "$@"
