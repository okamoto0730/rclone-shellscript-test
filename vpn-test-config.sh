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


cd $HOME/easy-rsa/pki/private/
rclone copy "$1".key dtest:

cd $HOME/easy-rsa/pki/reqs/
rclone copy "$1".req dtest:


#ovpn(OpenVPNのツールを利用している前提)ファイルを対象クライアント用に作成
cd $HOME/ovpnfile/
cp downloaded-client-config.ovpn "$1".ovpn

#サーバー内で発行した「.crt」「.key」ファイルを移動させる。「openvpn」は移動先のディレクトリを指定する。例として記載
cd $HOME/easy-rsa/pki/issued/
mv -i "$1".crt $HOME/openvpn/

cd $HOME/easy-rsa/pki/private/
mv -i "$1".key $HOME/openvpn/

#ovpnファイルも、移動させる。
cd $HOME/ovpnfile/
mv -i "$1".ovpn $HOME/openvpn/

#下記のディレクトリに移動して、
cd $HOME/openvpn/

#ovpnファイルを「BUILDCONFIG_FILE」として、置き換える。
BUILDCONFIG_FILE="$1".ovpn

#下記の追記が上手くいかない。確認中
sed -e 'nobinda key [INLINE]\persist-key\persist-tun' ${BUILDCONFIG_FILE}
#sed -e "/key [INLINE]/i \persist-key" >> ${BUILDCONFIG_FILE}
#sed -e "/persist-key/i \persist-tun" >> ${BUILDCONFIG_FILE}
#sed '3a aaaaaaaaa\nbbbbbbbbb' test.txt

#置き換えた「BUILDCONFIG_FILE」の最後の行に【cert】を追記する
echo "<cert>" >> ${BUILDCONFIG_FILE}
openssl x509 -in "$1".crt -outform PEM >> ${BUILDCONFIG_FILE}
echo "</cert>" >> ${BUILDCONFIG_FILE}

#置き換えた「BUILDCONFIG_FILE」の最後の行に【key】を追記する
echo "<key>" >> ${BUILDCONFIG_FILE}
cat "$1".key >> ${BUILDCONFIG_FILE}
echo "</key>" >> ${BUILDCONFIG_FILE}




#指定したファイルからファイルへ、特定行の文字列だけコピー＆ペーストする方法を、調査する。下記は例
#head -84 okamoto-kzk-test0518.crt | tail -19 | > okamoto-kzk-test0518.ovpn

#これはテストです。メモ
#test1=/c/Users/デスクトップ/github-remote/github-test

#"〇〇"と、ダブルクォーテーション内の記述が実行される。メモ
#echo "cd $test1"

#${〇〇}と、{}内の記述が実行される。メモ
#echo ${test1}_backup
