# Complaint Management System(cms)

<!-- ![Tech Associate Logo](assets/images/logo.png) -->

## 📱 Overview
cms is a comprehensive complaint management system that enables users to submit, track, and manage complaints efficiently. The system provides real-time updates, offline support, and seamless synchronization between mobile app and server.

## 🚀 Features
- 📝 Submit and track complaints
- 🔄 Real-time status updates
- 📱 Offline support with local storage
- 🔐 Secure authentication
- 📊 Department-wise complaint management
- 📱 Cross-platform support (Android & iphone)
- 🔔 SMS notifications for status updates

## 🛠 Tech Stack

### Frontend (Mobile App)
- **Framework**: Flutter
- **State Management**: Flutter Bloc
- **Local Storage**: Hive
- **HTTP Client**: http package
- **UI Components**: 
  - Material Design
  - Custom widgets
  - Responsive layouts

### Backend
- **Framework**: Node.js with Express
- **Database**: MongoDB
- **Authentication**: JWT
- **SMS Integration**: Twilio

### APIs
```dart
Base URL: https://cms-qctx.onrender.com

Api Endpoints:
- POST /complaints/create    - Create new complaint
- GET  /complaints/department - Get department complaints
- PUT  /complaints/update/:id - Update complaint
- DELETE /complaints/delete/:id - Delete complaint
```

## 📦 Project Structure
```
lib/
├── bloc/           # State management
├── config/         # Configuration files
├── data/           # Data models and repositories
├── services/       # External services (SMS, etc.)
├── utils/          # Utility functions
└── widgets/        # Reusable widgets
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Android Studio / VS Code
<!-- - Node.js and npm
- MongoDB -->

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/cms.git
```

2. **Install Flutter dependencies**
```bash
flutter pub get
```

3. **Configure environment variables**
- Create a `.env` file in the root directory
- Add your configuration:
```
API_URL=https://cms-qctx.onrender.com
SMS_ACCOUNT_SID=your_twilio_sid
SMS_AUTH_TOKEN=your_twilio_token
```

4. **Run the app**
```bash
flutter run
```

## 📱 Screenshots

### Complaint List
![Complaint List](assets/complaint.png)

### Complaint Details
![Complaint Details](assets/detailed_complaint.png)

### Create Complaint
![Create Complaint](assets/add_complaint.png)

### Check the status 
![Check the Status](assets/check_status.png)

### SMS for the status update 
![Check the Status](assets/check_status.png)

### Dashboard for the staff 
![Check the Status](assets/dashboard.png)

### SMS for status update 
![Check the Status](assets/sms.png)

## 🔄 Data Flow
1. **Complaint Creation**
   - User submits complaint
   - Data stored locally (Hive)
   - Synchronized with server
   - SMS notification sent

2. **Complaint Updates**
   - Real-time status updates
   - Offline support
   - Automatic sync when online

## 🔐 Security Features
- JWT Authentication
- Secure API endpoints
- Data encryption
- Input validation

## 📊 Performance Optimizations
- Lazy loading
- Image compression
- Efficient state management
- Optimized API calls

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request


## 👥 Author
- Rwema Isingizwe Norbert
