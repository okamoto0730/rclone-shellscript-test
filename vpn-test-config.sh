#!/bin/bash

#実行コマンド
#bash vpn-test-config.sh {okamoto-kzk-test5}=$1の出力の値。要するにクライアント証明書の名。

#置き換えの値
echo "\$1 = $1"

#対象のディレクトリに移動する
cd $HOME/easy-rsa

#クライアント証明書を発行する
./easyrsa build-client-full "$1" nopass


#発行されたcrt情報を、rcloneで同期済みのGoogleDriveにコピー。※rclone事前設定済みを想定。
#参照URL：https://www.nextdoorwith.info/wp/se/how-to-control-google-drive-from-linux-rclone/　の「ファイルのアップロード・ダウンロード」項目

#サーバー内でcrt情報が格納されているディレクトリ
cd $HOME/easy-rsa/pki/issued/

#対象のGoogleDriveにコピー。「dtest」は、rcloneとGoogleDriveの同期の際に設定した、name となります。
rclone copy "$1".crt dtest:





#これはテストです
#test1=/c/Users/デスクトップ/github-remote/github-test

#"〇〇"と、ダブルクォーテーション内の記述が実行される
#echo "cd $test1"

#${〇〇}と、{}内の記述が実行される
#echo ${test1}_backup
