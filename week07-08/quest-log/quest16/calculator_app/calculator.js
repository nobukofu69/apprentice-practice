

// HTML要素を取得
let display = document.querySelector('#display');
let buttons = document.querySelector('#buttons');
let clearButton = document.querySelector('#clear');
let equalButton = document.querySelector('#equals');

// 計算に必要な変数を定義
let firstOperand = null;
let currentOperand = null;
let operator = null;

// デバッグ用
console.log(parseFloat(display.textContent));

// ボタン入力のイベントハンドラ
buttons.addEventListener('click', function(e) {
  // イベント発火したbutton要素を取得
  let pressedButton = e.target;
  // button要素のテキスト内容を取得
  let buttonValue = pressedButton.textContent
  
  // 押したbuttonが数字の場合
  if(pressedButton.classList.contains('digit')) {
    // displayが未入力かつ入力したボタンが0の場合,if文を抜けるガード節
    if(display.textContent.length == 0 && buttonValue == '0') {
      return;
    }
    // display未入力､またはdisplayに演算子を含む場合､入力した数字をdisplayに表示
    if(display.textContent.length == 0 || display.textContent.includes(operator)) {
      display.textContent = buttonValue;
    // 0以外の数字が入ってる場合､入力した数字をdisplayに追加する
    } else {
    display.textContent += buttonValue;
    }
  // 押したボタンが演算子の場合
  } else if(pressedButton.classList.contains('operator')) {
    // 数字未入力で演算子ボタンを押した場合､処理を抜ける
    if(display.textContent.length == 0) {return};
    // 演算子のクリック1回目の場合
    if(firstOperand == null) {
      // displayの文字列を数値に変換後､firstOperandに代入
      firstOperand = parseInt(display.textContent);
    // 演算子ボタンを2回続けて押した場合､演算子情報を更新して処理を抜ける
    } else if(display.textContent.includes(operator)) {
      operator = buttonValue;
      display.textContent = firstOperand + " " + operator;
      return;
    // firstOperandとdisplayに数字が入力されている場合､計算する
    } else {
      // displayの文字列を数値に変換後､currentOperandに代入
      currentOperand = parseInt(display.textContent);
      // firstOperand と currentOperand の演算結果を firstOperand に代入
      firstOperand = calculation[operator](firstOperand, currentOperand);
    }
    // 押した演算子情報を取得
    operator = buttonValue;
    // firstOperand の数値を displayに反映
    display.textContent = firstOperand + " " + operator;
  // 押したボタンが equals の場合
  } else if(pressedButton.id == 'equals') {
    // displayの文字列を数値に変換後､currentOperandに代入
    currentOperand = parseInt(display.textContent);
    // firstOperand と currentOperand の演算結果を firstOperand に代入
    display.textContent = calculation[operator](firstOperand, currentOperand);
    // 計算用の変数をクリア
    firstOperand = null;
    currentOperand = null;
    operator = null;
  // 押したボタンがclearの場合
  } else {
    display.textContent = '';
    firstOperand = null;
    currentOperand = null;
    operator = null;
  }
});

let calculation = {
  '+': (firstOperand, currentOperand) => (firstOperand + currentOperand),
  '-': (firstOperand, currentOperand) => (firstOperand - currentOperand),
  '*': (firstOperand, currentOperand) => (firstOperand * currentOperand),
  '/': (firstOperand, currentOperand) => (firstOperand / currentOperand),
}