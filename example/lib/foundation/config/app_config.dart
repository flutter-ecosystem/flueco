// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Environment of the runtime execution
enum Environment {
  /// Dev
  dev,

  /// Staging
  staging,

  /// Production
  prod,

  /// Test
  test,
}

/// Configuration/Parameters required by the application.
class AppConfig {
  /// App Name
  final String appName;

  /// Application encryption key
  final String appEncryptionKey;

  /// Base url for http request
  final String? apiBaseUrl;

  /// Current flavor
  final Environment environment;

  /// Constructor
  const AppConfig.dev({
    required this.appName,
    required this.appEncryptionKey,
    this.apiBaseUrl,
  }) : environment = Environment.dev;

  /// Constructor
  const AppConfig.staging({
    required this.appName,
    required this.appEncryptionKey,
    this.apiBaseUrl,
  }) : environment = Environment.staging;

  /// Constructor
  const AppConfig.prod({
    required this.appName,
    required this.appEncryptionKey,
    this.apiBaseUrl,
  }) : environment = Environment.prod;

  /// Config for test
  const AppConfig.test({
    required this.appName,
    required this.appEncryptionKey,
    this.apiBaseUrl,
  }) : environment = Environment.test;

  // coverage:ignore-start
  /// Create [AppConfig] from environment variables
  factory AppConfig.fromEnvironment() {
    const String appEnv =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'prod');
    final Environment environment = Environment.values.firstWhere(
      (Environment element) => element.name == appEnv,
      orElse: () => Environment.prod,
    );

    const String appName =
        String.fromEnvironment('APP_NAME', defaultValue: 'App');
    const String appKey = String.fromEnvironment(
      'APP_KEY',
      defaultValue:
          '6CBC9875516298F7D8CA5A3945A90868A09028ED291BA90963F30C491728308',
    );
    const String serverUrl = String.fromEnvironment(
      'SERVER_URL',
      defaultValue: 'http://httpbin.org',
    );

    switch (environment) {
      case Environment.test:
        return const AppConfig.test(
          appName: appName,
          appEncryptionKey: appKey,
          apiBaseUrl: serverUrl,
        );
      case Environment.dev:
        return const AppConfig.dev(
          appName: appName,
          appEncryptionKey: appKey,
          apiBaseUrl: serverUrl,
        );
      case Environment.staging:
        return const AppConfig.staging(
          appName: appName,
          appEncryptionKey: appKey,
          apiBaseUrl: serverUrl,
        );
      default:
        return const AppConfig.prod(
          appName: appName,
          appEncryptionKey: appKey,
          apiBaseUrl: serverUrl,
        );
    }
  }
  // coverage:ignore-end

  ///
  /// Check if it's dev
  ///
  bool get isDev => environment == Environment.dev;

  ///
  /// Check if it's test
  ///
  bool get isTest => environment == Environment.test;

  ///
  /// Check if it's prod
  ///
  bool get isProd => environment == Environment.prod;

  @override
  String toString() {
    return 'AppConfig(appName: $appName, appEncryptionKey: $appEncryptionKey, apiBaseUrl: $apiBaseUrl, environment: $environment)';
  }
}
