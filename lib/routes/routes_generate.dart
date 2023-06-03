import 'package:cyclego/routes/routes.dart';
import 'package:flutter/cupertino.dart';

class GeneratedRoute {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.arguments != null) {
      Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;

      // if (arguments['type'] == 'drawerRight') {
      //   return _drawerRightPageRouteBuilder(settings);
      // }

      switch (arguments['animation']) {
        // case 'slideInRight':
        //   return _slideInRightPageRouteBuilder(settings);
        // case 'slideInTop':
        //   return _slideInTopPageRouteBuilder(settings);
        // case 'fall':
        //   return _fallPageRouteBuilder(settings);
        case 'fade':
          return _fadePageRouteBuilder(settings);
      }
    }
    return CupertinoPageRoute(
        settings: settings,
        builder: (context) => getRoutes[settings.name]!(settings.arguments));
  }

  static PageRouteBuilder<dynamic> _fadePageRouteBuilder(
      RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          getRoutes[settings.name]!(settings.arguments),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
        child: child,
      ),
    );
  }

  // static PageRouteBuilder<dynamic> _fallPageRouteBuilder(
  //     RouteSettings settings) {
  //   return PageRouteBuilder(
  //     settings: settings,
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         getRoutes[settings.name]!(settings.arguments),
  //     transitionsBuilder: (
  //       BuildContext context,
  //       Animation<double> animation,
  //       Animation<double> secondaryAnimation,
  //       Widget child,
  //     ) =>
  //         ScaleTransition(
  //       scale: Tween<double>(
  //         begin: 3,
  //         end: 1,
  //       ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
  //       child: FadeTransition(
  //         opacity: Tween<double>(
  //           begin: 0,
  //           end: 1,
  //         ).animate(
  //             CurvedAnimation(parent: animation, curve: Curves.easeInExpo)),
  //         child: child,
  //       ),
  //     ),
  //   );
  // }

  // static PageRouteBuilder<dynamic> _slideInTopPageRouteBuilder(
  //     RouteSettings settings) {
  //   return PageRouteBuilder(
  //     settings: settings,
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         getRoutes[settings.name]!(settings.arguments),
  //     transitionsBuilder: (
  //       BuildContext context,
  //       Animation<double> animation,
  //       Animation<double> secondaryAnimation,
  //       Widget child,
  //     ) =>
  //         SlideTransition(
  //       position: Tween<Offset>(
  //         begin: const Offset(0, -1),
  //         end: Offset.zero,
  //       ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
  //       child: FadeTransition(
  //         opacity: Tween<double>(
  //           begin: 0,
  //           end: 1,
  //         ).animate(
  //             CurvedAnimation(parent: animation, curve: Curves.easeInExpo)),
  //         child: child,
  //       ),
  //     ),
  //   );
  // }

  // static PageRouteBuilder<dynamic> _slideInRightPageRouteBuilder(
  //     RouteSettings settings) {
  //   return PageRouteBuilder(
  //     settings: settings,
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         getRoutes[settings.name]!(settings.arguments),
  //     transitionsBuilder: (
  //       BuildContext context,
  //       Animation<double> animation,
  //       Animation<double> secondaryAnimation,
  //       Widget child,
  //     ) =>
  //         SlideTransition(
  //       position: Tween<Offset>(
  //         begin: const Offset(1, 0),
  //         end: Offset.zero,
  //       ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
  //       child: FadeTransition(
  //         opacity: Tween<double>(
  //           begin: 0,
  //           end: 1,
  //         ).animate(
  //             CurvedAnimation(parent: animation, curve: Curves.easeInExpo)),
  //         child: child,
  //       ),
  //     ),
  //   );
  // }

  // static PageRouteBuilder<dynamic> _drawerRightPageRouteBuilder(
  //     RouteSettings settings) {
  //   return PageRouteBuilder(
  //     opaque: false,
  //     settings: settings,
  //     barrierColor: Colors.black12,
  //     barrierDismissible: true,
  //     pageBuilder: (context, anim, anim2) => Row(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Row(),
  //         ),
  //         Expanded(
  //           flex: 4,
  //           child: getRoutes[settings.name]!(settings.arguments),
  //         )
  //       ],
  //     ),
  //     transitionsBuilder: (
  //       BuildContext context,
  //       Animation<double> animation,
  //       Animation<double> secondaryAnimation,
  //       Widget child,
  //     ) =>
  //         SlideTransition(
  //       position: Tween<Offset>(
  //         begin: const Offset(1, 0),
  //         end: Offset.zero,
  //       ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
  //       child: child,
  //     ),
  //   );
  // }
}
