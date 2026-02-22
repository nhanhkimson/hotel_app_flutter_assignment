# Data Structure & API Integration Guide

## Overview
All app data is now loaded from separate JSON files, making it easy to replace with API calls in the future.

## Data Sources

### JSON Files Structure

All data is organized in separate files for better maintainability:

- **`assets/data/hotels.json`**: Hotel listings with details
- **`assets/data/rooms.json`**: Room listings by hotel
- **`assets/data/bookings.json`**: Booking history
- **`assets/data/notifications.json`**: User notifications
- **`assets/data/current_location.json`**: User's current location

### 2. Services

#### `DataService` (`lib/core/services/data_service.dart`)
- Loads data from JSON file
- Provides methods to access:
  - `getHotels()` - All hotels
  - `getRooms({hotelId})` - Rooms (optionally filtered by hotel)
  - `getBookings()` - All bookings
  - `getCurrentLocation()` - User location
  - `getNotifications()` - All notifications
  - `getHotelById(id)` - Specific hotel

#### `NotificationService` (`lib/core/services/notification_service.dart`)
- Loads notifications from `DataService`
- Manages notification state (read/unread)
- Handles notification CRUD operations

#### `CartService` (`lib/core/services/cart_service.dart`)
- Manages shopping cart (in-memory, can be persisted later)
- Manages orders (in-memory, can be persisted later)
- Creates notifications on checkout

## JSON File Structure

### hotels.json
```json
[
  {
    "id": "1",
    "name": "Hotel Name",
    "location": "...",
    "price": "...",
    ...
  }
]
```

### rooms.json
```json
[
  {
    "id": "1",
    "hotelId": "2",
    "name": "Room Name",
    ...
  }
]
```

### bookings.json
```json
[
  {
    "id": "1",
    "hotelName": "...",
    ...
  }
]
```

### notifications.json
```json
[
  {
    "id": "1",
    "title": "...",
    ...
  }
]
```

### current_location.json
```json
{
  "city": "Phnom Penh",
  "country": "Cambodia"
}
```

### Notification Structure
```json
{
  "id": "string",
  "title": "string",
  "message": "string",
  "type": "booking|promotion|reminder|system",
  "dateTime": "ISO8601 string",
  "isRead": boolean,
  "actionUrl": "string (optional)"
}
```

## Future API Integration

### Step 1: Create API Service
Create `lib/core/services/api_service.dart`:

```dart
class ApiService {
  static const String baseUrl = 'https://api.example.com';
  
  Future<List<Map<String, dynamic>>> getHotels() async {
    final response = await http.get(Uri.parse('$baseUrl/hotels'));
    return json.decode(response.body);
  }
  
  // Similar methods for other endpoints
}
```

### Step 2: Update DataService
Replace JSON loading with API calls:

```dart
// Before (JSON - separate files)
final String hotelsJson = await rootBundle.loadString(AppConstants.hotelsDataPath);
_hotels = json.decode(hotelsJson);

// After (API)
final apiService = ApiService();
_hotels = await apiService.getHotels();
_rooms = await apiService.getRooms();
_bookings = await apiService.getBookings();
_notifications = await apiService.getNotifications();
_currentLocation = await apiService.getCurrentLocation();
```

### Step 3: Add Error Handling & Caching
- Add try-catch for network errors
- Implement caching for offline support
- Add loading states

## Current Data Flow

1. **App Start**: `DataService.loadData()` loads all JSON files in parallel
2. **Home Screen**: Fetches hotels from `DataService`
3. **Notifications**: `NotificationService` loads from `DataService`
4. **Cart/Orders**: Managed in-memory (can be persisted to JSON/API later)

## Benefits of Separate Files

✅ **Better Organization**: Each data type has its own file
✅ **Easier Maintenance**: Update one data type without affecting others
✅ **Parallel Loading**: Can load files in parallel for better performance
✅ **API-Ready**: Each file can map to a specific API endpoint
✅ **Version Control**: Easier to track changes per data type

## Benefits

✅ All data centralized in JSON
✅ Easy to replace with API calls
✅ Consistent data structure
✅ Type-safe models
✅ Ready for API integration

## Next Steps for API Integration

1. Add `http` package to `pubspec.yaml`
2. Create `ApiService` class
3. Update `DataService` to use `ApiService` instead of JSON
4. Add error handling and retry logic
5. Implement caching strategy
6. Add authentication if needed

