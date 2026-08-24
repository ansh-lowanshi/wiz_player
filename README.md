# 🎵 WizPlayer

> A cross-platform music streaming application built with Flutter, featuring advanced background audio, dynamic queues, personalized listening insights, and a scalable Clean Architecture.

## 📱 Overview

**WizPlayer** is a modern music streaming mobile application built with **Flutter and Dart**. The project follows **Clean Architecture** principles and uses **BLoC (`flutter_bloc`)** for scalable and predictable state management.

The application focuses on delivering a smooth music playback experience with background audio, lock-screen controls, dynamic queue management, personalized listening insights, and a sleek glassmorphic interface.

---

## ✨ Features

### 🎧 Advanced Audio Playback

* Background music playback
* Lock-screen and notification panel controls
* Custom favorite actions from media controls
* Hardware earbud gesture support
* Dynamic playback queue
* Shuffle mode
* Multiple repeat modes
* Play/pause, seek, skip, and queue management

### 🎯 Personalized Listening

WizPlayer tracks listening activity locally to provide a more personalized experience:

* **For You** – personalized music recommendations
* **Recently Played** – listening history
* **Most Played** – play-count based leaderboard
* Automated listening analytics

### 📚 Music Management

* Global multi-entity search
* Custom playlist creation
* Dynamic queue management
* Favorite actions

### 🎨 UI & Experience

* Modern glassmorphic interface
* Persistent Light/Dark themes
* Responsive Flutter UI
* Smooth and intuitive playback experience

### 📊 Analytics & Persistence

* Local data persistence using **Hive**
* Firebase Analytics integration
* Persistent user preferences and listening data

---

## 🏗️ Architecture

WizPlayer follows **Clean Architecture** to keep the application modular, maintainable, and scalable.

```text
Presentation
     │
     ▼
   BLoC
     │
     ▼
   Domain
     │
     ▼
    Data
     │
     ├── Local Storage
     │      └── Hive
     │
     └── External Services
            ├── Audio Engine
            └── Firebase
```

The application separates presentation, business logic, domain models, and data-related responsibilities to make the codebase easier to maintain and extend.

---

## 🛠️ Tech Stack

| Technology             | Purpose                                |
| ---------------------- | -------------------------------------- |
| **Flutter**            | Cross-platform application development |
| **Dart**               | Programming language                   |
| **flutter_bloc**       | State management                       |
| **Clean Architecture** | Application architecture               |
| **just_audio**         | Audio playback engine                  |
| **audio_service**      | Background audio & media controls      |
| **Hive**               | Local data persistence                 |
| **Firebase Analytics** | Application analytics                  |

---

## 📂 Core Technologies

### BLoC

The application uses `flutter_bloc` to manage application and playback state in a predictable and scalable manner.

### just_audio

Used as the core audio playback engine for controlling music playback, queues, seeking, shuffle, and repeat functionality.

### audio_service

Provides background audio capabilities and integration with system media controls such as the lock screen and notification panel.

### Hive

Used for locally storing listening-related information such as history and play-count data.

### Firebase Analytics

Integrated to capture application analytics and understand user interaction with the application.

---

## 🎵 Playback Flow

```text
User Interaction
       │
       ▼
   BLoC Event
       │
       ▼
Playback Logic
       │
       ▼
  Audio Service
       │
       ▼
   just_audio
       │
       ▼
 Audio Output
```

The playback architecture allows music to continue playing while the application is running in the background and enables interaction through system media controls.

---

## 🔍 Key Highlights

* **Clean Architecture** for scalable project structure
* **BLoC state management** for predictable application state
* **Background audio engine** with system media controls
* **Dynamic queue management** with shuffle and repeat logic
* **Hardware earbud interaction** support
* **Local listening analytics** using Hive
* **Personalized recommendation system**
* **Global multi-entity search**
* **Custom playlist management**
* **Persistent theme preferences**
* **Firebase Analytics integration**

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android SDK
* A physical Android device or emulator

### Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd wizplayer
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run
```

---

## ⚙️ Configuration

If Firebase is enabled in the project, configure your Firebase project using the appropriate FlutterFire configuration.

```bash
flutterfire configure
```

Make sure the required Firebase configuration files are present before running the application.

---

## 📸 Screenshots

Add application screenshots here to showcase the UI and key features.

```text
screenshots/
├── home.png
├── player.png
├── search.png
├── playlist.png
└── settings.png
```

Example:

![WizPlayer Home Screen](screenshots/home.png)

---

## 🗺️ Future Improvements

Potential improvements include:

* Cloud-based playlist synchronization
* User authentication and profiles
* Offline music caching
* Expanded recommendation algorithms
* More audio customization options
* Cross-device playback synchronization

---

## 👨‍💻 Author

**Ansh Lowanshi**

* GitHub: [ansh-lowanshi](https://github.com/ansh-lowanshi)
* LinkedIn: [Ansh Lowanshi](https://www.linkedin.com/in/ansh-lowanshi/)

---

## ⭐ Support

If you find the project interesting, consider giving the repository a ⭐ on GitHub!
