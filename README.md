<p align="center">
  <img src="./logo-flueco.jpg" title="Flueco Logo" style="margin: auto; display: block;" alt="drawing" width="160"/>
</p>

<p align="center">
<a href="https://img.shields.io/badge/License-MIT-green"><img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>
<a href="https://discord.gg/FfuNuNcj">
 <img src="https://img.shields.io/discord/1373634834705940563?color=7289da&label=Discord&logo=discord" alt="Discord Badge"></a>
</p>

# Flueco - Your Flutter Ecosystem

Flueco is a comprehensive ecosystem designed to streamline and expedite Flutter application development. It offers a suite of tools meticulously crafted to empower developers in building robust, high-quality Flutter applications efficiently.

In this repository, you will have everything you need to use Flueco in your next Flutter application.or

## Installation

For your Flutter Application, you can add Flueco as a dependency by running the following command:

```bash
  flutter pub add flueco
```

For your Flueco tool, you can add Flueco **Core** as a dependency by running the following command:

```bash
  flutter pub add flueco_core
```

## Usage/Examples

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

## Concept

The idea behind Flueco is that your application becomes part of an ecosystem where none depends on a specific implementation and so every tools are loosely coupled. With that in mind, the system provides some key features (explained below) through abstractions and the implementation for each is done by a tool of the system.

You are be the one that will select the tools to use depending on your needs and so the needs of your application.

