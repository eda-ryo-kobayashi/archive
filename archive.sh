#!/bin/bash
####################
# 定数
####################
# アーカイブディレクトリ
ARCHIVE_DIRECTORY=archive
# ディレクトリ名
# Y:年 m:月 d:日 H:時 M:分 S:秒
DIR_NAME=test_$(date +%Y%m%d_%H%M%S)

# アーカイブターゲットディレクトリまでのパス(ここはいじらない)
TARGET_PATH=$ARCHIVE_DIRECTORY/$DIR_NAME

####################
# 関数
####################
# アーカイブ先ディレクトリを作成
createBuildDir() {
  local dir=( `echo $TARGET_PATH | tr '/' '\n'` )
  toDir="."
  for d in ${dir[@]}; do
    toDir=$toDir/$d
    if [ ! -e $toDir ]; then
      mkdir $toDir
    fi
  done
}

# ディレクトリコピー
cpDirNotify() {
  cp -r $1 $TARGET_PATH
  echo copy $1
}
cpDirExNotify() {
  rsync -a $1 $TARGET_PATH/ --exclude $2
  echo copy $1
}
# ファイルコピー
cpNotfiy() {
  cp $1 $TARGET_PATH
  echo copy $1
}

# ファイルかディレクトリか勝手に判断してコピーする
cpx() {
  if [[ -d $1 ]]; then
    if [ $# -ge 2 ]; then
      cpDirExNotify $1 $2
    else
      cpDirNotify $1
    fi
  elif [[ -f $1 ]]; then
    cpNotfiy $1
  else
    echo ********* $1 doesn\'t exist ! **********
    exit 1
  fi
}

####################
# メイン処理
####################
# まずディレクトリを作る
createBuildDir

############# 特定のファイルをコピー(ここを色々変える) #############
cpx .hidden
cpx test1
cpx test2
cpx testdir
#############################################################

# zip
cd $ARCHIVE_DIRECTORY
zip -r $DIR_NAME.zip $DIR_NAME
# お掃除(ターゲットディレクトリを消したくない場合[rm -rf $DIR_NAME]を消す)
rm -rf $DIR_NAME
# 元の場所に戻る
cd -

# eof
