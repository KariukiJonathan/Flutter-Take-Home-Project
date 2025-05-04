// import 'package:cylinder_app/data/services/order_storage_service.dart';
// import 'package:cylinder_app/presentation/redux/actions.dart';
import 'package:cylinder_app/presentation/screens/cart_screen.dart';
import 'package:cylinder_app/presentation/screens/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/redux/app_state.dart';
import 'presentation/redux/reducer.dart';
import 'presentation/redux/middleware.dart';
import 'presentation/screens/home_screen.dart';


void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // final prefs = await SharedPreferences.getInstance();
  // final orderStorage = OrderStorageService(prefs);
  
  // Create the Redux store
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState.initial(),
    middleware: createMiddleware(),
  );

  // store.dispatch(FetchOrdersAction());
  
  // Run the app
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'LPG Cylinder App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // Optional: Add more theme customization
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: HomeScreen(),
        // Optional: Add named routes for navigation
        routes: {
          '/home': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
          '/order-history': (context) => OrderHistoryScreen(),
        },
      ),
    );
  }
}

// Optional: Add error handling
class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Error',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(message),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
