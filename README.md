# Mellodica 🎵
 
> A music learning app designed for people who always wanted to learn an instrument but never found a way to stick with it.
 
---
 
## The problem
 
Most people who try to learn music give up within the first few months. It's not because they lack talent — it's because traditional learning methods are rigid, slow to show progress, and simply not built for people with busy lives. Without consistent feedback and visible evolution, motivation fades fast.
 
## The solution
 
Mellodica transforms music learning into a daily habit by combining structured lessons with gamification mechanics. Instead of sitting through long, passive video classes, users follow a personalized learning trail, complete short daily exercises, earn XP, unlock achievements, and take care of a virtual pet that reflects their consistency. Miss a few days? The pet gets sick. Keep your streak? It thrives.
 
The app also listens. Using audio recognition, Mellodica can evaluate whether the user is playing the right notes and give instant feedback — making practice feel less like studying and more like a game.
 
---
 
## Core features
 
**Personalized learning trail** — users follow a path adapted to their current level and chosen instrument, progressing at their own pace without feeling overwhelmed.
 
**Gamification** — XP points, levels, achievement badges, daily streaks, and a global leaderboard keep motivation high and make progress visible.
 
**The pet companion** — a virtual pet that lives and dies based on your practice consistency. It's a small mechanic with a surprisingly strong psychological effect: people don't want to let it die.
 
**Audio feedback** — the app listens to the user play through the device microphone and evaluates pitch and timing in real time.
 
**Adaptive content** — lesson difficulty adjusts based on the user's performance history, ensuring the experience stays challenging without being discouraging.
 
---
 
## Tech stack
 
The project is split into a mobile frontend and a separate backend API.
 
The **frontend** is built with Flutter, which allows the same codebase to run on Android and iOS. The architecture follows the MVC pattern, keeping UI, business logic, and data models cleanly separated. Audio capture and analysis is handled through a dedicated service layer.
 
The **backend** (planned) will be a REST API responsible for authentication, user data, lesson content, XP tracking, leaderboard rankings, and pet state. It will communicate with the frontend through HTTP requests.
 
The **database** (planned) will be PostgreSQL, storing all persistent data including user profiles, progress history, achievements, and pet state.
 
| Layer | Technology | Status |
|---|---|---|
| Mobile app | Flutter (Dart) | In progress |
| Architecture | MVC | In progress |
| Backend API | To be defined | Planned |
| Database | PostgreSQL | Planned |
| Audio analysis | To be defined | Planned |
| Auth | Email + password | Planned |
 
---
 
## Project structure
 
```
mellodica/
├── lib/
│   ├── main.dart               # App entry point
│   ├── models/                 # Data structures (User, Lesson, Pet, Achievement...)
│   ├── views/                  # Screens and UI widgets
│   ├── controllers/            # Business logic connecting views and models
│   └── services/               # External communication (API, microphone, storage)
├── docs/
│   ├── SETUP.md                # Environment setup guide
│   ├── ARCHITECTURE.md         # Architectural decisions and patterns
│   ├── DATABASE.md             # Database schema and relationships
│   └── diagrams/               # Use case, class, and ER diagrams
├── test/                       # Automated tests
└── pubspec.yaml                # Dependencies and project configuration
```
 
---
 
## Getting started
 
For a complete environment setup guide (including Arch Linux installation), see [docs/SETUP.md](docs/SETUP.md).
 
---
 
## Documentation
 
The `docs/` folder contains detailed documentation for each layer of the project. [ARCHITECTURE.md](docs/ARCHITECTURE.md) explains the MVC structure and the reasoning behind each design decision. [DATABASE.md](docs/DATABASE.md) covers the full PostgreSQL schema. [SETUP.md](docs/SETUP.md) is a complete guide to setting up the development environment from scratch.
 
---
 
*This project was created as a school assignment and is actively under development.*