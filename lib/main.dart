import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendorapp/Login/login_page.dart';
import 'package:vendorapp/homepage.dart';
import 'package:vendorapp/models/session_model.dart';
import 'package:vendorapp/models/vendor_models.dart';
import 'package:vendorapp/providers/cart_provider.dart';
import 'package:vendorapp/session/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(VendorModelAdapter());
  Hive.registerAdapter(SessionModelAdapter());
  await Hive.openBox<VendorModel>('vendorBox');
  await Hive.openBox<SessionModel>('sessionBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    _isLoggedInFuture = SessionManager.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Vendor App',
        home: FutureBuilder<bool>(
          future: _isLoggedInFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(child: Text('Unable to load session')),
              );
            }
            final isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? const Homepage() : const LoginPage();
          },
        ),
      ),
    );
  }
}