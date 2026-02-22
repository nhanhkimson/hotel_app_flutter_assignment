import 'package:hotel_app/core/base/base_viewmodel.dart';
import 'package:hotel_app/core/services/data_service.dart';
import 'package:hotel_app/features/home/models/room_model.dart';

/// ViewModel for Select Room Screen
class SelectRoomViewModel extends BaseViewModel {
  final DataService _dataService = DataService();
  final String? hotelId;

  List<RoomModel> _rooms = [];
  int? _selectedRoomIndex;

  List<RoomModel> get rooms => _rooms;
  int? get selectedRoomIndex => _selectedRoomIndex;
  RoomModel? get selectedRoom => _selectedRoomIndex != null && _selectedRoomIndex! < _rooms.length
      ? _rooms[_selectedRoomIndex!]
      : null;

  SelectRoomViewModel({this.hotelId});

  @override
  void init() {
    super.init();
    loadRooms();
  }

  /// Load rooms for the hotel
  Future<void> loadRooms() async {
    await executeWithLoading(() async {
      final roomsData = _dataService.getRooms(hotelId: hotelId);
      _rooms = roomsData.map((r) => RoomModel.fromJson(r)).toList();
      notifyListeners();
    });
  }

  /// Select a room
  void selectRoom(int index) {
    if (index >= 0 && index < _rooms.length) {
      _selectedRoomIndex = index;
      notifyListeners();
    }
  }

  /// Check if a room is selected
  bool isRoomSelected(int index) {
    return _selectedRoomIndex == index;
  }
}

