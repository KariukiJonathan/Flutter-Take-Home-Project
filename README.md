# Flutter-Take-Home-Project
## LPG Cylinder App Overview

The LPG Cylinder App is a Flutter application that allows users to browse, purchase, and track orders of LPG cylinders. The application implements various modern software development practices and patterns.

### 1. Flutter & Dart UI Implementation
    Built using Flutter SDK
    Implements Material Design principles
    Key screens:
        HomeScreen: Displays available cylinders in a grid layout
        CartScreen: Shows selected items and checkout functionality
        OrderHistoryScreen: Lists past orders and their status
        CheckoutResultScreen: Displays transaction results

### 2. State Management (Redux)
    Implemented using flutter_redux package
    State structure:
    
    ''' dart
    class AppState {
      final List<Cylinder> cylinders;
      final List<CartItem> cart;
      final List<Order> orders;
      final bool isLoading;
      final String? error;
      final bool isProcessingCheckout;
    }
    '''
    

    Actions handling:
        Cart management (Add/Remove items)
        Checkout process
        Order history tracking
        Loading states
        Error handling

### 3. Data Models

    Implemented immutable data models:
        Cylinder: Represents available cylinders
        CartItem: Represents items in cart
        Order: Represents completed orders
    All models include:
        JSON serialization
        Equality operators
        Copy methods
        Type safety

### 4. Architecture

    The application follows a simplified Domain-Driven Design (DDD) approach:
    
    ''' dart
    lib/
    ├── core/
    │   ├── constants/
    │   ├── errors/
    │   ├── network/
    │   └── utils/
    ├── data/
    │   ├── models/
    │   ├── repositories/
    │   └── datasources/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    ├── presentation/
    │   ├── screens/
    │   ├── widgets/
    │   └── redux/
    └── main.dart
    '''
    

5. Async Programming

    Implemented using:
        Future for API calls
        async/await for asynchronous operations
        Proper error handling in async operations
    Example:

    
Future<List<Cylinder>> getCylinders() async {
  try {
    final response = await _dio.get('/cylinders');
    return (response.data as List)
        .map((json) => Cylinder.fromJson(json))
        .toList();
  } catch (e) {
    throw FetchDataException();
  }
}

    

6. Performance Optimization

    Implemented CachedNetworkImage for efficient image loading
    Used proper keys in lists for efficient widget rebuilding
    Implemented immutable state management
    Minimal widget rebuilds through proper state management

Areas for Future Implementation
1. HTTP/Dio Package Setup

Currently using mock data. To implement:

    
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: Duration(seconds: 5),
  receiveTimeout: Duration(seconds: 3),
));

    

2. Offline Support

To implement:

    Add Hive or SQLite for local storage
    Implement repository pattern with local cache
    Add synchronization logic

    
class CylinderRepository {
  final LocalStorage localStorage;
  final ApiClient apiClient;

  Future<List<Cylinder>> getCylinders() async {
    try {
      final cylinders = await apiClient.fetchCylinders();
      await localStorage.saveCylinders(cylinders);
      return cylinders;
    } catch (e) {
      return localStorage.getCylinders();
    }
  }
}

    

3. Security

To implement:

    Add SSL pinning
    Implement secure storage for sensitive data
    Add authentication and authorization
    Implement input validation and sanitization

4. Testing

To implement:

    Unit tests for business logic
    Widget tests for UI components
    Integration tests for full features Example test structure:

    
void main() {
  group('Cylinder Repository Tests', () {
    test('should return list of cylinders when API call is successful', () async {
      // Test implementation
    });

    test('should return cached cylinders when API call fails', () async {
      // Test implementation
    });
  });
}

    
