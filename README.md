<div style="width: 100%; text-align: center;"><img src="./logo-flueco.jpg" title="Flueco Logo" style="margin: auto; display: inline-block;" alt="Flueco Logo" width="196"/></div>

# Flueco - Your Flutter Ecosystem

Flueco is a comprehensive ecosystem designed to streamline and expedite Flutter application development. It offers a suite of tools meticulously crafted to empower developers in building robust, high-quality Flutter applications efficiently.

In this repository, you will have everything you need to use Flueco in your next Flutter application.or

## Installation

Install my-project with npm

```bash
  flutter pub add flueco
```

## Usage/Examples

```dart
import 'package:flueco/flueco.dart';
import 'package:flutter/widgets.dart';

import './my_app.dart';

/// This is the entry point of your application
Future<void> launchApp() async {
    
    final GetItServiceContainer container = GetItServiceContainer();
    final kernel = FluecoKernel(
        container: container,
        serviceProviders: <ServiceProvider>{
            // List all the service providers you will use there
        }
    );

    await kernel.bootstrap();

    runApp(MyApp());
}

void main() {
    launchApp();
}
```

## Concept

The idea behind Flueco is that your application becomes part of an ecosystem where none depends on a specific implementation and so every tools are loosely coupled. With that in mind, the system provides some key features (explained below) through abstractions and the implementation for each is done by a tool of the system.

You are be the one that will select the tools to use depending on your needs and so the needs of your application.

With having a set of abstract key features, each tool now will make all of the possible configuration by itself, all that based on the final implementations you want for your applications. Like a tool that needs to store some data, rather than having a `shared_preferences` dependency (that you probably don't want) will use the feature of storage that you want to be used in your application.

## Features

- Core Features
  - Dependency Injection
    - Service Injector
    - Service Resolver
    - Service Provider
  - Registry
    - Logging
    - Notification
- Components Features
  - IO
    - Storage
    - HTTP
  - Event Handling
    - Event
    - Subscriber
  - Routing

## Benefits

- **Accelerated Development**: By encapsulating tedious tasks (like configuration) and providing pre-built components/services, Flueco accelerates the development cycle, allowing developers to focus more on implementing features and refining user experiences.
- **Consistency and Quality**: With standardized service providers, Flueco promotes consistency and maintains a high level of quality across Flutter applications, reducing errors and improving maintainability.
- **Flexibility and Customization**: Despite its comprehensive feature set, Flueco remains flexible, allowing developers to tailor solutions to their specific project needs.

## Authors

- [@mcssym](https://github.com/mcssym)

## Contributing

Contributions are greatly welcome!

See [CONTRIBUTING](./CONTRIBUTING.md) for ways to get started.

## License

[MIT](./LICENSE)
