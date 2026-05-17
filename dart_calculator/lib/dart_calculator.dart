import 'dart:io';

void main() {
  print('=== Dart Calculator ===');

  var shouldContinue = true;

  while (shouldContinue) {
    final firstNumber = readNumber('Enter the first number: ');
    final operator = readOperator();
    final secondNumber = readNumber('Enter the second number: ');

    final result = calculate(firstNumber, secondNumber, operator);

    if (result == null) {
      print('Cannot divide by zero.');
    } else {
      print('Result: $firstNumber $operator $secondNumber = $result');
    }

    shouldContinue = askToContinue();
  }

  print('Thanks for using the calculator.');
}

double readNumber(String message) {
  while (true) {
    stdout.write(message);
    final input = stdin.readLineSync();
    final number = double.tryParse(input ?? '');

    if (number != null) {
      return number;
    }

    print('Please enter a valid number.');
  }
}

String readOperator() {
  const operators = ['+', '-', '*', '/'];

  while (true) {
    stdout.write('Choose an operator (+, -, *, /): ');
    final operator = stdin.readLineSync()?.trim();

    if (operator != null && operators.contains(operator)) {
      return operator;
    }

    print('Please choose one of these operators: +, -, *, /');
  }
}

double? calculate(double firstNumber, double secondNumber, String operator) {
  switch (operator) {
    case '+':
      return firstNumber + secondNumber;
    case '-':
      return firstNumber - secondNumber;
    case '*':
      return firstNumber * secondNumber;
    case '/':
      if (secondNumber == 0) {
        return null;
      }
      return firstNumber / secondNumber;
    default:
      return null;
  }
}

bool askToContinue() {
  while (true) {
    stdout.write('Do another calculation? (y/n): ');
    final answer = stdin.readLineSync()?.trim().toLowerCase();

    if (answer == 'y' || answer == 'yes') {
      return true;
    }

    if (answer == 'n' || answer == 'no') {
      return false;
    }

    print('Please answer with y or n.');
  }
}
