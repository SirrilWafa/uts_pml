import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ePesantren'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Nama santri
            const Text(
              'Ivan Deni\n5 Zubair bin \'Awwam',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Saldo Tabungan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                children: [
                  const Text(
                    'Saldo Tabungan',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Rp 2.051.834',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009464),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Fungsi setor tabungan
                    },
                    child: const Text('Setor Tabungan'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tombol aksi
            Row(
              children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.payment),
                      onPressed: () {
                        // Fungsi bayar
                      },
                    ),
                    const Text('Bayar'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.book),
                      onPressed: () {
                        // Fungsi tahfidz
                      },
                    ),
                    const Text('Tahfidz'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        // Fungsi donasi
                      },
                    ),
                    const Text('Donasi'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Daftar informasi
            const Text(
              'Informasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/image1.jpg'), // Ganti dengan gambar yang sesuai
                    ),
                    title: Text('Gunakan Aplikasi ePesantren'),
                    subtitle: Text('Senin, 6 Mei 2024 14.59'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/image2.jpg'), // Ganti dengan gambar yang sesuai
                    ),
                    title: Text('Notif WA'),
                    subtitle: Text('Senin, 6 Mei 2024 14.57'),
                  ),
                  // Tambahkan lebih banyak item jika perlu
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
