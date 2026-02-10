import 'package:almonafs_flutter/almonafs_app.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:almonafs_flutter/config/cache/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    BlocProvider(create: (_) => LanguageCubit(), child: const AlmonafsApp()),
  );
}
