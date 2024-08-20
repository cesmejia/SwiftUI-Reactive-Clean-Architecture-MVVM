# SwiftUI Reactive Clean Architecture using MVVM with Unit Tests

This is a simple project that gets a TODO list from the network, stores it within Filemanager, creates a memory cache and shows it in a SwiftUI list.
The project has 3 screens and it leverages Combine, Observation and async/await to reactively update every screen from a single source of truth.
This project leverages all the latest 2024 Apple technologies.

This project can be used as a template for Enterprise grade projects

Note: An older version of this project (without reactivity and with a single coordinator) can be found here: https://github.com/cesmejia/SwiftUI-Clean-Architecture-example-with-unit-tests.git

## Overview

The project was developed with the following concepts in mind:

- ``No external libraries``
- ``SOLID principles``
- ``Clean Architecture``
- ``MVVM Architecture``
- ``Use of Composition root``
- ``Coordinator Pattern: Uses UIKit UINavigationController + UITabBarController + UIHostingController for navigation``
- ``Factory Pattern``
- ``Repository Pattern``
- ``Use Cases``
- ``Reactivity: Combine CurrentValueSubject + Observation Framework``
- ``Communication with Composition Root: Via Delegates (Closures could be used too)``
- ``Async Await + Typed Throws``
- ``Swift 6 + Complete Strict Concurrency Checking``
- ``Dependency Injection``
- ``Unit tests: Use of New Swift Testing Framework (Although TDD was not used, tests were created after each instance creation)``
- ``Test doubles: Use of Stubs, Spys and Mocks``
- ``Folder structure: Domain, Data, Presentation and Framework``

### Dependency Diagram:

![233222696-eddef548-90d9-4930-b7bb-83eec2c9fdb4-2](https://github.com/user-attachments/assets/7e1f4897-6c28-4e5d-abd0-f5828a4265be)

### Disclaimer:

This is a very basic project to serve as guide for a tested Clean Architecture approach with SwiftUI.

- Feedback is welcomed.
- I might add some more use cases and features in the near future.
- TODO entity was used throughout the app for simplification sake. True modularity would be achieved by mapping it between layers.

### Discussion:
- **Why UIKit?** I tried using pure SwiftUI but the Composition Root + SwiftUI Tab Navigation escalated the complexity quickly.
- **Why CurrentValueSubject?** Using it versus PassthroughSubject made simple unit test possible by using the .value parameter. But you could use PassthroughSubject without much issue.
- **Why Combine?** I tried using pure Async/Await (AsyncStream) or Observation or Combine-@Published but Main Thread issues and Protocol handling escalated the complexity quickly.

### Useful resources that made this possible:

- Essential developer course: [Essential Developer](https://www.essentialdeveloper.com)
- Hacking with swift: [HWS](https://www.hackingwithswift.com)
- Clean Mobile Architecture Book by Petros Efthymiou: [Clean Mobile Architecture](https://www.petrosefthymiou.com/product-page/clean-mobile-architecture)
- Dependency Injection Principles, Practices, and Patterns by Mark Seemann and Steven van Deursen [Dependency Injection](https://www.goodreads.com/en/book/show/44416307-dependency-injection-principles-practices-and-patterns)
- Clean Architecture Book by Robert C. Martin (Uncle Bob) [Clean Architecture](https://www.goodreads.com/book/show/18043011-clean-architecture?ref=nav_sb_ss_1_11)
