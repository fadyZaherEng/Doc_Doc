import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/add_payment/add_payment_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/badge_identity/badge_identity_bloc/badge_identity_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<LogInBloc>(
    () => LogInBloc(
      injector(),
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<AddPaymentBloc>(
    () => AddPaymentBloc(),
  );
  injector.registerSingleton<BadgeIdentityBloc>(BadgeIdentityBloc());
}
