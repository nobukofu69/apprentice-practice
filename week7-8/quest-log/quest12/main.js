// 1. 書籍プリンター
function printBooks(books) {
  for(let [key, value] of Object.entries(books)) {
    console.log(`『${key}』${value}`);
  }
}

// 2. ユーザーパーミッションチェッカー
function checkPermission(username, permission) {
  for(let user of users) {
    if(user.username == username) {
      for(let permissionKey in user.permissions) {
        if(permissionKey == permission) {
          console.log(user.permissions[permission]);
        }
      }
    }
  }
}