import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiService {
  late final String baseUrl;

  ApiService() {
    if (kIsWeb) {
      baseUrl = 'http://localhost:3000';
    } else {
      baseUrl =
          Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
    }
  }

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
