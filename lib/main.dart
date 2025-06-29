import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tech_associate/bloc/auth/auth_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/bloc/category/category_bloc.dart';
import 'package:tech_associate/bloc/department/department_bloc.dart';
import 'package:tech_associate/config/theme/theme.dart';
import 'package:tech_associate/cubit/theme.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/data/models/user.dart';
import 'package:tech_associate/data/repositories/auth_repository.dart';
import 'package:tech_associate/data/repositories/compliant_repository.dart';
import 'package:tech_associate/screens/admin/auth/sign_in.dart';
import 'package:tech_associate/screens/admin/auth/sign_up.dart';
import 'package:tech_associate/screens/admin/dashboard/dashboard.dart';
import 'package:tech_associate/screens/admin/dashboard/main_screen.dart';
import 'package:tech_associate/screens/citizens/home_screen.dart';
import 'package:tech_associate/screens/citizens/track_status.dart';
import 'package:tech_associate/data/repositories/user_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(
              (await getApplicationDocumentsDirectory()).path,
            ),
  ); 
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  Hive.registerAdapter(CompliantAdapter());
  Hive.registerAdapter(CompliantStatusAdapter());
  Hive.registerAdapter(CompliantPriorityAdapter());
  Hive.registerAdapter(SyncStatusAdapter());
  Hive.registerAdapter(UserAdapter());
  
  // Open the boxes
  await Hive.openBox<Compliant>('compliants');
  await Hive.openBox<User>('userBox');
  runApp(const MyApp());
}

// getApplicationDocumentsDirectory() {
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CompliantBloc(
            repository: CompliantRepository(
              compliantBox: Hive.box<Compliant>('compliants'),
            ),
            userRepository: UserRepository(),
          )..add(LoadCompliants()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc()..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) => DepartmentBloc()..add(LoadDepartments()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository(
            baseUrl: 'https://cms-qctx.onrender.com/user',
            userRepository: UserRepository(),
          ))
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            routes: {
              '/signIn': (context) => const SignIn(),
              '/signUp': (context) => const SignUp(),
              '/mainScreen': (context) => const MainScreen(),
              '/dashboard': (context) => const Dashboard(),
              '/trackStatus': (context) => const TrackStatus()
            },
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}