With having a set of abstract key features, each tool now will make all of the possible configuration by itself, all that based on the final implementations you want for your applications. Like a tool that needs to store some data, rather than having a `shared_preferences` dependency (that you probably don't want) will use the feature of storage that you want to be used in your application.

## Benefits

- **Accelerated Development**: By encapsulating tedious tasks (like configuration) and providing pre-built components/services, Flueco accelerates the development cycle, allowing developers to focus more on implementing features and refining user experiences.
- **Consistency and Quality**: With standardized service providers, Flueco promotes consistency and maintains a high level of quality across Flutter applications, reducing errors and improving maintainability.
- **Flexibility and Customization**: Despite its comprehensive feature set, Flueco remains flexible, allowing developers to tailor solutions to their specific project needs.

## Features

- Foundations
  - Dependency Injection
    - Service Injector
    - Service Resolver
    - Service Provider
  - Channel Registry
    - Logging
    - Notification
- Core Features
  - IO
    - Storage
    - HTTP
  - Event Handling
  - Routing

### Foundations

#### Dependency Injection

##### Service Injector

The service injector is responsible for injecting services into the service container. It is used to register services and service providers in the container.
It can be access using the class `ServiceInjector` from any classes as dependency or by using `FluecoSI.of(context)` from a widget.

```dart
class MyService {
  void init(ServiceInjector injector) {
    injector.singleton<MyService>((_) => this);
  }
}
```

OR

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> implements ImplementedService {

  @override
  void initState() {
    FluecoSI.of(context).singleton<ImplementedService>((_) => this);
  }

  @override
  void dispose() {
    FluecoSI.of(context).unregister<ImplementedService>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

##### Service Resolver

The service resolver is responsible for resolving services from the service container. It is used to access services registered in the container.
It can be access using the class `ServiceResolver` from any classes as dependency or by using `FluecoSR.of(context)` from a widget.

```dart
class MyService {
  void init(ServiceResolver resolver) {
    final aService = resolver.resolve<AnotherService>();
  }
}
```

OR

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  @override
  void initState() {
    final aService = FluecoSR.of(context).resolve<AnotherService>();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

##### Service Provider

The service provider is responsible for providing services to the service container and the whole application. It is used to register services in the container.
It allows to register services and initializes them after the container is bootstrapped. Each tool that provides services to the application exposes a service provider that will be passed to the kernel.

```dart
class MyServiceProvider extends ServiceProvider {
  @override
  Future<void> register(ServiceInjector injector) async {
    // Register services here
    injector.singleton<MyService>((_) => MyService());
  }

  @override
  Future<void> initialize(FluecoApp app) async {
    // Initialize services here
    final myService = app.resolver.resolve<MyService>();
    await myService.init();
  }
}

// Entry point of the application
void main() {
  final kernel = FluecoKernel(
    container: GetItServiceContainer(),
    serviceProviders: <ServiceProvider>{
      // Add your service providers here
      MyServiceProvider(),
    },
  );

  kernel.bootstrap();
}
```

#### Channel Registry

Channel registry are special features that are used to communicate between different parts of the application.
There could be different type of channel registries provided by different tools or by the Flueco. Flueco comes with `LogRegistry` and `NotificationRegistry`.
Each channel registry allows to register handlers (subtypes of `ChannelHandler`) that will be used to handle specific actions (subtypes of `ChannelHandlerAction`) that it is related to.

**Note**: The `LogRegistry` and `NotificationRegistry` are mainly useful for Flueco tools that need to log messages or send notifications. They are not meant to be used in the application directly. If you want to log messages or send notifications, you should use the tools that provide these features or rely on different services provided by `flueco` package like `LoggerService`, `ToastService`, `DialogService`. You can still use the `LogRegistry` and `NotificationRegistry` if you want to leverage the different custom channels you create.

##### LogRegistry

The log registry is used to log messages in the application. It allows to register log handlers (subtypes of `LogHandler`) that will be used to handle the log actions (subtypes of `LogHandlerAction`).
The `LogHandler` has different methods to handle the different `LogHandlerAction`.

- `void log(LogMessage message)`: Handle the log action `LogLogHandlerAction`
- `void info(LogMessage message)`: Handle the log action `InfoLogHandlerAction`
- `void warning(LogMessage message)`: Handle the log action `WarningLogHandlerAction`
- `void debug(LogMessage message)`: Handle the log action `DebugLogHandlerAction`
- `void error(LogMessage message)`: Handle the log action `ErrorLogHandlerAction`

To decide which `LogHandler` to use for a specific `LogHandlerAction`, the `LogRegistry` will use the `LogDefaultChannelProvider` passed through its constructor parameter `defaultChannelProvider`.
The `flueco` package comes with some predefined `LogHandler` that are available when you use the default `LogRegistry`.

- `LoggerLogHandler`: In `flueco`, used to log messages in the terminal using the `logger` package.
- `ToastLogHandler`: In `flueco`, used to log messages in a toast using the `toast` package through the `ToastService`.
- `ConsoleLogHandler`: Provided by `flueco_core`, used to log messages in the terminal using the `debugPrint` function but not. It is not registered by default. `LoggerLogHandler` is used by default.

> **Note**: If you want to use custom `LogRegistry` but still leverages `LoggerLogHandler` and `ToastLogHandler`, you can register them in your custom `LogRegistry` in the `registerHandlers` method.
> **Note**: You can access to the default or a specific `LogHandler` by using the `FluecoLog.of(context)` from a widget.
> **Note**: The `LogRegistry` can directly be used to log messages in the application. You can use the `log`, `info`, `warning`, `debug`, `error` methods to log messages.
> **Note**: You can access to the `LogRegistry` by using the `FluecoSR.of<LogRegistry>(context)` from a widget or using the dependency injection system in your classes.

##### Notification Registry

The notification registry is used to send notification messages in the application. It allows to register notification handlers (subtypes of `NotificationHandler`) that will be used to handle the log actions (subtypes of `NotificationHandlerAction`).
The `NotificationHandler` has different methods to handle the different `NotificationHandlerAction`.

- `Future<void> inform(InformMessage message)`: Handle the log action `InformNotificationHandlerAction`
- `Future<void> ask(AskMessage message)`: Handle the log action `AskNotificationHandlerAction`
- `Future<bool> confirm(InformMessage message)`: Handle the log action `ConfirmNotificationHandlerAction`

As the `LogRegistry`, the `NotificationRegistry` will use its constructor parameter `defaultChannelProvider` (that is here a `NotificationDefaultChannelProvider`) to decide which `NotificationHandler` to use.
The `flueco` package comes with some predefined `NotificationHandler` that are available when you use the default `NotificationRegistry`.

- `DialogNotificationHandler`: In `flueco`, used to send notification messages using the `DialogService`.

> **Note**: If you want to use custom `NotificationRegistry` but still leverages `DialogNotificationHandler`, you can register it in your custom `NotificationRegistry` in the `registerHandlers` method.
> **Note**: You can access to the default or a specific `DialogNotificationHandler` by using the `FluecoNotification.of(context)` from a widget.
> **Note**: The `NotificationRegistry` can directly be used to send notification messages in the application. You can use the `inform`, `ask`, `confirm` methods to send notification messages.
> **Note**: You can access to the `NotificationRegistry` by using the `FluecoSR.of<NotificationRegistry>(context)` from a widget or using the dependency injection system in your classes.

### Core Features

Flueco provides some core features that are used in the application. These features are used to provide some basic functionalities that are needed in the application. They are not meant to be used directly in the application but rather by the tools that provide these features. To provide these features, the tools will have to expose specific implementations of `ServiceProvider` of the services that the tool exposes. The core features/services are:

- IO
  - Storage exposed by any tool that implements and provides the `IOLocalStorageServiceProvider` or `IOSecureStorageServiceProvider` service provider.
  - HTTP exposed by any tool that implements and provides the `IOHttpServiceProvider` service provider.
- Event Handling exposed by any tool that implements and provides the `EventHandlingServiceProvider` service provider.
- Routing exposed by any tool that implements and provides the `RouterServiceProvider` service provider.

#### IO

##### Storage

The storage feature is used to store data in the application. It allows to store data locally securely or not. There are two classes that defined the types of storage in the application.

- `SecureStorage`: Used to store data securely in the application. It is provided by the `flueco_hive` package.
- `LocalStorage`: Used to store data NOT securely in the application. It is provided by the `flueco_shared_preferences` package.

##### HTTP

The HTTP feature is used to make HTTP requests in the application. It exposes an `HttpClient` that allows to make GET, POST, PUT, DELETE requests to a server. The `HttpClient` is provided by any tool that implements and provides the `IOHttpServiceProvider` service provider. `flueco_dio` is a package that provides an implementation of `IOHttpServiceProvider`.

#### Event Handling

Event Handling is a system that allows many parts of the application to communicate with each other. It is used to send events and subscribe to events. One part send event that are implementation of `Event` and another part can subscribe to these events by implementing `EventSubscriber`, all through the `EventHandler` service. This service is provided by any tool that implements and provides the `EventHandlingServiceProvider` service provider. `flueco_messaging` is a package that provides an implementation of `EventHandlingServiceProvider`.

```dart
class MyEvent extends Event {
  final String message;

  MyEvent(this.message);
}
```

```dart
class MySubscriber implements EventSubscriber {
  @override
  void onEvent(Event event) {
    if (event is MyEvent) {
      print(event.message);
    }
  }
}
```

```dart
class MyService {
  final EventHandler _eventHandler;

  MyService(this._eventHandler);

  void sendEvent() {
    _eventHandler.emit(MyEvent('Hello World'));
  }

  void subscribeToEvent() {
    _eventHandler.subscribe(MySubscriber());
  }
}
```

#### Routing

The routing feature is used to navigate between different parts of the application. The `Router` is provided by any tool that implements and provides the `RouterServiceProvider` service provider. `flueco_auto_route` is a package that provides an implementation of `RouterServiceProvider`.

## Authors

- [@mcssym](https://github.com/mcssym)

## Contributing

Contributions are greatly welcome!

See [CONTRIBUTING](./CONTRIBUTING.md) for ways to get started.

## License

[MIT](./LICENSE)
