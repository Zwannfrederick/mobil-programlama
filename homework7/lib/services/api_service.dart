import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  // Öğrencileri getirme
  Future<List> getOgrenciler() async {
    final response = await http.get(Uri.parse('$baseUrl/ogrenci'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Öğrenciler alınamadı');
    }
  }

  // Bölümleri getirme
  Future<List> getBolumler() async {
    // Sabit liste yerine, API'den bölüm verilerini alabiliriz
    return [
      {'BolumAd': 'Bilgisayar Mühendisliği'},
      {'BolumAd': 'Makine Mühendisliği'},
      {'BolumAd': 'Gıda Mühendisliği'},
      {'BolumAd': 'Endüstri Mühendisliği'},
      {'BolumAd': 'Elektrik Elektronik Mühendisliği'},
    ];
  }

  // Yeni öğrenci ekleme
  Future<void> addOgrenci(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ogrenci'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Öğrenci eklenemedi');
    }
  }

  // Öğrenciyi güncelleme
  Future<void> updateOgrenci(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/ogrenci/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Öğrenci güncellenemedi');
    }
  }

  // Öğrenci silme
  Future<void> deleteOgrenci(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/ogrenci/$id'));

    if (response.statusCode != 200) {
      throw Exception('Öğrenci silinemedi');
    }
  }
}
