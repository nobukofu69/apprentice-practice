#!/bin/bash

# 環境変数に定義したパスフレーズを変数に代入
passphrase=$GPG_PASSPHARASE
# 暗号化したパスワードファイルを変数に代入
encrypted_file="managed_passwd.txt.gpg"

echo "パスワードマネージャーへようこそ！"
while : # Exitが入力されるまでループ
do
  read -p "次の選択肢から入力してください(Add Password/Get Password/Exit): " input
  case $input in
    "Add Password" )
      read -p "サービス名を入力してください: " service
      read -p "ユーザー名を入力してください: " user
      read -s -p "パスワードを入力してください: " password

      # 暗号化ファイルがあれば復号して一時ファイルに出力､なければ空ファイルを作成
      if [ -e $encrypted_file ]; then
        gpg -o temp.txt --batch -q -d --passphrase ${passphrase} ${encrypted_file}
      else
        touch temp.txt
      fi

      # 入力したデータを一時ファイルに追加
      echo "$service:$user:$password" >> temp.txt

      # 一時ファイルを暗号化後､暗号化ファイルに上書き(暗号化ファイルがなければ新規作成)
      gpg -o ${encrypted_file} -q --batch --yes --passphrase ${passphrase} -c temp.txt
      
      # 一時ファイルを削除
      rm temp.txt
      
      echo "パスワードの追加は成功しました。"
      ;;
    "Get Password" )
      # 暗号化ファイルがなければループの先頭に戻る
      if [ ! -e $encrypted_file ]; then
        echo "パスワードが登録されていません。"
        continue
      fi

      # 暗号化ファイルを複合して一時ファイルに出力
      gpg -o temp.txt --batch -q -d --passphrase ${passphrase} ${encrypted_file}
      read -p "サービス名を入力してください: " service

      # 一時ファイルからサービス名を検索
      grep_result=$(grep "^${service}:.*:.*$" temp.txt)
      
      # 検索結果があれば､ユーザー名とパスワードを表示｡なければエラーメッセージを表示
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
    "Exit" ) # Exitが入力されたらループを抜ける
      echo "Thank you"
      break
      ;;
    * ) # 上記以外の入力があった場合はエラーメッセージを表示してループの先頭に戻る
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      ;;
  esac
done