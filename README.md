# Meditations in Compososable Architecture [TCA](https://github.com/pointfreeco/swift-composable-architecture)


## Overview

The **Meditation** is a technical task demonstrating the use of the **Composable Architecture (TCA)** to manage a list of meditations and handle location-based features. This is not a library, 
but a standalone task showcasing various technologies and techniques.

## Technologies Used

- **Composable Architecture 1.0**
- **Point-Free's Libraries**
- **SwiftUI**
- **Combine**
- **CLLocationManager**

## Features

- Fetch and display a list of meditation audio collections.
- Handle location services, including authorization and location fetching.
- Manage loading states.

## Requirements

- **iOS 15.0+**
- **Xcode 13+**
- **Swift 5.5+**

## Usage

To run this project:

1. Clone or download the repository.
2. Open the Xcode project file.
3. Build and run the application.

## Implementation Details

### Faked Networking

Networking is faked in this task, simulating the fetching of meditation audio collections.

### MeditationListFeature

Main feature where all the logic is running with Reducer and Actions

### Data
Data is mocked as json file in meditations.json, if reviewer will want to test on various test cases, this json file need to be changed.

## Testing

Due to time constraints, unit tests for the reducer were not completed. However, the project is structured to be testable, utilizing TCA's test utilities.

## Acknowledgments

This project uses **Point-Free** dependencies for the **Composable Architecture**
