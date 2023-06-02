// 必要なHTML要素を取得します
const display = document.getElementById("display");
const buttons = document.getElementById("buttons");
const clearButton = document.getElementById("clear");
const equalsButton = document.getElementById("equals");

// 計算に必要な変数を定義します
let firstOperand = null;
let operator = null;
let waitingForSecondOperand = false;

buttons.addEventListener('click', function(event) {
  // クリックされた要素がボタンでなければ無視します
  if (!event.target.matches('button')) {
    return;
  }

  const targetButton = event.target;
  const buttonValue = targetButton.textContent;

  if (targetButton.classList.contains('digit')) {
    // 数字ボタンが押されたときの動作
    if (waitingForSecondOperand) {
      display.textContent = buttonValue;
      waitingForSecondOperand = false;
    } else {
      display.textContent = display.textContent === '0' ? buttonValue : display.textContent + buttonValue;
    }
  } else if (targetButton.classList.contains('operator')) {
    // 演算子ボタンが押されたときの動作
    if (firstOperand === null) {
      firstOperand = parseFloat(display.textContent);
    } else if (operator) {
      const currentOperand = parseFloat(display.textContent);
      firstOperand = performCalculation[operator](firstOperand, currentOperand);
      display.textContent = firstOperand;
    }
    waitingForSecondOperand = true;
    operator = buttonValue;
  }
});

clearButton.addEventListener('click', function() {
  // 全ての状態をリセットします
  display.textContent = '0';
  firstOperand = null;
  waitingForSecondOperand = false;
  operator = null;
});

equalsButton.addEventListener('click', function() {
  // 現在の操作を完了し、結果を表示します
  if (operator && !waitingForSecondOperand) {
    const currentOperand = parseFloat(display.textContent);
    firstOperand = performCalculation[operator](firstOperand, currentOperand);
    operator = null;
    waitingForSecondOperand = false;
    display.textContent = firstOperand;
  }
});

// 演算子ごとの計算を行う関数のオブジェクトです
const performCalculation = {
  '+': (firstOperand, secondOperand) => firstOperand + secondOperand,
  '-': (firstOperand, secondOperand) => firstOperand - secondOperand,
  '*': (firstOperand, secondOperand) => firstOperand * secondOperand,
  '/': (firstOperand, secondOperand) => firstOperand / secondOperand,
};
s