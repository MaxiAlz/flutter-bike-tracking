import 'package:app_ciudadano_vc/feactures/auth/presentation/auth_presentation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PageController pageController = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/vamos-en-bici-01.png', width: 250),
            SizedBox(
              height: 450,
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPageIndex = value;
                  });
                },
                children: const [
                  PersonalInformationForm(),
                  NumberIdentificationForm(),
                  UploadFiles()
                ],
              ),
            ),
            _NavigateButtons(
                currentPageIndex: currentPageIndex,
                pageController: pageController),
          ],
        ),
      ),
    );
  }
}

class _NavigateButtons extends StatelessWidget {
  const _NavigateButtons({
    required this.currentPageIndex,
    required this.pageController,
  });

  final int currentPageIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter / 1.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: currentPageIndex > 0
                  ? () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  : null,
              child: const Text('Anterior'),
            ),
          ),
          const SizedBox(width: 16), // Espacio entre botones
          Expanded(
              flex: 1,
              child: currentPageIndex < 2
                  ? ElevatedButton(
                      onPressed: currentPageIndex < 2
                          ? () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            }
                          : null,
                      child: const Text('Siguiente'),
                    )
                  : FilledButton(
                      onPressed: () {}, child: const Text('Finalizar'))),
        ],
      ),
    );
  }
}
