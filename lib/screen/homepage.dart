// digunakan untuk menyimpan & membaca data dari Firebase Firestore.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void _addTodo() {
    final user = _auth.currentUser;
    if (user != null && _todoController.text.isNotEmpty) {
      // Jika user ada dan textfield tidak kosong:
      // Maka Firestore akan menambah data ke:
      // users → userId → todos → [task baru]
      _firestore
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .add({
        'task': _todoController.text,
        'createdAt': Timestamp.now(),
      });
      _todoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ada tanda ! artinya dipaksa tidak null.
    final user = _auth.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _auth.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            //Menggunakan StreamBuilder agar UI otomatis update setiap ada perubahan data di Firestore.
            //QuerySnapshot → untuk sekumpulan dokumen (hasil query koleksi)
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
              // Mengambil data todos milik user login.
              // .snapshots() → Firestore akan mengirim update real-time.
                  .collection('users')
                  .doc(user.uid)
                  .collection('todos')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Tidak ada tugas.'));
                }

                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    return ListTile(
                      title: Text(doc['task']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => doc.reference.delete(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration:
                        const InputDecoration(hintText: 'Masukkan tugas baru...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle,
                      size: 40, color: Colors.blue),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
