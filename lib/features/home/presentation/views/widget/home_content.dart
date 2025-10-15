import 'package:almonafs_flutter/features/home/manager/country_cubit.dart';
import 'package:almonafs_flutter/features/home/presentation/views/widget/home_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/country_repo.dart';


class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryCubit(CountryRepository())..fetchAllCountries(),
      child: const HomeScreenContent(),
    );
  }
}
