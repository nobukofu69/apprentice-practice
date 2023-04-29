#!/bin/bash

# パスフレーズ
passphrase=$GPG_PASSPHARASE
# パスワードが保存されたファイル
encrypted_file="managed_passwd.txt.gpg"

# 暗号化ファイルを複合
decrypted_output=$(gpg -q -d --batch --passphrase ${passphrase} ${encrypted_file})

echo "パスワードマネージャーへようこそ！"

while true; do
  echo "次の選択肢から入力してください([1]Add Password/[2]Get Password/[3]Exit)："
  read input
  
  if [ "$input" = 1 ]; then
    echo "サービス名を入力してください:"
    read service
    echo "ユーザー名を入力してください:"
    read user
    echo "パスワードを入力してください:"
    read -s password

    # 入力したデータを復号したファイルに追加
    update_output="${decrypted_output}"$'\n'$"$service:$user:$password"
    # 更新されたファイルを一時ファイルにリダイレクト
    printf "%s\n" "$update_output" > temp.txt
    
    # 一時ファイルを暗号化後､元の暗号化ファイルに上書き
    gpg --batch -q --yes -o ${encrypted_file} --passphrase ${passphrase} -c temp.txt
    
    # 一時ファイルを削除
    rm temp.txt
    echo "パスワードの追加は成功しました。"
    # 更新された情報を decrypted_output に反映させる
    # これでスクリプト起動時の状態から更新｡
    decrypted_output=${update_output}
    
  elif [ "$input" = 2 ]; then

    echo "サービス名を入力してください:"
    read service
    # 復号したファイルのエントリ内からサービスを探す
    matched_line=$(printf "%s\n" ${decrypted_output} | grep -w $service)
    
    # サービスが存在したら
    if [ $? = 0 ]; then
      service=$(echo "$matched_line" | sed -E 's/^(.+):(.+):(.+)$/\1/')
      user=$(echo "$matched_line" | sed -E 's/^(.+):(.+):(.+)$/\2/')
      password=$(echo "$matched_line" | sed -E 's/^(.+):(.+):(.+)$/\3/')
      echo "サービス名:$service"
      echo "ユーザー名:$user"
      echo "パスワード:$password"
    else
      echo "そのサービスは登録されていません。"
    fi
  
  elif [ "$input" = 3 ]; then
    echo "Thank you"
    break
  else 
    echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
  fi
done