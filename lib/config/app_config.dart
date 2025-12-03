// app_config.dart
import 'package:flutter/foundation.dart';

enum Environment { development, production }

class AppConfig {
  static Environment _environment = Environment.development;

  // Set environment (call this in main.dart)
  static void setEnvironment(Environment env) {
    _environment = env;
  }

  // Check if production
  static bool get isProduction => _environment == Environment.production;
  static bool get isDevelopment => _environment == Environment.development;

  // API URLs based on environment
  static String get apiUrl {
    switch (_environment) {
      case Environment.development:
        return const String.fromEnvironment("API_URL_MOCK");
      case Environment.production:
        return const String.fromEnvironment("API_URL_PROD");
    }
  }

  // App name with environment suffix
  static String get appName {
    switch (_environment) {
      case Environment.development:
        return 'MyApp (Dev)';
      case Environment.production:
        return 'MyApp';
    }
  }

  // Enable/disable logging
  static bool get enableLogging => kReleaseMode ? !isProduction : isProduction;

  // Enable/disable debug features
  static bool get enableDebugFeatures =>
      kReleaseMode ? !isProduction : isProduction;

  static String get deviceId {
    if (isProduction) {
      return 'PROD_DEVICE_ID'; // Fixed production value
    } else {
      return 'DEV_DEVICE_67890'; // Static development ID
    }
  }

  // API timeout settings
  static Duration get apiTimeout {
    if (isProduction) {
      return const Duration(seconds: 60);
    } else {
      return const Duration(seconds: 60); // Longer timeout for dev
    }
  }

  // Feature flags
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashReporting => isProduction;
  static bool get enablePerformanceMonitoring => isProduction;

  // Print environment info
  static void printEnvironmentInfo() {
    if (enableLogging) {
      print('=== APP CONFIGURATION ===');
      print('Environment: ${_environment.name}');
      print('API URL: $apiUrl');
      print('App Name: $appName');
      print('Logging Enabled: $enableLogging');
      print('========================');
    }
  }
}

// Custom logger that respects environment settings
class AppLogger {
  static void log(String message, {String? tag}) {
    if (AppConfig.enableLogging) {
      final tagStr = tag != null ? '[$tag] ' : '';
      print('$tagStr$message');
    }
  }

  static void debug(String message, {String? tag}) {
    if (AppConfig.enableDebugFeatures) {
      log('DEBUG: $message', tag: tag);
    }
  }

  static void info(String message, {String? tag}) {
    log('INFO: $message', tag: tag);
  }

  static void warning(String message, {String? tag}) {
    log('WARNING: $message', tag: tag);
  }

  static void error(String message, {String? tag}) {
    log('ERROR: $message', tag: tag);
  }
}

// Usage example in main.dart
/*
void main() {
  // Set environment based on build mode or command line arguments
  AppConfig.setEnvironment(
    kReleaseMode ? Environment.production : Environment.development
  );
  
  // Print environment info (only shows in non-production)
  AppConfig.printEnvironmentInfo();
  
  runApp(MyApp());
}
*/

// Usage example in a service class
/*
class ApiService {
  static final String baseUrl = AppConfig.apiUrl;
  
  Future<Map<String, dynamic>> fetchData() async {
    AppLogger.info('Fetching data from: $baseUrl');
    
    // Use static ID for development
    final userId = AppConfig.userId;
    AppLogger.debug('Using user ID: $userId');
    
    // Mock data for development
    if (AppConfig.useMockData) {
      AppLogger.debug('Returning mock data');
      return {'status': 'success', 'data': 'mock_data'};
    }
    
    // Real API call for production
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/data'),
        headers: {'user-id': userId},
      ).timeout(AppConfig.apiTimeout);
      
      return json.decode(response.body);
    } catch (e) {
      AppLogger.error('API call failed: $e');
      rethrow;
    }
  }
}
*/

// Environment-specific build configurations
// You can also create separate files for each environment:

// config/development.dart
/*
class DevelopmentConfig {
  static const String apiUrl = 'https://dev-api.yourapp.com';
  static const bool enableLogging = true;
  static const bool useMockData = true;
  static const String userId = 'DEV_USER_12345';
}
*/

// config/production.dart
/*
class ProductionConfig {
  static const String apiUrl = 'https://api.yourapp.com';
  static const bool enableLogging = false;
  static const bool useMockData = false;
  static const String userId = 'PROD_USER_ID';
}
*/
