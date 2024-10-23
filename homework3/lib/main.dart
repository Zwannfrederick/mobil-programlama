import 'package:flutter/material.dart';

// Uygulamanın başlangıç noktası
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sağlık Uygulaması',
      home: MyHomePage(text: "Firmalar"), // Ana sayfa için başlangıç metni
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.text});
  final String text; // Ana sayfada kullanılacak metin

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF08006c),
                Color(0xFF706dd1), // Arka plan için gradyan rengi
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back), // Geri butonu
                  color: Colors.white,
                  onPressed: () {}, // Butona basıldığında yapılacak işlem
                ),
              ),
              Center(
                child: Text(
                  widget.text, // Başlık metni
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300, // Yazı tipi stili
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding:
            const EdgeInsets.all(4.0), // Ana içerik alanının kenar boşlukları
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: HealthSection(text: 'Sağlık'), // Sağlık bölümü
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: SearchSection(text: 'Firma Ara'), // Arama bölümü
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: TextSection(), // Metin bölümü
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: AdvertSection(
                text: 'Firma Adı Uzun Firma Adı', // Reklam bölümü
                percentage: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: AdvertSection(
                text: 'Firma Adı',
                percentage: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: AdvertSection(
                text: 'Firma Adı Uzun Firma Adı',
                percentage: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: AdvertSection(
                text: 'Firma Adı',
                percentage: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: AdvertSection(
                text: 'Firma Adı Uzun Firma Adı',
                percentage: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16.0), // Kenar boşlukları
      child: const Text(
        'İstediğiniz firmada indirim yakalama fırsatı...',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.w300, // Yazı tipi stili
        ),
        textAlign: TextAlign.left, // Metin hizalaması
      ),
    );
  }
}

class HealthSection extends StatelessWidget {
  final String text;

  const HealthSection({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Genişlik ayarı
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Köşe yuvarlama
        gradient: const LinearGradient(
          colors: [
            Color(0xFF08006c),
            Color(0xFF706dd1), // Arka plan için gradyan rengi
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // İç boşluk
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/healthicon.png', // Sağlık simgesi
              width: 30,
              height: 30,
            ),
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold, // Yazı tipi stili
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Köşe yuvarlama
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Gölge rengi
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Gölge konumu
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0), // İç boşluk
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14), // Arama simgesi dönüşü
            child: Image.asset(
              'assets/images/searchicon.jpg',
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(width: 8), // Boşluk
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: Colors.grey, // Yazı rengi
              ),
              decoration: InputDecoration(
                hintText: text, // Girdideki ipucu metni
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none, // Kenar çerçevesi yok
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8.0), // İç boşluk
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdvertSection extends StatelessWidget {
  final String text;
  final int percentage;

  const AdvertSection({
    super.key,
    required this.text,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          (percentage / 100), // Yükseklik yüzdesi
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Köşe yuvarlama
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Gölge rengi
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Gölge konumu
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.label_important_outline_rounded,
              size: 30,
              color: Colors.black, // İkon rengi
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // Yazı tipi stili
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF08006c),
                  Color(0xFF706dd1), // Arka plan için gradyan rengi
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12), // Köşe yuvarlama
              ),
            ),
            child: Center(
              child: Text(
                "$percentage%", // Yüzde gösterimi
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // Yazı tipi stili
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
