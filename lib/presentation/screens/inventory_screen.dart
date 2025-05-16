import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:InventoryApp/infrastructure/datasources/inventory.dart';
import 'package:InventoryApp/domain/entities/product.dart';
import '../providers/auth_provider.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void confirmLogout() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cierra el modal
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE0EBF5),
      appBar: AppBar(
        title: const Text('Inventario', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF5B8BF7),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
            onPressed: confirmLogout,
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: InventoryService.fetchInventory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos aún.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: const Icon(Icons.inventory, color: Color(0xFF5B8BF7)),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('${product.size}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        backgroundColor: const Color(0xFF5B8BF7),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
