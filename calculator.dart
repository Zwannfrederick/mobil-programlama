import 'dart:io';

List<String> getInput() {
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    throw FormatException('Boş veya geçersiz girdi.');
  }

  List<String> inputs = input.split(" ");

  if (inputs.length != 3) {
    throw ArgumentError('3 argüman girişi gerekmektedir. Beklenen format: <sayı1> <işlem> <sayı2>.');
  }

  return inputs; 
}

void main() {
  try {
    List<String> inputs = getInput();
    String op = inputs[1].trim(); 
    double num1;
    double num2;

    try {
      num1 = double.parse(inputs[0].trim());
    } catch (e) {
      throw FormatException('Geçersiz birinci sayı: ${inputs[0]}');
    }

    try {
      num2 = double.parse(inputs[2].trim());
    } catch (e) {
      throw FormatException('Geçersiz ikinci sayı: ${inputs[2]}');
    }

    switch (op) {
      case "/":
        if (num2 == 0) {
          throw ArgumentError('Hata: Bir sayı sıfıra bölünemez.');  
        }
        print("İşleminizin sonucu: ${num1 / num2}");
        break;
      case "*":
        print("İşleminizin sonucu: ${num1 * num2}"); 
        break;
      case "+":
        print("İşleminizin sonucu: ${num1 + num2}");
        break;
      case "-":
        print("İşleminizin sonucu: ${num1 - num2}");
        break;
      default:
        throw ArgumentError('Geçersiz işlem operatörü: $op. Desteklenen işlemler: +, -, *, /');  
    }
  } catch (e) {
    print('Hata: $e');
  }
}
