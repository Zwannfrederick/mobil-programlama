import 'dart:io';

class NotSistemi {
  String ad = ''; 
  String soyad = ''; 
  List<double> notlar = [];

  NotSistemi() {
    print('Lütfen Ad ve Soyadınızı girin: ');
    String? input = stdin.readLineSync();
    if (input == null || input.trim().isEmpty) {
      throw FormatException('Boş veya geçersiz isim.');
    }
    List<String> inputs = input.split(" ");
    if (inputs.length < 2) {
      throw FormatException('Ad ve soyad formatına uygun girilmelidir. Örn: Ad Soyad');
    }
    soyad = inputs.last.trim(); 
    ad = inputs.sublist(0, inputs.length - 1).join(" "); 
  }

  void notEkle() {
    print('Lütfen notları girin (örnek: 80 90): ');
    String? input = stdin.readLineSync();
    
    if (input == null || input.trim().isEmpty) {
      throw ArgumentError('Not girişi boş olamaz.');
    }

    List<String> inputs = input.split(" ");
    
    try {
      notlar = inputs.map((e) {
        double not = double.parse(e.trim());
        if (not < 0 || not > 100) {
          throw ArgumentError('Notlar 0 ile 100 arasında olmalıdır: $not');
        }
        return not;
      }).toList();

      if (notlar.length < 2) {
        throw ArgumentError('En az 2 not girişi gerekmektedir.');
      }

    } catch (e) {
      throw FormatException('Geçersiz not değeri girdiniz: $e');
    }
  }

  void ortalamaHesapla() {
    if (notlar.isEmpty) {
      throw ArgumentError('Notlar listesi boş. Ortalama hesaplanamaz.');
    }

    double toplam = notlar.reduce((a, b) => a + b);
    double ortalama = toplam / notlar.length; 
    print('$ad $soyad için not ortalaması: $ortalama');
  }
}

void main() {
  try {
    NotSistemi sistem = NotSistemi();
    sistem.notEkle();
    sistem.ortalamaHesapla();
  } catch (e) {
    print('Hata: $e');
  }
}
