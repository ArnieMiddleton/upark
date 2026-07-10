# UPark

UPark is a crowd-sourced mobile app for tracking real-time parking availability on the University of Utah campus. Instead of driving lap after lap through a full lot, students and staff can check the app first and head straight to a lot that actually has open spots.

Built as a senior capstone project (Aug 2023 – May 2024), UPark shipped as a working cross-platform app demoed live on both Android and iOS at the university's capstone showcase.

## How it works

- Availability is self-reported: users mark a lot as they park or leave, and that feeds a live view of open spots across campus lots.
- Each lot has a dedicated occupancy forecast view: pick a day of the week and see a bar chart of expected occupancy by hour, with a one-tap handoff to the phone's native Maps app for turn-by-turn directions. (The prediction UI and data model are fully built; the underlying forecasting logic was still a work in progress when the capstone wrapped up.)

## Tech stack

- **App**: Flutter/Dart, targeting Android and iOS (with Linux/macOS/Windows/web build targets scaffolded via Flutter's multi-platform support)
- **Backend**: [Flask REST API](https://github.com/girlandherespresso/upark-server), containerized with Docker and deployed on Google Cloud Run
- **Data**: MySQL
- **Tooling**: Git/GitHub for version control, `analysis_options.yaml`-enforced Dart linting, automated tests under `test/`

## Architecture

UPark is split across two repositories:

- **`upark`** (this repo) — the Flutter client
- **[`upark-server`](https://github.com/girlandherespresso/upark-server)** — the Flask API and MySQL data layer, deployed via Docker/Cloud Run

The client calls the REST API to pull live lot availability and submit updates; the server handles persistence, validation, and deployment.

## Getting started

```bash
git clone https://github.com/girlandherespresso/upark.git
cd upark
flutter pub get
flutter run
```

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install) and a configured Android/iOS emulator or connected device. The app expects the [`upark-server`](https://github.com/girlandherespresso/upark-server) API to be running and reachable — see that repo's README for setup.

## Testing

Run the test suite with:

```bash
flutter test
```

## Team & background

Built by a four-person team as our Computer Science capstone project at the University of Utah. I was primarily the backend engineer, and also reworked parts of the frontend late in the project to make it properly asynchronous.

## Status

This was a capstone project completed in May 2024 and is no longer under active development. It was built to demo-ready quality and presented live on both Android and iOS at the capstone showcase, rather than shipped as a released product.
