# 📱 DownApp iOS

> A modular, scalable SwiftUI app built with clean architecture, coordinators, and love for code quality.

---

## 🚀 Overview

**DownApp** is a modular iOS application demonstrating modern, maintainable architecture principles:

✨ Key features:
- 🧩 **Modular architecture** — clear separation of features, services, and UI layers.  
- 🧭 **Coordinator-based navigation** — no hidden magic, pure manual dependency injection.  
- 🧠 **SwiftUI + MVVM** — clean state management and reactive UI updates.  
- 🎨 **Atomic Design System** — reusable and consistent UI components.  
- 🧹 **SwiftLint** — enforced coding standards for a clean, consistent codebase.

---

## 🏗️ Architecture

### 1️⃣ Modularity

The project is divided into submodules:

| Module | Responsibility |
|:--|:--|
| **DownApp** | Main target — contains the `AppCoordinator` entry point. |
| **Features** | Each screen or logical feature is a separate submodule (e.g. `ProfilesFeature`). |
| **Utils** | System services such as `NetworkService` and `StorageService`. |
| **UI** | Shared UI components (e.g. `UrlImage`, buttons, toasts). |
| **Core** | Helpful extensions and foundation utilities. |

---

### 2️⃣ Coordinator Pattern

- `AppCoordinator` manages global navigation and lifecycle.  
- Each feature defines its own `FeatureCoordinator`, which:
  - Creates and injects its **View** and **ViewModel**.  
  - Handles local navigation and communication with other modules.

This ensures full control over flow and clear dependency boundaries — no global singletons or magic DI containers.

---

### 3️⃣ How to Explore the Project

🪄 **Start with:**  
`main` branch — to understand the overall structure.  

🧩 **Then explore:**  
`features/profiles_screen` — to see a real feature in action:
- `ProfilesViewModel` — manages **state**, **loading**, and **decision storage**.  
- `ProfilesView` — displays the **deck** and **cards** using SwiftUI.

---

### 4️⃣ Bonus Highlights ✨

- 🖼️ `ProfilesService` prefetches profile images for smoother scrolling with `AsyncImage`.  
- 👀 All views include **Xcode Previews** for instant visual feedback.  
- 🧪 `ProfilesDecisionStorageTests` covers the logic of decision persistence.  
- 🐛 Fixes the **0-offset bug** found in the original app (see video reference below). 
 [The video](https://github.com/AlexZhembl/Downapp/blob/main/original_app_0_offset_bug.mp4?raw=true)

---

## ⚙️ Development Setup

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/downapp-ios.git
cd downapp-ios

# 2. Open the project
open DownApp.xcodeproj

# 3. (Optional) Install SwiftLint
brew install swiftlint
