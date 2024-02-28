import 'package:flutter/material.dart';

class PersonalInformationForm extends StatelessWidget {
  // final TextEditingController textController;
  // final FocusNode focusNode;
  const PersonalInformationForm({
    super.key,
    // required this.focusNode,
    // required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Ingresa tus datos',
            style: titleStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Nombre',
                labelText: 'Nombre'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Apellido',
                labelText: 'Apellido'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Correo electronico',
                labelText: 'Correo electronico'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Fecha de nacimiento',
                labelText: 'Fecha de nacimiento'),
          ),
        ],
      ),
    );
  }
}
