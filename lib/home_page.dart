import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/auth_page.dart';
import 'package:flutter_assignment/product_model.dart';
import 'package:flutter_assignment/api_service.dart';
import 'package:flutter_assignment/details_page.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Building HomePage');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: ApiService.fetchProducts(),
        builder: (context, snapshot) {
          if (kDebugMode) {
            print('FutureBuilder state: ${snapshot.connectionState}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var product = snapshot.data![index];
                return ListTile(
                  leading: Image.network(product.thumbnail),
                  title: Text(product.title),
                  subtitle: Text(
                      '\$${product.price.toStringAsFixed(2)}-${product.brand}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(product: product),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
