#!/bin/bash

# 環境変数に定義したパスフレーズ
passphrase=$GPG_PASSPHARASE
# パスワードファイル
encrypted_file="managed_passwd.txt.gpg"

echo "パスワードマネージャーへようこそ！"
while :
do
  read -p "次の選択肢から入力してください(Add Password/Get Password/Exit): " input
  case $input in
    "Add Password" )
      read -p "サービス名を入力してください: " service
      read -p "ユーザー名を入力してください: " user
      read -s -p "パスワードを入力してください: " password

      # 暗号化ファイルがあれ複合して一時ファイルに出力､なければ空ファイルを作成
      if [ -e $encrypted_file ]; then
        gpg -o temp.txt --batch -q -d --passphrase ${passphrase} ${encrypted_file}
      else
        touch temp.txt
      fi

      # 入力したデータを一時ファイルに追加
      echo "$service:$user:$password" >> temp.txt

      # 一時ファイルを暗号化後､元の暗号化ファイルに上書き
      gpg -o ${encrypted_file} -q --batch --yes --passphrase ${passphrase} -c temp.txt
      
      # 一時ファイルを削除
      rm temp.txt
      
      echo "パスワードの追加は成功しました。"
      ;;
    "Get Password" )
      # 暗号化ファイルがなければ終了
      if [ ! -e $encrypted_file ]; then
        echo "パスワードが登録されていません。"
        exit 1
      fi

      # 暗号化ファイルを複合して一時ファイルに出力
      gpg -o temp.txt --batch -q -d --passphrase ${passphrase} ${encrypted_file}
      read -p "サービス名を入力してください: " service

      # 一時ファイルからサービス名を検索
      grep_result=$(grep -w $service temp.txt)
      
      # 検索結果があれば､ユーザー名とパスワードを表示
      if [ $? = 0 ]; then
        service=$(echo "$grep_result" | sed -E 's/^(.+):(.+):(.+)$/\1/')
        user=$(echo "$grep_result" | sed -E 's/^(.+):(.+):(.+)$/\2/')
        password=$(echo "$grep_result" | sed -E 's/^(.+):(.+):(.+)$/\3/')
        echo -e "サービス名:$service\nユーザー名:$user\nパスワード:$password"
      else
        echo "そのサービスは登録されていません。"
      fi
      rm temp.txt
      ;;
    "Exit" )
      echo "Thank you"
      break
      ;;
    * )
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      ;;
  esac
done