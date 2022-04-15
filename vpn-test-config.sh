#!/bin/bash

#置き換えの値
echo "\$1 = $1"


#対象のディレクトリに移動する
cd $HOME/easy-rsa

#クライアント証明書を発行する
./easyrsa build-client-full "$1" nopass





#これはテストです
test1=/c/Users/デスクトップ/github-remote/github-test

#"〇〇"と、ダブルクォーテーション内の記述が実行される
echo "cd $test1"

#${〇〇}と、{}内の記述が実行される
echo ${test1}_backup
