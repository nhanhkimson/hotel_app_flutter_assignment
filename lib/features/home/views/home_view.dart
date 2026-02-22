import 'package:flutter/material.dart';
import 'package:hotel_app/core/base/base_view.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/features/home/viewmodels/home_viewmodel.dart';
import 'package:hotel_app/features/home/views/widgets/hotel_card.dart';
import 'package:hotel_app/features/notifications/views/notification_view.dart';

/// Home Screen View
class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel createViewModel() => HomeViewModel();

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    final localizations = AppLocalizations();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLocationHeader(context, viewModel, localizations),
                    _buildHorizontalHotels(context, viewModel, localizations),
                    _buildVerticalHotels(context, viewModel, localizations),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLocationHeader(
      BuildContext context, HomeViewModel viewModel, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.currentLocation,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      viewModel.getFormattedLocation(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.black87),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationView(),
                    ),
                  );
                },
              ),
              if (viewModel.unreadNotificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      viewModel.unreadNotificationCount > 9
                          ? '9+'
                          : '${viewModel.unreadNotificationCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalHotels(
      BuildContext context, HomeViewModel viewModel, AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.nearLocation,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  localizations.seeAll,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: viewModel.hotels.take(2).length,
            itemBuilder: (context, index) {
              final hotel = viewModel.hotels[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: HotelCard(
                  hotel: hotel,
                  isHorizontal: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalHotels(
      BuildContext context, HomeViewModel viewModel, AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.nearLocation,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  localizations.seeAll,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: viewModel.hotels.map((hotel) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: HotelCard(
                  hotel: hotel,
                  isHorizontal: false,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

