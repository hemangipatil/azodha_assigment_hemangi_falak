# Contact Form App

This is a simple Flutter app that allows users to add a new contact with fields for Name, Email, Phone Number, and Address. The contact data is stored in Firebase Firestore using the BLoC pattern for state management and a clean MVVM-like architecture.

## Requirements

- Flutter SDK
- Firebase project with Firestore enabled

## Setup

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Set up Firebase in your Flutter app:
    - Follow the [Firebase Flutter Setup Guide](https://firebase.google.com/docs/flutter/setup) to configure Firebase with your project.
    - Add your `google-services.json` for Android and `GoogleService-Info.plist` for iOS in the appropriate directories.
4. Run the app using `flutter run`.

## Features

- Add new contacts with Name, Email, Phone, and Address.
- Contacts are stored in Firebase Firestore.
- BLoC pattern for state management.
- Clean architecture (MVVM-like).
