# CheckDaily 📱

A modern iOS habit tracking app built with SwiftUI that helps you build and maintain daily habits through GitHub-style check tracking.

## 🎯 Overview

CheckDaily is a habit tracking application that allows users to create custom habits and track their progress over time. Like GitHub's contribution graph, users can visually see their daily progress through an intuitive check-based system.

## ✨ Features

### Current Features (Work in Progress)
- **Authentication System**: User sign-up and sign-in with email/password
- **Habit Creation**: Create custom habits with predefined or custom durations
- **Duration Options**: 
  - 1 Week (7 days) - Quick start
  - 30 Days - Build habits  
  - 90 Days - Transform yourself
  - 365 Days - Long term commitment
  - Custom duration - Choose your own timeframe
- **Habit Management**: Add, update, and remove habits
- **Preview System**: Preview your habit before creating it
- **Modern UI**: Clean, minimalist design with SwiftUI

### Planned Features
- [ ] Daily check-in system (GitHub-style grid)
- [ ] Progress tracking and statistics
- [ ] Streak counters
- [ ] Reminder notifications
- [ ] Data persistence (Core Data integration)
- [ ] Biometric authentication
- [ ] Export progress data
- [ ] Social sharing
- [ ] Dark mode support

## 🏗 Architecture

### Project Structure
```
CheckDaily/
├── CheckDailyApp.swift          # Main app entry point
├── Model/                       # Data models and view models
│   ├── Auth/
│   │   └── useAuth.swift       # Authentication logic
│   ├── Checks.swift            # Core habit model and view model
│   └── MockData.swift          # Sample data for UI testing
├── Screens/                    # Main screen views
│   ├── AuthView/               # Authentication screens
│   │   ├── AuthView.swift
│   │   ├── CreateAccountPopoverView.swift
│   │   ├── RootView.swift
│   │   └── WelcomeView.swift
│   └── ChecksScreenView/       # Main app screens
│       ├── ChecksRootView.swift
│       ├── CreateScreenView.swift
│       └── ProfileScreenView.swift
└── View/                       # Reusable UI components
    ├── Buttons/                # Custom button components
    ├── ChecksScreen/           # Habit list components
    ├── CreateScreen/           # Habit creation components
    └── Common UI elements
```

### Key Components

#### Data Models
- `durations`: Core habit model with name, count, and creation date
- `durationOptions`: Predefined duration templates with styling
- `checksViewModel`: ObservableObject managing habit state

#### Authentication
- `AuthStorage`: Persistent authentication state management
- `SignInViewModel`: Sign-in form handling
- `SignUpViewModel`: Account creation logic

#### UI Components
- Custom buttons (`TButton`, `TNavigationButton`)
- Input fields (`TInput`)
- Duration cards with gradient styling
- Preview components

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- macOS Sonoma or later

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd CheckDaily
   ```

2. **Open in Xcode**
   ```bash
   open CheckDaily.xcodeproj
   ```

3. **Build and Run**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

### First Run
1. Launch the app
2. Create an account or sign in
3. Create your first habit by tapping the "+" button
4. Choose a duration and start tracking!

## 💻 Development

### Key Technologies
- **SwiftUI**: Modern UI framework
- **Combine**: Reactive programming
- **UserDefaults**: Local data persistence (temporary)
- **MVVM Architecture**: Clean separation of concerns

### Code Style
The project follows Swift best practices:
- ObservableObject for state management
- Environment objects for dependency injection
- Proper SwiftUI lifecycle management
- Modular component structure

### Testing
Currently using SwiftUI previews for UI testing. Unit tests and UI tests are planned for future releases.

## 📱 How to Use

### Creating Your First Habit

1. **Launch the app** and sign in/create an account
2. **Tap the "+" button** in the top navigation
3. **Enter your habit name** (e.g., "Morning workout", "Read 30 minutes")
4. **Choose duration**:
   - Select from preset options (7, 30, 90, or 365 days)
   - Or choose "Custom" and enter your own number of days
5. **Preview your habit** to see how it will look
6. **Tap "Create Task"** to save your habit

### Managing Habits
- **View all habits** on the main "Tasks" screen
- **Add new habits** with the "+" button
- **Access profile** with the person icon
- Navigate between screens using the tab-style interface

### Authentication
- **Sign up**: Create a new account with username, email, and password
- **Sign in**: Use your email and password to access your habits
- **Biometric login**: Planned feature for future releases

## 🔧 Current Limitations

This app is in early development. Current limitations include:
- No actual check-in functionality yet
- Data doesn't persist between app launches (UserDefaults only)
- No progress tracking or statistics
- Limited habit management features
- No notifications or reminders

## 🚧 Development Status

**Phase 1: Foundation** ✅
- [x] Project setup and architecture
- [x] Basic authentication system  
- [x] Habit creation UI
- [x] Core data models

**Phase 2: Core Features** 🔄 (Current)
- [ ] Daily check-in system
- [ ] GitHub-style progress grid
- [ ] Data persistence with Core Data
- [ ] Basic statistics

**Phase 3: Enhancement** 📋 (Planned)
- [ ] Notifications and reminders
- [ ] Advanced analytics
- [ ] Social features
- [ ] Export functionality

## 🤝 Contributing

This is a personal project in development. Feel free to:
- Report bugs or suggest features
- Submit pull requests for improvements
- Provide feedback on UI/UX

## 📄 License

This project is currently private and in development.

## 📞 Contact

Created by Anapiya Nurkeldi - Feel free to reach out for questions or collaboration opportunities.

---

**Note**: This app is under active development. Features and documentation will be updated as the project progresses.