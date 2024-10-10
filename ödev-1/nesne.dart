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
    print('Lütfen notu girin:');
    String? input = stdin.readLineSync();
    
    if (input == null || input.trim().isEmpty) {
      print('Girdi boş olamaz. Lütfen tekrar deneyin.');
      return;
    }

    try {
      double not = double.parse(input.trim());
      if (not < 0 || not > 100) {
        throw ArgumentError('Notlar 0 ile 100 arasında olmalıdır.');
      }
      notlar.add(not);
      print('Not başarıyla eklendi: $not');
    } catch (e) {
      print('Geçersiz not değeri girdiniz: $e');  
    }
  }

  void ortalamaHesapla() {
    if (notlar.isEmpty) {
      print('Notlar listesi boş. Ortalama hesaplanamaz.');
      return;
    }

    double toplam = notlar.reduce((a, b) => a + b);
    double ortalama = toplam / notlar.length;
    print('$ad $soyad için not ortalaması: $ortalama');
  }
}

void main() {
  try {
    NotSistemi sistem = NotSistemi();

    while (true) {
      print('Bir komut girin: "not ekle" veya "hesapla". Programı bitirmek için "çık" yazabilirsiniz.');
      String? komut = stdin.readLineSync();

      if (komut == null || komut.trim().isEmpty) {
        print('Girdi boş olamaz. Lütfen tekrar deneyin.');
        continue;
      }

      komut = komut.trim().toLowerCase(); .

      if (komut == 'hesapla') {
        try {
          sistem.ortalamaHesapla();  
        } catch (e) {
          print('Hata: $e');  
        }
      }
      else if (komut == 'not ekle') {
        try {
          sistem.notEkle(); 
        } catch (e) {
          print('Hata: $e'); 
        }
      }
      else if (komut == 'çık') {
        print('Programdan çıkılıyor...');
        break;
      }
      else {
        print('Geçersiz komut! Lütfen "not ekle", "hesapla" ya da "çık" yazın.');
      }
    }
  } catch (e) {
    print('Hata: $e');  
  }
}
