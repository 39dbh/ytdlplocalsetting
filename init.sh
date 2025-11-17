#!/bin/bash
set -e

# マーカーで初回かどうか判断
if [ ! -f /root/.initialized ]; then
  echo "初回セットアップを実行中..."
  apt update && apt full-upgrade -y
  apt install -y nano ffmpeg wget git
  wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux -O /usr/local/bin/yt-dlp
  chmod +x /usr/local/bin/yt-dlp
  yt-dlp --version
  touch /root/.initialized
  echo "初回セットアップ完了"
else
  echo "初回セットアップはスキップします"
fi

# 起動時に毎回 yt-dlp 更新チェック
echo "yt-dlp をアップデート中..."
yt-dlp -U || true

#権限
chmod +x y.sh
chmod +x s.sh
chmod +x w.sh
chmod +x j.sh

# 対話シェルに入る
exec bash
