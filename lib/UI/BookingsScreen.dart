import 'package:flutter/material.dart';
import 'package:hotel_app/widget/BookingCard.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tab Selector
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Upcoming',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text(
                      'Completed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text(
                      'Cancelled',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Booking Cards
          BookingCard(
            hotelName: 'Grand Plaza Hotel',
            location: 'New York, USA',
            dates: 'Feb 15 - Feb 18, 2026',
            details: '3 nights • 2 guests',
            price: '\$750',
            status: 'Confirmed',
            statusColor: Colors.green,
          ),
          const SizedBox(height: 16),
          BookingCard(
            hotelName: 'Ocean View Resort',
            location: 'Maldives',
            dates: 'Mar 10 - Mar 15, 2026',
            details: '5 nights • 2 guests',
            price: '\$2,250',
            status: 'Pending',
            statusColor: Colors.orange,
          ),
          const SizedBox(height: 16),
          BookingCard(
            hotelName: 'Mountain Lodge',
            location: 'Swiss Alps',
            dates: 'Apr 5 - Apr 8, 2026',
            details: '3 nights • 4 guests',
            price: '\$960',
            status: 'Confirmed',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }
}