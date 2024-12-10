import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OgrenciListesi(),
    );
  }
}

class OgrenciListesi extends StatefulWidget {
  const OgrenciListesi({super.key});

  @override
  _OgrenciListesiState createState() => _OgrenciListesiState();
}

class _OgrenciListesiState extends State<OgrenciListesi> {
  final ApiService api = ApiService();
  List ogrenciler = [];
  List bolumler = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchBolumler();
  }

  void fetchData() async {
    try {
      final data = await api.getOgrenciler();
      setState(() {
        ogrenciler = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Veriler alınamadı: $e';
        isLoading = false;
      });
    }
  }

  void fetchBolumler() async {
    try {
      final data = await api.getBolumler();
      setState(() {
        bolumler = data;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Bölümler alınamadı: $e';
      });
    }
  }

  void showForm({Map<String, dynamic>? existingData}) {
    final TextEditingController adController =
        TextEditingController(text: existingData?['Ad'] ?? '');
    final TextEditingController soyadController =
        TextEditingController(text: existingData?['Soyad'] ?? '');
    String selectedBolumAd = existingData?['BolumAd'] ?? bolumler[0]['BolumAd'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text(existingData == null ? 'Öğrenci Ekle' : 'Öğrenci Güncelle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: adController,
                decoration: const InputDecoration(labelText: 'Ad'),
              ),
              TextField(
                controller: soyadController,
                decoration: const InputDecoration(labelText: 'Soyad'),
              ),
              DropdownButtonFormField<String>(
                value: selectedBolumAd,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBolumAd = newValue!;
                  });
                },
                items: bolumler.map<DropdownMenuItem<String>>((bolum) {
                  return DropdownMenuItem<String>(
                    value: bolum['BolumAd'],
                    child: Text(bolum['BolumAd']),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Bölüm'),
                isExpanded: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Kaydet'),
              onPressed: () async {
                final data = {
                  'Ad': adController.text,
                  'Soyad': soyadController.text,
                  'BolumAd': selectedBolumAd,
                };

                if (existingData == null) {
                  await api.addOgrenci(data);
                } else {
                  await api.updateOgrenci(existingData['ogrenciID'], data);
                }
                fetchData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Listesi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showForm(),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: ogrenciler.length,
                  itemBuilder: (context, index) {
                    final ogrenci = ogrenciler[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text('${ogrenci['Ad']} ${ogrenci['Soyad']}'),
                        subtitle: Text(
                          'Bölüm: ${ogrenci['BolumAd'] ?? 'Bilinmiyor'}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => showForm(existingData: ogrenci),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await api.deleteOgrenci(ogrenci['ogrenciID']);
                                fetchData();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
