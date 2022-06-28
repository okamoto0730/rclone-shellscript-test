# rclone-shellscript-test

注意点：改行コードにより、エラーが発生する場合もあります。
・エラー例：line 2: $'\r': command not found

元ファイルの改行コードが「CR + LF」だった為、エラーとなっていた。※Windows端末で、shファイルを作成していた為。

元ファイルの改行コードを【LF】に変換して上書き保存すれば解決する。　※Visual Studio Codeのアプリ等で、簡単に変換可能。
参考URL：https://tooljp.com/qa/bash-r-command-not-found-96A8.html
