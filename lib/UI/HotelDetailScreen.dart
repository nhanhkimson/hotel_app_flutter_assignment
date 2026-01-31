import 'package:flutter/material.dart';
import 'package:hotel_app/UI/BookingSuccessScreen.dart';

class HotelDetailScreen extends StatelessWidget {
  final String hotelName;
  final String location;
  final String price;
  final double rating;

  const HotelDetailScreen({
    super.key,
    required this.hotelName,
    required this.location,
    required this.price,
    required this.rating,
  });

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
                // Hero Image
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        image: DecorationImage(
                          image: AssetImage('assets/images/hotel.jpg'),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            // If image doesn't exist, use placeholder
                          },
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.hotel,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Navigation buttons
                    SafeArea(
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
                                    icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(width: 12),
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
                    ),
                  ],
                ),

                // Image Gallery
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildGalleryImage(),
                        const SizedBox(width: 12),
                        _buildGalleryImage(),
                        const SizedBox(width: 12),
                        _buildGalleryImage(),
                        const SizedBox(width: 12),
                        _buildGalleryImage(),
                      ],
                    ),
                  ),
                ),

                // Location
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.purple, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Hotel Name and Rating
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hotelName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        '\$${price.replaceAll('\$', '')}/Night',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.purple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '20% off',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Hotel Savoy Homann is a distinguished 4-star heritage hotel in the heart of Bandung, Indonesia, located on Jalan Asia Afrika. Renowned for its rich colonial past and striking Art Deco architecture, it offers guests a blend of historical elegance and modern comfort. The hotel features spacious rooms, excellent dining options, and exceptional service that reflects its prestigious heritage. Read more',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Amenities
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'What this hotel offers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAmenityIcon(Icons.wifi),
                      _buildAmenityIcon(Icons.fitness_center),
                      _buildAmenityIcon(Icons.local_cafe),
                      _buildAmenityIcon(Icons.pool),
                      _buildAmenityIcon(Icons.luggage),
                      _buildAmenityIcon(Icons.tv),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),

          // Booking Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingSuccessScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Booking Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple, width: 2),
      ),
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.blue[300],
          size: 30,
        ),
      ),
    );
  }

  Widget _buildAmenityIcon(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.purple,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}

