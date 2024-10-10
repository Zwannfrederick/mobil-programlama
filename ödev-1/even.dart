import 'dart:io';

List<int> getArrayInput() {
  String? inputArray = stdin.readLineSync();
  List<int> numList = [];

  if (inputArray == null || inputArray.trim().isEmpty) {
    throw ArgumentError('Boş veya geçersiz girdi.');
  }

  try {
    numList = inputArray.split(' ').map((e) {
      try {
        return int.parse(e.trim());
      } catch (e) {
        throw FormatException('Geçersiz değer: $e');
      }
    }).where((number) => number != null).toList(); 
  } catch (e) {
    throw ArgumentError('Hata: Geçersiz bir değer/değerler girdiniz.');
  }

  if (numList.length != 10) {
    throw ArgumentError('Hata: 10 tane sayı girmelisiniz. Dizinizin uzunluğu ${numList.length}.');
  }

  return numList;
}

void main() {
  try {
    List<int> numbers = getArrayInput();
    int evenCounter = 0;

    for (var number in numbers) {
      if (number.isEven) {
        print(number);
        evenCounter++;
      }
    }

    if (evenCounter == 0) {
      print('Dizide herhangi bir çift sayı yok.');
    }
  } catch (e) {
    print('Hata: $e');
  }
}
