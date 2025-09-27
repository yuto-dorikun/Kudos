#!/bin/bash
set -e

# PIDファイル削除
rm -f /app/tmp/pids/server.pid

# node_modulesチェック
if [ ! -d "node_modules" ] && [ -f "package.json" ]; then
  echo "Installing node modules..."
  yarn install
fi

# bundleチェック
if [ -f "Gemfile" ]; then
  echo "Checking gems..."
  bundle check || bundle install
fi

# コマンド実行
exec "$@"