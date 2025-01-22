# docs/TECHNICAL.md

# Technical Documentation

## Architecture Overview

stride_and_style/
├── lib/
│   ├── commons/             # Common reusable UI components
│   │   ├── app_bar/         # Custom app bar widgets
│   │   ├── bindings/        # Dependency injection bindings
│   │   ├── cream_container/ # Pre-styled container widgets
│   │   └── tab_bar/         # Custom tab bar widgets
│   │
│   ├── data/                # Data layer
│   │   ├── supabase_config/ # Supabase configuration for storage
│   │   ├── repositories/    # Data repositories
│   │       ├── addresses/   # Address management
│   │       ├── authentication/ # User authentication
│   │       ├── banners/     # Promotional banners
│   │       ├── brands/      # Product brand data
│   │       ├── categories/  # Product category data
│   │       ├── orders/      # Order management
│   │       ├── payment_methods/ # Payment method data
│   │       ├── products/    # Product data
│   │       └── user/        # User profile data
│   │
│   ├── features/            # Feature modules
│   │   ├── authentication/  # User authentication feature
│   │   │   ├── controllers/ # Authentication logic
│   │   │   ├── models/      # Authentication data models
│   │   │   └── screens/     # Authentication UI screens
│   │   ├── personalization/ # User personalization features
│   │   │   ├── controllers/ # Personalization logic
│   │   │   ├── models/      # Personalization data models
│   │   │   └── screens/     # Personalization UI screens
│   │   └── shop/            # Shopping features
│   │       ├── controllers/ # Shopping logic
│   │       ├── models/      # Shopping data models
│   │       └── screens/     # Shopping UI screens
│   │
│   ├── utils/               # Utility functions and constants
│   │   ├── constants/       # App-wide constants
│   │   ├── exceptions/      # Error handling utilities
│   │   ├── helpers/         # Helper functions
│   │   ├── local_storage/   # Local storage utilities
│   │   └── routes/          # App navigation routes
│   │
│   ├── main.dart            # App entry point
│   ├── app.dart             # App-level configurations and initialization
│   ├── navigation.dart      # Centralized navigation management
│   └── firebase_options.dart # Firebase project configuration

## Dependencies
```yaml
dependencies:
  # Core
  flutter_native_splash: [^2.4.3]
  google_fonts: [^6.2.1]
  lottie: [^2.3.2]
  connectivity_plus: [^6.1.1]
  google_sign_in: [^6.2.2]
  carousel_slider: [^5.0.0]
  readmore: [^3.0.0]
  flutter_rating_bar: [^4.0.1]
  image_picker: [^1.1.2]
  shimmer: [^3.0.0]
  intl:

  # State Management
  get: [^4.6.6]
  get_storage: [^2.1.1]

  # Authentication & Database management (Firebase)
  firebase_core: [^3.9.0]
  firebase_auth: [^5.3.4]
  cloud_firestore: [^5.6.0]

  # Storage (Firebase + Supabase)
  supabase_flutter: [^2.8.3]
  firebase_storage: [^12.3.7]
  cached_network_image: [^3.4.1]
  path: [^1.9.0]

