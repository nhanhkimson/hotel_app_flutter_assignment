import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/favorites_service.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/home/models/hotel_model.dart';
import 'package:hotel_app/features/home/views/hotel_detail_view.dart';
import 'package:hotel_app/shared/widgets/image_widget.dart';

/// Favorites View
class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final FavoritesService _favoritesService = FavoritesService();
  final LanguageService _languageService = LanguageService();
  final AppLocalizations _localizations = AppLocalizations();

  @override
  void initState() {
    super.initState();
    _favoritesService.addListener(_onFavoritesChanged);
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _favoritesService.removeListener(_onFavoritesChanged);
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    setState(() {});
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favoritesService.favorites;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _localizations.favorites,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: favorites.isEmpty
          ? _buildEmptyState(_localizations)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final hotel = favorites[index];
                return _buildFavoriteCard(hotel);
              },
            ),
    );
  }

  Widget _buildEmptyState(AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            localizations.noFavoritesYet,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              localizations.tapHeartToAdd,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(HotelModel hotel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailView(hotel: hotel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: hotel.imageUrl,
              width: 100,
              height: 100,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hotel.location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$${hotel.price}',
                              style: const TextStyle(
                                color: Colors.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: _localizations.perNight,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            hotel.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                _favoritesService.removeFavorite(hotel.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_localizations.removedFromFavorites),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

