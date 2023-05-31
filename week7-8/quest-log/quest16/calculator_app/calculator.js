// display要素を取得
let display = document.querySelector('#display');
// buttons要素を取得
let buttons = document.querySelector('#buttons');

// 押したボタンがディスプレイエリアに表示

buttons.addEventListener('click',function(e) {
  if(e.target && e.target.classList.contains('digit')) {

    ここから


    // input要素作る
    let input = document.createElement('input');
    // input要素にテキスト情報を追加する
    input.value = e.target.textContent;
    // input要素をdisplayに追加
    display.appendChild(input)

  }
});

// 更にボタンを押すと右側にボタンが追加される

// イコールボタンを押すと演算する

// 演算結果をひょうじする

// クリアボタンを押すと表示領域がクリアされる