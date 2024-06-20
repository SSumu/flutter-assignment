import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/product_model.dart';
import 'package:flutter_assignment/api_service.dart';
import 'package:flutter_assignment/details_page.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Building HomePage');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Products',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
