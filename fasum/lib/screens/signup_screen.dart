import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasum/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Akun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: 'Konfirmasi Password'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _registerAccount();
                },
                child: const Text('Daftar'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _registerAccount() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi password tidak sama !'),
        ),
      );
      return;
    }
    try {
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(newUser.user!.uid)
          .set({
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'createdAt': DateTime.now(),
      });
      // Jika pendaftaran berhasil, arahkan pengguna ke halaman masuk
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SigninScreen(),
            //Ketika berhasil Daftar maka diarahakan ke Sign In screen
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mendaftar: ${e.message}'),
          ),
        );
      }
    }
  }
}
