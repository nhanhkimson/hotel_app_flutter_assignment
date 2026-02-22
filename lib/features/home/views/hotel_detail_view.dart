import 'package:flutter/material.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/favorites_service.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/home/models/hotel_model.dart';
import 'package:hotel_app/features/booking/views/select_room_view.dart';
import 'package:hotel_app/shared/widgets/image_widget.dart';

/// Hotel Detail View
class HotelDetailView extends StatefulWidget {
  final HotelModel hotel;

  const HotelDetailView({super.key, required this.hotel});

  @override
  State<HotelDetailView> createState() => _HotelDetailViewState();
}

class _HotelDetailViewState extends State<HotelDetailView> {
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

  bool get _isFavorite => _favoritesService.isFavorite(widget.hotel.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(context),
                _buildContent(context),
              ],
            ),
          ),
          _buildAppBar(context),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      _favoritesService.toggleFavorite(widget.hotel);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.black, size: 20),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return ImageWidget(
      imageUrl: widget.hotel.imageUrl,
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.hotel.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[700], size: 20),
                    const SizedBox(width: 4),
                    Text(
                      widget.hotel.rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: Colors.amber[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${widget.hotel.price.replaceAll('\$', '')}${_localizations.perNight}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.hotel.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildAmenities(),
          const SizedBox(height: 24),
          _buildGallery(),
        ],
      ),
    );
  }

  Widget _buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _localizations.amenities,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.hotel.amenities.map((amenity) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                amenity,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _localizations.gallery,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageWidget(
                      imageUrl: widget.hotel.imageUrl,
                      width: 80,
                      height: 80,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to room selection first
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectRoomView(
                    hotelId: widget.hotel.id,
                    hotelName: widget.hotel.name,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _localizations.bookingNow,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

