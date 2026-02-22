import 'package:flutter/material.dart';
import 'package:hotel_app/core/base/base_view.dart';
import 'package:hotel_app/core/localization/app_localizations.dart';
import 'package:hotel_app/core/services/data_service.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/booking/viewmodels/select_room_viewmodel.dart';
import 'package:hotel_app/features/booking/views/schedule_view.dart';
import 'package:hotel_app/features/home/models/room_model.dart';
import 'package:hotel_app/shared/widgets/image_widget.dart';

/// Select Room View
class SelectRoomView extends BaseView<SelectRoomViewModel> {
  final String? hotelId;
  final String? hotelName;

  const SelectRoomView({super.key, this.hotelId, this.hotelName});

  @override
  SelectRoomViewModel createViewModel() => SelectRoomViewModel(hotelId: hotelId);

  @override
  State<BaseView<SelectRoomViewModel>> createState() => _SelectRoomViewState();

  @override
  Widget buildView(BuildContext context, SelectRoomViewModel viewModel) {
    final localizations = AppLocalizations();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations.selectRoomToBook,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.rooms.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: viewModel.rooms.length,
                        itemBuilder: (context, index) {
                          final room = viewModel.rooms[index];
                          final isSelected = viewModel.isRoomSelected(index);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildRoomCard(context, room, index, isSelected, viewModel),
                          );
                        },
                      ),
          ),
          _buildContinueButton(context, viewModel, hotelName),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final localizations = AppLocalizations();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hotel_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            localizations.noRoomsAvailable,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
    BuildContext context,
    RoomModel room,
    int index,
    bool isSelected,
    SelectRoomViewModel viewModel,
  ) {
    final localizations = AppLocalizations();
    return GestureDetector(
      onTap: () => viewModel.selectRoom(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
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
              imageUrl: room.imageUrl,
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
                    room.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.location,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: (room.features).map((feature) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${room.price}${localizations.perNight}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isSelected,
              onChanged: (value) => viewModel.selectRoom(index),
              activeColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, SelectRoomViewModel viewModel, String? hotelName) {
    final localizations = AppLocalizations();
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
            onPressed: viewModel.selectedRoom != null
                ? () async {
                    final room = viewModel.selectedRoom!;
                    final roomJson = room.toJson();
                    
                    // Get hotel name from hotelId
                    String hotelNameValue = hotelName ?? '';
                    if (hotelNameValue.isEmpty && room.hotelId.isNotEmpty) {
                      final dataService = DataService();
                      final hotel = dataService.getHotelById(room.hotelId);
                      hotelNameValue = hotel?['name']?.toString() ?? room.name;
                    }
                    
                    // Convert room to booking format for ScheduleView
                    final dateStr = roomJson['date']?.toString() ?? '';
                    const monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
                    final now = DateTime.now();
                    final defaultDate = '${now.day} ${monthNames[now.month - 1]}, ${now.year}';
                    final bookingData = {
                      'id': roomJson['id'],
                      'hotelName': hotelNameValue.isNotEmpty ? hotelNameValue : roomJson['name'],
                      'name': roomJson['name'],
                      'location': roomJson['location'],
                      'date': dateStr.isNotEmpty ? dateStr : defaultDate,
                      'price': roomJson['price'],
                      'imageUrl': roomJson['imageUrl'],
                    };
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleView(
                          selectedRoom: bookingData,
                        ),
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
              localizations.continue_,
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

/// Custom State for SelectRoomView that listens to language changes
class _SelectRoomViewState extends BaseViewState<SelectRoomViewModel> {
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

