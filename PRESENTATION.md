# StayHub – Hotel Booking App  
## Presentation Documentation

---

## 1. Project Overview

**StayHub** is a cross-platform mobile hotel booking application built with **Flutter**. Users can browse hotels, select rooms, manage bookings, and complete checkout—with full support for **English** and **Khmer** and a consistent, modern UI.

| Item | Detail |
|------|--------|
| **App name** | StayHub |
| **Platform** | Flutter (iOS, Android, Web, macOS) |
| **Version** | 1.0.0 |
| **Purpose** | Hotel discovery, room selection, booking, and checkout |

---

## 2. Key Features

### 2.1 Authentication
- **Sign In** – Email/phone and password login
- **Register** – New account with confirm password
- **Forgot Password** – Request OTP → verify code (e.g. `123456`) → set new password
- **Logout** – With confirmation dialog

### 2.2 Home & Discovery
- **Home** – List of hotels with image, name, location, price, rating
- **Hotel detail** – Full description, amenities, “Booking Now” and **favorite (heart)** toggle
- **Favorites** – Saved hotels; add/remove from home or detail screen

### 2.3 Booking Flow
1. **Hotel** → tap “Booking Now”
2. **Select Room** – Choose room type (price, features, image)
3. **Schedule** – See calendar, add booking to schedule
4. **Add to Cart** or **Checkout**
5. **Booking Success** – Confirmation screen

### 2.4 Cart & Orders
- **Cart** – View items, remove, see total, **Checkout** (moves to orders, clears cart, shows notification)
- **Orders** – List of past/confirmed orders (from cart checkout)

### 2.5 Profile & Settings
- **My Profile** – Edit name, email, date of birth, gender
- **Password & Security** – Change password (old → new)
- **Transaction History** – List of transactions
- **Language** – Switch between **English** and **Khmer**
- **Notifications** – In-app notification list

### 2.6 Internationalization (i18n)
- **Languages:** English, Khmer (ខ្មែរ)
- **Fonts:** Inter (English), Kantumruy Pro (Khmer) via Google Fonts
- **UI:** All main screens use localized strings (navigation, auth, profile, booking, cart, favorites, errors)

---

## 3. Tech Stack & Architecture

### 3.1 Tech Stack
- **Framework:** Flutter (SDK ^3.10.0)
- **State:** `ChangeNotifier` (services), no external state package
- **Localization:** `flutter_localizations` + custom `AppLocalizations` + `LanguageService`
- **Fonts:** `google_fonts` (Inter, Kantumruy Pro)
- **Data:** JSON assets (hotels, rooms, bookings, notifications, current location)

### 3.2 Project Structure (high level)

```
lib/
├── main.dart                 # App entry, theme, locale
├── core/
│   ├── base/                 # BaseView, BaseViewModel
│   ├── constants/            # AppConstants, AppRoutes
│   ├── localization/         # AppLocalizations
│   ├── main_screen.dart      # Bottom nav (Home, Cart, Favorites, Profile)
│   └── services/             # Auth, User, Data, Cart, Favorites, Language, Notification
├── features/
│   ├── auth/                 # Sign in, Register, Forgot password, OTP, New password
│   ├── home/                 # Home, Hotel detail, Hotel card
│   ├── booking/             # Select room, Schedule, Booking success
│   ├── cart/                 # Cart view
│   ├── favorites/            # Favorites view
│   ├── orders/               # Orders view
│   ├── profile/              # Profile, My profile, Password, Language, Transaction history
│   └── notifications/        # Notification list
└── shared/                   # Reusable widgets (ImageWidget, MenuItem, etc.)
```

### 3.3 Services (singletons)
- **AuthService** – Login, register, logout, password sync
- **UserService** – Profile data, change password, reset password (forgot flow)
- **DataService** – Loads JSON; provides hotels, rooms, bookings, notifications
- **CartService** – Cart items, add/remove, checkout (clear cart + create orders + notification)
- **FavoritesService** – Favorite hotel IDs, toggle, list
- **LanguageService** – Current locale (en/km), notify on change
- **NotificationService** – In-app notifications

### 3.4 Data (assets)
- `assets/data/hotels.json`
- `assets/data/rooms.json`
- `assets/data/bookings.json`
- `assets/data/notifications.json`
- `assets/data/current_location.json`

---

## 4. Main User Flows (for slides)

### Flow 1: Guest books a room
1. Open app → (optional) Sign in  
2. Home → tap hotel → Hotel detail → **Booking Now**  
3. Select room → **Continue**  
4. Schedule → pick date → **Checkout**  
5. Cart is cleared, order created, notification sent → **Booking Success**

### Flow 2: User manages favorites
1. Home or Hotel detail → tap heart to add/remove favorite  
2. **Favorites** tab → see list → tap to open hotel detail  

### Flow 3: User checks out from cart
1. **Cart** tab → review items → **Checkout**  
2. Items move to orders, cart clears, “Booking Confirmed” notification  
3. Navigate to Booking Success (or stay on cart with empty state)

### Flow 4: Change language
1. **Profile** → **Language** → choose English or Khmer  
2. App UI and fonts update immediately (Inter ↔ Kantumruy Pro)

---

## 5. UI Highlights (for demo)

- **Bottom navigation:** Home | Cart | Favorites | Profile  
- **Auth:** Splash → Sign in / Register; Forgot password with OTP (`123456`)  
- **Booking:** Hotel → Room → Schedule → Add to cart / Checkout → Success  
- **Cart:** Items, total, remove, Checkout clears cart and creates orders  
- **Profile:** Edit profile, change password, language (EN/Khmer), transaction history, logout  

---

## 6. Possible Future Enhancements (optional slide)

- Replace JSON with real **REST/GraphQL API**
- **Payment** integration (e.g. Stripe, local gateway)
- **Search & filters** (location, price, dates)
- **Push notifications** for booking status
- **Reviews & ratings** for hotels/rooms
- **Map** view for hotel locations

---

## 7. Quick Reference

| Topic | Where to look |
|-------|----------------|
| App name, routes, asset paths | `lib/core/constants/app_constants.dart` |
| Translations (EN/Khmer) | `lib/core/localization/app_localizations.dart` |
| Bottom nav screens | `lib/core/main_screen.dart` |
| Auth logic | `lib/core/services/auth_service.dart` |
| Cart & checkout | `lib/core/services/cart_service.dart` |
| Booking flow | `lib/features/booking/views/` (select_room, schedule, booking_success) |
| Language + fonts | `lib/main.dart` (theme), `lib/core/services/language_service.dart` |

---

*StayHub – Hotel Booking App · Flutter · v1.0.0*
