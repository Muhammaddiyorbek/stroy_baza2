import 'package:flutter/material.dart';
import 'package:stroy_baza/logic/repository/favorites_repository.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/models/product.dart'; // Add this import

// Change StatelessWidget to StatefulWidget
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesRepository _repository = FavoritesRepository();
  List<Product> favoriteProducts = []; // Change type to Product
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => isLoading = true);
    final ids = await _repository.getFavoriteIds();
    print(ids);
    final products = await _repository.getProductsByIds(ids);
    setState(() {
      favoriteProducts = products;
      isLoading = false;
    });
  }

  Future<void> _toggleFavorite(int productId) async {
    try {
      setState(() => isLoading = true);

      // Mahsulotni vaqtincha o'chirib qo'yamiz
      final removedProduct =
      favoriteProducts.firstWhere((p) => p.id == productId);
      final productIndex = favoriteProducts.indexOf(removedProduct);

      setState(() {
        favoriteProducts.removeAt(productIndex);
      });

      // Backend bilan sinxronizatsiya
      await _repository.toggleFavorite(productId);
    } catch (e) {
      print('Error in toggleFavorite: $e');
      // Xatolik bo'lsa, to'liq ro'yxatni qayta yuklaymiz
      await _loadFavorites();
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDEB887),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sevimlilar',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadFavorites,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : favoriteProducts.isEmpty
            ? ListView(
          children: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text('Sevimli mahsulotlar yo\'q'),
              ),
            ),
          ],
        )
            : GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteProducts[index];
            return _buildProductCard(product);
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final variant = product.variants.isNotEmpty ? product.variants.first : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(AssetsModel.penoplex),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nameUz,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (variant != null)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${variant.monthlyPayment12} so\'mdan / 12oy',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart, size: 18),
                          color: Colors.amber[700],
                          onPressed: () {
                            // Handle add to cart
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, size: 18),
                          color: const Color(0xFFE53935),
                          onPressed: () => _toggleFavorite(product.id),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                if (variant != null)
                  Text(
                    'Narxi: ${variant.price} UZS',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
