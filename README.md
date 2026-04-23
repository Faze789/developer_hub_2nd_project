# Developer Hub - 2nd Project

A full-stack mobile application built with Flutter on the frontend and Node.js/Express on the backend. This project showcases user authentication, product browsing with detailed views, location-based map integration, Stripe-powered payments, and multi-language support across English, Spanish, and Urdu.

## Features

- **User Authentication** -- Sign-in and sign-up with secure credential handling
- **Home Screen** -- Central hub for browsing content and navigating the app
- **Product Details** -- Dedicated detail views for each product listing
- **Location & Maps** -- Integrated map views for location-based functionality
- **Stripe Payment Integration** -- End-to-end payment processing via a Node.js/Express Stripe server
- **Multi-Language Support** -- Localized in English, Spanish, and Urdu

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter |
| Backend | Node.js, Express |
| Payments | Stripe |
| Localization | Multi-language (EN / ES / UR) |

## Getting Started

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install))
- Node.js and npm installed
- A Stripe account with API keys

### Installation

```bash
# Clone the repository
git clone https://github.com/Faze789/developer_hub_2nd_project.git
cd developer_hub_2nd_project

# Run the Flutter app
flutter pub get
flutter run

# Run the Stripe server (in a separate terminal)
cd server
npm install
node index.js
```
