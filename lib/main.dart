
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gellery/Core/unit/app_router.dart';
import 'package:my_gellery/Feather/auth/presentation/manager/auth_cubit.dart';
import 'package:my_gellery/Feather/gallery/presentation/manager/gallery_cubit.dart';
import 'Core/helper/shared_pref_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServices.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider (create: (BuildContext context) => AuthCubit(),),
      BlocProvider (create: (BuildContext context) => GalleryCubit(),),
    ],
    child: const MyApp(),));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Gallery',
      routerConfig: AppRouter.router,
    );
  }
}

