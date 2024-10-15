import 'dart:io';

class NotSistemi {
  String ad = ''; 
  String soyad = ''; 
  List<double> notlar = [];

  NotSistemi() {
    print('Please enter your first and last name: ');
    String? input = stdin.readLineSync();
    if (input == null || input.trim().isEmpty) {
      throw FormatException('Invalid input. Name cannot be empty.');
    }
    List<String> inputs = input.split(" ");
    if (inputs.length < 2) {
      throw FormatException('Please enter in the format: First Last');
    }
    soyad = inputs.last.trim(); 
    ad = inputs.sublist(0, inputs.length - 1).join(" "); 
  }

  void notEkle() {
    print('Please enter a grade:');
    String? input = stdin.readLineSync();
    
    if (input == null || input.trim().isEmpty) {
      print('Input cannot be empty. Please try again.');
      return;
    }

    try {
      double not = double.parse(input.trim());
      if (not < 0 || not > 100) {
        throw ArgumentError('Grades must be between 0 and 100.');
      }
      notlar.add(not);
      print('Grade successfully added: $not');
    } catch (e) {
      print('Invalid grade value entered: $e');  
    }
  }

  void ortalamaHesapla() {
    if (notlar.isEmpty) {
      print('Grade list is empty. Cannot calculate average.');
      return;
    }

    double toplam = notlar.reduce((a, b) => a + b);
    double ortalama = toplam / notlar.length;
    print('Average grade for $ad $soyad: $ortalama');
  }
}

void main() {
  try {
    NotSistemi sistem = NotSistemi();

    while (true) {
      print('Enter a command: "add grade" or "calculate". Type "exit" to quit the program.');
      String? command = stdin.readLineSync();

      if (command == null || command.trim().isEmpty) {
        print('Input cannot be empty. Please try again.');
        continue;
      }

      command = command.trim().toLowerCase();  

      if (command == 'calculate') {
        sistem.ortalamaHesapla();  
      }
      else if (command == 'add grade') {
        sistem.notEkle(); 
      }
      else if (command == 'exit') {
        print('Exiting the program...');
        break;
      }
      else {
        print('Invalid command! Please enter "add grade", "calculate", or "exit".');
      }
    }
  } catch (e) {
    print('Error: $e');  
  }
}


