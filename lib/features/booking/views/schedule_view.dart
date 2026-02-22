import 'package:flutter/material.dart';
import 'package:hotel_app/core/base/base_view.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/cart_service.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/booking/models/booking_model.dart';
import 'package:hotel_app/features/booking/viewmodels/schedule_viewmodel.dart';
import 'package:hotel_app/features/booking/views/booking_success_view.dart';
import 'package:hotel_app/shared/widgets/image_widget.dart';

/// Schedule View
class ScheduleView extends BaseView<ScheduleViewModel> {
  final Map<String, dynamic>? selectedRoom;
  final bool showBackButton;

  const ScheduleView({
    super.key,
    this.selectedRoom,
    this.showBackButton = true,
  });

  @override
  ScheduleViewModel createViewModel() => ScheduleViewModel(
        selectedRoom: selectedRoom,
      );

  @override
  State<BaseView<ScheduleViewModel>> createState() => _ScheduleViewState();

  @override
  Widget buildView(BuildContext context, ScheduleViewModel viewModel) {
    final localizations = AppLocalizations();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text(
          localizations.schedule,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCalendar(context, viewModel, localizations),
                        const SizedBox(height: 24),
                        _buildScheduleSection(context, viewModel, localizations),
                      ],
                    ),
                  ),
          ),
          _buildActionButtons(context, viewModel, localizations),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, ScheduleViewModel viewModel, AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'January 2026',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          _buildCalendarGrid(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, ScheduleViewModel viewModel) {
    final firstDay = DateTime(2026, 1, 1);
    final firstWeekday = firstDay.weekday;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        ...List.generate(6, (weekIndex) {
          return Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 2;
              if (dayNumber < 1 || dayNumber > 31) {
                return Expanded(child: Container());
              }
              final isSelected = dayNumber == viewModel.selectedDate.day;
              final hasBooking = viewModel.hasBookingOnDate(dayNumber);

              return Expanded(
                child: GestureDetector(
                  onTap: () => viewModel.selectDate(DateTime(2026, 1, dayNumber)),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected || hasBooking
                          ? Colors.purple
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected || hasBooking
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: isSelected || hasBooking
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildScheduleSection(
      BuildContext context, ScheduleViewModel viewModel, AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.mySchedule,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (viewModel.bookings.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                localizations.noBookingsYet,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          )
        else
          ...viewModel.bookings.map((booking) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildBookingCard(booking),
          );
        }),
      ],
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    return Container(
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
            imageUrl: booking.imageUrl,
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.hotelName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${booking.price}${AppLocalizations().perNight}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, ScheduleViewModel viewModel, AppLocalizations localizations) {
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
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.bookingCount > 0
                      ? () {
                          viewModel.addToCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${viewModel.bookingCount} ${localizations.itemsAddedToCart}'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          // Optionally navigate back or to cart
                          Navigator.pop(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.addToCart,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.bookingCount > 0
                      ? () {
                          // Add to cart, complete checkout (moves to orders, clears cart), then go to success
                          viewModel.addToCart();
                          CartService().checkout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookingSuccessView(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.checkout,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom State for ScheduleView that listens to language changes
class _ScheduleViewState extends BaseViewState<ScheduleViewModel> {
  final LanguageService _languageService = LanguageService();

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (mounted) {
      setState(() {});
    }
  }
}

