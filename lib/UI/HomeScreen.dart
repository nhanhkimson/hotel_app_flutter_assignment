import 'package:flutter/material.dart';
import 'package:hotel_app/widget/CategoryChip.dart';
import 'package:hotel_app/widget/HotelCard.dart';
import 'package:hotel_app/widget/DealCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Discover Hotels',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 12),
                    Text(
                      'Where do you want to stay?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryChip(label: 'All', isSelected: true),
                  CategoryChip(label: 'Beach', isSelected: false),
                  CategoryChip(label: 'Mountain', isSelected: false),
                  CategoryChip(label: 'City', isSelected: false),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Popular Hotels
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Hotels',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 280,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  HotelCard(
                    name: 'Grand Plaza Hotel',
                    location: 'New York, USA',
                    price: '\$250',
                    rating: 4.8,
                  ),
                  HotelCard(
                    name: 'Ocean View Resort',
                    location: 'Maldives',
                    price: '\$450',
                    rating: 4.9,
                  ),
                  HotelCard(
                    name: 'Mountain Lodge',
                    location: 'Swiss Alps',
                    price: '\$320',
                    rating: 4.7,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Deals & Offers
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Special Deals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DealCard(
                title: 'Summer Sale',
                description: 'Up to 40% off on beach resorts',
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DealCard(
                title: 'Weekend Getaway',
                description: 'Book 2 nights, get 1 free',
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}