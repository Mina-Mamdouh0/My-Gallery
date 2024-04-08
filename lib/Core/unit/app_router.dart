
import 'package:go_router/go_router.dart';
import 'package:my_gellery/Core/helper/shared_pref_services.dart';
import 'package:my_gellery/Core/unit/constant_data.dart';
import 'package:my_gellery/Feather/auth/presentation/view/login_view.dart';
import 'package:my_gellery/Feather/gallery/presentation/view/gallery_view.dart';


abstract class AppRouter {

  static const kLoginView='/LoginView';
  static const kGalleryView='/GalleryView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => (SharedPreferencesServices.getDate(key: ConstantData.kLogin)??false)?  const GalleryView() :LoginView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) =>  LoginView(),
      ),
      GoRoute(
        path: kGalleryView,
        builder: (context, state) => const GalleryView(),
      ),
    ],
  );
}