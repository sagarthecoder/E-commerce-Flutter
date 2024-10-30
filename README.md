# Flutter eCommerce App (Practice Project)

This is a Flutter-based eCommerce application built for practice purposes. It leverages modern Flutter features and follows the MVVM architectural pattern. The app includes essential eCommerce features like authentication, product categories, shopping cart, user reviews, and purchase history.

## Features

- **State Management**: Implemented with [GetX](https://pub.dev/packages/get).
- **Themes and Language Support**: Supports multiple themes and languages (Bangla and English).
- **Firebase Authentication**:
    - **Login** and **Signup**
    - **Password Reset** and **Update**
    - **Google Sign-In Integration**
- **Product Data and Categories**:
    - Fetched from [fakestoreapi.com](https://fakestoreapi.com).
    - Products and categories are fetched dynamically with caching.
- **Local Database**:
    - Used `shared_preferences` to store data locally, including cart items, user reviews, and purchase history.
    - Users can **add/remove** items in the cart and manage **purchase history**.
- **Checkout**:
    - Checkout page saves purchase automatically to purchase history upon submission.
- **Offline Caching**:
    - Supports offline mode with cached images and API responses.
- **API Manager**:
    - Built with a custom generic API Manager for flexible and reusable API calls.
- **User Profile**:
    - Dedicated section to manage user profile details.

## Architecture

- The app follows the **Model-View-ViewModel (MVVM)** pattern, enhancing scalability and maintainability.

## Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/sagarthecoder/E-commerce-Flutter.git
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Set up Firebase:
    - Ensure Firebase is set up correctly for Authentication, and configure your Google Sign-In method.

4. Run the app:
    ```bash
    flutter run
    ```

## Dependencies

- **Flutter**: Latest stable version.
- **GetX**: For state management.
- **Firebase Auth**: For authentication and Google Sign-In.
- **Shared Preferences**: For local storage of cart, reviews, and purchase history.
- **Cached Network Image**: For efficient image caching.

## Acknowledgments

- Data source: [Fake Store API](https://fakestoreapi.com)
