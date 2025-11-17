# flutter_project_package

A Flutter package that provides a unified abstraction for **navigation**, **internationalization (i18n)**, **local database storage**, and **data communication**.  
Designed for teams building modular apps, shared libraries, or micro-frontend-style Flutter architectures.

---

## Features

### 1. Navigation Handler
- Simple API to navigate between pages inside the host app or inside the package.
- Supports named routes and argument passing.
- Customizable route registry for package-level screens.

### 2. Translation (i18n)
- Built-in integration with `flutter_localizations` and `intl`.
- Loads translations from JSON files.
- Exposes a lightweight translation service for package components.

### 3. Local Database Storage
- Uses `sqflite` or `hive` (based on your configuration).
- Unified API for CRUD operations.
- Handles initialization, migrations, and key/value storage.

### 4. Data Communication
- Provides a simple event bus / callback bridge for sending data between:
  - Host application ↔ Package screens  
  - Package widgets ↔ Host widgets  
- Supports synchronous and asynchronous communication.

---

## Installation

Add the package to your project:

```yaml
dependencies:
  flutter_project_package:
    git:
      url: https://github.com/Vinod-V3/flutter-package
```

## Usage

```dart
    FlutterProjectPackage(
        config: config
    ),
```