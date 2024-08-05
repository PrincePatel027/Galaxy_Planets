# Galaxy Planets App

Galaxy Planets is a Flutter application that showcases various planets and allows users to like their favorite ones. The app supports both light and dark themes, with theme preferences managed by a provider.

## Features

- **Splash Screen**: Welcome screen that greets users when the app is launched.
- **Home Page**: Main page displaying a list of planets.
- **Like Functionality**: Users can like their favorite planets.
- **Theme Support**: The app supports light, dark, and system themes.

## Images & Videos

https://github.com/user-attachments/assets/89d667e6-00ac-40b7-9332-5c722a100d39

![Galaxy_Planets](https://github.com/user-attachments/assets/18fc284d-8a28-428b-a242-6934afeb7503)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Android Studio or Visual Studio Code (with Flutter extensions installed)

### Installing

1. **Clone the repository**:
    ```bash
    git clone https://github.com/PrincePatel027/Galaxy_Planets
    cd galaxy-planets
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the app**:
    ```bash
    flutter run
    ```

## Project Structure

```plaintext
lib/
├── main.dart              
├── provider/
│   ├── like_provider.dart  
│   └── theme_provider.dart 
preferences
├── screens/
│   └── pages/
│       ├── home_page.dart  
│       └── splash_screen.dart 
```

## Providers

The app uses the provider package to manage state:

- LikeProvider: Manages the list of liked planets.
- ThemeProvider: Manages theme preferences (light, dark, or system).

