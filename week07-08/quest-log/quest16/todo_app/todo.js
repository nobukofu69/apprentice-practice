
// 1. TODO アプリ

// submitのイベント発生
let form = document.getElementById('form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  // 入力フォームの値を取得
  let text = document.getElementById('todo-input').value;

  // li作成 & テキストノードに入力フォームの値を代入
  let li = document.createElement('li');
  li.textContent = text;

  // checkboxを作成 & liに追加
  let checkbox = document.createElement('input');
  checkbox.type = "checkbox";
  li.appendChild(checkbox);

  // span要素を作成 & liに追加
  let span = document.createElement('span');
  span.textContent = 'TODO';
  li.appendChild(span);

  // 削除ボタンを作成 & liに追加
  let button = document.createElement('button');
  button.textContent = '削除';
  button.className = 'delete-button';
  li.appendChild(button);
  
  // ul要素取得 & li追加
  let ul = document.getElementById('todo-list')
  ul.appendChild(li);

  // 入力フォームの値を空白にする
  document.getElementById('todo-input').value = '';
},);

// 削除ボタンのイベントハンドラ
document.addEventListener('click', function(e) {
  // イベントを発生させた要素 && この要素に delete-buttonという要素があればtrue
  if(e.target && e.target.classList.contains('delete-button')) {
    // 'delete-button'がクリックされた場合、その親要素のliを削除します。
    e.target.parentNode.remove();
  }
});

// チェックを入れた場合のイベントハンドラ
ul = document.querySelector('#todo-list');
ul.addEventListener('change', function(e) {
  // event.targetはイベントが発生した具体的な要素を参照します。
  // ここでは、typeが"checkbox"の<input>要素が対象となります。
  let targetCheckbox = e.target;
  // イベントが発生した要素がチェックボックスであるかを確認
  if (targetCheckbox.type === 'checkbox') {
    if (targetCheckbox.checked) {
    // チェックされたら親要素の li に取り消し線を引く
    targetCheckbox.parentNode.style.textDecoration = 'line-through';
    } else {
      // チェックが外れたら li の取り消し線を消す
      targetCheckbox.parentNode.style.textDecoration  = 'none';
    }
  }
});