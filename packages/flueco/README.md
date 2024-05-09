# Flueco

 Flueco package containing all required tools for Flutter app development. This package is a part of the Flueco project.

## Installation

 ```yaml
flueco: {version}
```

## Usage

```dart
import 'package:flueco/flueco.dart';
import 'package:flutter/widgets.dart';

import './my_app.dart';

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

See the [example](https://github.com/flutter-ecosystem/flueco/tree/main/example) for more details.
