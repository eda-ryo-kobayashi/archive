# archive
特定のファイル・フォルダを抽出してzipにまとめる

## コピー先設定

- ARCHIVE_DIRECTORY : zipファイル出力先ディレクトリ名
- DIR_NAME : ファイルコピー先ディレクトリ名

## コピーファイルの設定

- cpx : コピーするファイル・ディレクトリを設定

例)

cpx .hidden</br>
cpx test1</br>
cpx testdir


## 記述例1

ARCHIVE_DIRECTORY=archive</br>
DIR_NAME=test_$(date +%Y%m%d_%H%M%S)

…

cpx .hidden</br>
cpx test1</br>
cpx testdir

## 記述例2

ARCHIVE_DIRECTORY=archive/abc/def</br>
DIR_NAME=app_$(date +%Y%m%d)

…

cpx .gitignore</br>
cpx app</br>
cpx build.gradle

…
