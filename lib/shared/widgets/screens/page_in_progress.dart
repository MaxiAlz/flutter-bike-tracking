import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageInProgress extends ConsumerWidget {
  const PageInProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titlesStyle = Theme.of(context);
    final router = ref.read(goRouterProvider);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: titlesStyle.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // Color blanco para el icono de retroceso
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Oops! 404 :(',
                style: titlesStyle.textTheme.titleLarge,
              ),
            ),
          ),
          Center(
            child: Text(
              'Pagina en construccion',
              style: titlesStyle.textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Center(
            child: Text(
              'Estamos trabajando para ustedes.',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/undraw_work_in_progress_re_byic.svg',
                width: 350.0,
              ),
            ),
          ),
          CustomFilledButtom(
              text: 'Volver a home',
              onPressed: () async {
                router.go('/');
              })
        ],
      ),
    );
  }
}
