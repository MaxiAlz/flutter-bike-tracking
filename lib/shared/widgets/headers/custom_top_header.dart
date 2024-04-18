import 'package:flutter/material.dart';

class CustomTopHeader extends StatelessWidget {
  const CustomTopHeader({
    super.key,
    this.icon,
    required this.titleHeader,
    this.urlPhotoAvatar,
  });

  final IconData? icon;
  final String titleHeader;
  final String? urlPhotoAvatar;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: colors.primary,

        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          icon != null
              ? Icon(
                  icon,
                  color: Color.fromARGB(255, 255, 208, 0),
                  size: 50,
                )
              : const SizedBox(),
          urlPhotoAvatar != null
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(urlPhotoAvatar ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          Text(
            titleHeader,
            style: subtitlesStyle!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
