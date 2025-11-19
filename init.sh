#!/bin/bash
set -e

# init.sh の絶対パスの親ディレクトリを取得
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "BASE_DIR = $BASE_DIR"

# 初回セットアップかどうか
if [ ! -f /root/.initialized ]; then
  echo "初回セットアップを実行中..."

  apt update && apt full-upgrade -y
  apt install -y nano ffmpeg wget git

  wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux \
    -O /usr/local/bin/yt-dlp
  chmod +x /usr/local/bin/yt-dlp

  yt-dlp --version
  touch /root/.initialized

  echo "初回セットアップ完了"
else
  echo "初回セットアップはスキップします"
fi

echo "yt-dlp をアップデート中..."
yt-dlp -U || true

########################################
# ytdlplocalsetting フォルダ処理を自動化
########################################
SET_DIR="$BASE_DIR/ytdlplocalsetting"

if [ -d "$SET_DIR" ]; then
  echo "ytdlplocalsetting のスクリプトを移動: $SET_DIR → /"

  # 権限付与
  chmod +x "$SET_DIR"/*.sh || true

  # root 直下に移動
  mv -f "$SET_DIR"/* / || true

  # フォルダ削除
  rm -rf "$SET_DIR"
else
  echo "ytdlplocalsetting フォルダが見つかりませんでした: $SET_DIR"
fi

########################################
# init.sh 自身を削除
########################################
INIT_PATH="$BASE_DIR/init.sh"
if [ -f "$INIT_PATH" ]; then
  echo "init.sh を削除します: $INIT_PATH"
  rm -f "$INIT_PATH"
fi

echo "初期化処理がすべて完了しました。"

exec bash
