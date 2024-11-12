import 'package:go_router/go_router.dart';
import 'package:store_app/Features/authentication/presentation/view/widgets/login.dart';
import 'package:store_app/Features/layout/view/layout_view.dart';
import 'package:store_app/Features/layout/view/widget/layout_view_body.dart';

abstract class AppRouter {
  static const kregister = '/kregister';
  static const klogin = '/klogin';
  static const khomeview = '/khomeview';
  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginView()),
    GoRoute(path: kregister, builder: (context, state) => const LayoutView()),
    GoRoute(path: klogin, builder: (context, state) => const LoginView()),
    GoRoute(path: khomeview, builder: (context, state) => LayoutViewBody()),
  ]);
}
