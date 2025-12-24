# Recipe Genie 🧞‍♂️🍲

**Recipe Genie** is a smart Flutter application that transforms your available ingredients into culinary masterpieces. Powered by **Google Gemini AI**, it intelligently identifies food items from images captured via camera or selected from the gallery and generates delicious, well-structured recipes tailored to what you have on hand.

Whether you're clearing out your fridge or searching for inspiration for your next meal, **Recipe Genie** acts as your magical kitchen assistant.

---

## 📸 App Screenshots

<p align="center">
  <img src="https://github.com/SarkarSoumitro/Recipe_genie/blob/main/Screenshots/3.png" width="260" />
  <img src="https://github.com/SarkarSoumitro/Recipe_genie/blob/main/Screenshots/5.png" width="260" />
  <img src="https://github.com/SarkarSoumitro/Recipe_genie/blob/main/Screenshots/6.png" width="260" />
</p>

---

## ✨ Features

- **📸 AI-Powered Vision**  
  Capture a photo or upload an image to instantly identify ingredients using **Google Gemini 2.5 Flash Lite**.

- **🍳 Smart Recipe Generation**  
  Generate detailed recipes based on detected ingredients, including step-by-step instructions, cooking time, and difficulty level.

- **🌍 Multi-Language Support**  
  Fully localized support for **English** and **Bengali (বাংলা)**.

- **🎨 Beautiful UI**  
  Modern glassmorphic design with smooth animations and an **Apricot Crush** inspired theme.

- **🌗 Dark / Light Mode**  
  Seamless support for both system-wide light and dark themes.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Riverpod](https://riverpod.dev/) (with code generation)
- **AI Integration**: [google_generative_ai](https://pub.dev/packages/google_generative_ai)
- **Architecture**: Clean Architecture (Domain, Data, Presentation)
- **Functional Programming**: [fpdart](https://pub.dev/packages/fpdart)
- **Code Generation**: [Freezed](https://pub.dev/packages/freezed), [json_serializable](https://pub.dev/packages/json_serializable)
- **UI / UX**: [flutter_animate](https://pub.dev/packages/flutter_animate), [glassmorphism](https://pub.dev/packages/glassmorphism), [google_fonts](https://pub.dev/packages/google_fonts)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK **3.8.1** or higher  
- Dart SDK

---

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/recipe_genie.git
   cd recipe_genie
📦 Installation
Install Dependencies
flutter pub get

Generate Code
dart run build_runner build -d

🔐 Configuration

To enable AI features, a Google Gemini API Key is required.

Obtain your API key from Google AI Studio

Open the following file:

lib/core/constants/api_constants.dart


Replace the placeholder value:

static const String geminiApiKey = 'YOUR_API_KEY_HERE';


⚠️ For production usage, it is strongly recommended to use environment variables or a secure backend proxy to protect your API key.

▶️ Running the App
flutter run

📂 Project Structure

The project follows a Clean Architecture approach:

lib/
├── core/                # Shared utilities, themes, constants, errors
├── features/            # Feature-based modules (Vision, Recipe, Splash)
│   ├── data/            # API implementations, models, repositories
│   ├── domain/          # Entities, abstract repositories, use cases
│   └── presentation/   # UI (Pages, Widgets) & State (Riverpod)
├── l10n/                # Localization files (ARB)
└── main.dart            # Application entry point

🤝 Contributing

Contributions are welcome and appreciated.

Fork the repository

Create your feature branch

git checkout -b feature/AmazingFeature


Commit your changes

git commit -m "Add AmazingFeature"


Push to the branch

git push origin feature/AmazingFeature


Open a Pull Request
