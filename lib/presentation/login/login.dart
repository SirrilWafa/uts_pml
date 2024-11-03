import 'package:epesantren_pml/presentation/home.dart';
import 'package:epesantren_pml/presentation/login/lupa_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController kodePesantrenController = TextEditingController();
  final TextEditingController nisController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    kodePesantrenController.dispose();
    nisController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String kodePesantren = kodePesantrenController.text;
    String nis = nisController.text;
    String password = passwordController.text;

    if (kodePesantren.isEmpty || nis.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi semua data login')),
      );
      return;
    }

    try {
      // URL endpoint API Laravel Anda
      final url = Uri.parse('http://10.0.2.2:8000/api/login');

      // Mengirim request POST ke API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'kode_pesantren': kodePesantren,
          'nis_santri': nis,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Parsing response JSON
        final data = jsonDecode(response.body);

        if (data['success']) {
          // Berhasil login, arahkan ke halaman Home
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            // ignore: use_build_context_synchronously
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // Login gagal, tampilkan pesan error
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Login gagal')),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login gagal. Cek koneksi Anda')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 5.0,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 20),
              const Text(
                'Assalamu\'alaikum, selamat datang di',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Text(
                'e-Pesantren',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: kodePesantrenController,
                decoration: InputDecoration(
                  labelText: 'Kode Pesantren',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nisController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  labelText: 'NIS Santri',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LupaPasswordPage()),
                      );
                    },
                    child: const Text(
                      'Lupa password?',
                      style: TextStyle(color: Color(0xFF009464)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(0, 145, 72, 0.612),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _handleLogin,
                  child: const Text('Lanjut'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Butuh bantuan?',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const TextButton(
                onPressed: _launchWhatsApp,
                child: Text(
                  'Hubungi admin',
                  style: TextStyle(color: Color(0xFF009464)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchWhatsApp() async {
  const phoneNumber = '6287741473600'; // Ganti dengan nomor telepon admin Anda
  final url = Uri.parse(
      'https://wa.me/$phoneNumber'); // Format untuk menghubungi melalui WA
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
