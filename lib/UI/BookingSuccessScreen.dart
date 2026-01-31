import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Success Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Success Title
                const Text(
                  'Booking Successful!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                
                // Success Message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Your hotel booking has been confirmed. We have sent you a confirmation email with all the details.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                
                // Booking Details Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[300] ?? Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Hotel', 'Asterial Hotel'),
                      const SizedBox(height: 16),
                      const Divider(height: 1, thickness: 1),
                      const SizedBox(height: 16),
                      _buildDetailRow('Location', 'Wilora NT 0872, Australia'),
                      const SizedBox(height: 16),
                      const Divider(height: 1, thickness: 1),
                      const SizedBox(height: 16),
                      _buildDetailRow('Check-in', 'Feb 15, 2026'),
                      const SizedBox(height: 16),
                      const Divider(height: 1, thickness: 1),
                      const SizedBox(height: 16),
                      _buildDetailRow('Check-out', 'Feb 18, 2026'),
                      const SizedBox(height: 16),
                      const Divider(height: 1, thickness: 1),
                      const SizedBox(height: 16),
                      _buildDetailRow('Total Amount', '\$750', isTotal: true),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                
                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Pop back to home screen (pop detail screen and this screen)
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'View Booking Details',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              color: Colors.grey[600],
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: isTotal ? Colors.purple : Colors.black87,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
