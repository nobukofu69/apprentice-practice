// 2. 要素ノードの変更
document.querySelector('h1').innerText = 'シンプルブログ';

// // 3. イベントハンドラの設定
let form = document.getElementById('post-form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  let title = document.getElementById('title').value;
  let content = document.getElementById('content').value;
  console.log(title);
  console.log(content);
});

// // 4. 要素ノードの追加
let form = document.getElementById('post-form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  let title = document.getElementById('title').value;
  let content = document.getElementById('content').value;
  // id 'posts'を取得
  let div = document.getElementById('posts');
  // h2要素,テキストノードを作成・divに追加
  let h2 = document.createElement('h2');
  h2.textContent = title;
  div.appendChild(h2);
  // p要素,テキストノードを作成・divに追加
  let p = document.createElement('p');
  p.textContent = content;
  div.appendChild(p);
});

// 5. submitイベント後､入力フォームを空白にする
let form = document.getElementById('post-form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  document.getElementById('title').value = ''
  document.getElementById('content').value = ''
});

// 6. スタイルの変更
let form = document.getElementById('post-form');
// マウスオーバー時の処理
form.addEventListener('mouseover', (event) => {
  form.style.backgroundColor = 'yellow';
});
// 要素から離れたときの処理
form.addEventListener('mouseleave', (event) => {
  form.style.backgroundColor = 'white';
});


// 7. 要素ノードの削除
let form = document.getElementById('post-form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  let title = document.getElementById('title').value;
  let content = document.getElementById('content').value;
  // id 'posts'を取得
  let div = document.getElementById('posts');
  // h2要素,テキストノードを作成・divに追加
  let h2 = document.createElement('h2');
  h2.textContent = title;
  div.appendChild(h2);
  // divの子要素が3つを超えたら､古い要素から一つ消していく
  if(div.childElementCount > 3) {
    div.firstElementChild.remove();
  }
});