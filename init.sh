#!/bin/bash
set -e

BASE_DIR="$(dirname "$0")"

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
if [ -d "$BASE_DIR/ytdlplocalsetting" ]; then
  echo "ytdlplocalsetting のスクリプトを移動中..."

  # chmod +x を確実に実行
  chmod +x "$BASE_DIR"/ytdlplocalsetting/*.sh || true

  # ルート直下に移動（既存ファイルは上書き）
  mv -f "$BASE_DIR"/ytdlplocalsetting/* / || true

  # 元フォルダ削除
  rm -rf "$BASE_DIR/ytdlplocalsetting"
else
  echo "ytdlplocalsetting フォルダが見つかりませんでした"
fi

########################################
# init.sh 自身を削除
########################################
INIT_PATH="$BASE_DIR/init.sh"
if [ -f "$INIT_PATH" ]; then
  echo "init.sh を削除します"
  rm -f "$INIT_PATH"
fi

echo "初期化処理がすべて完了しました。"

# bash で対話シェルへ
exec bash
