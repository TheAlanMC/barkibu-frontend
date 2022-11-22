import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PetQuestionCard extends StatelessWidget {
  final String question;
  final String detail;
  final String? photoPath;
  final String petName;
  final DateTime postedDate;
  final String? buttonText;
  final VoidCallback? onPressed;
  final int? likes;
  final bool buttonVisible;
  final bool likeVisible;

  const PetQuestionCard({
    Key? key,
    required this.question,
    required this.detail,
    this.photoPath,
    required this.petName,
    required this.postedDate,
    this.buttonText,
    this.onPressed,
    this.likes,
    this.buttonVisible = false,
    this.likeVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomCircleAvatar(
                  photoPath: photoPath ?? 'assets/default_pet.jpg',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 100,
                  child: Text(
                    petName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                if (buttonVisible)
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: onPressed,
                      child: Text(
                        buttonText!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    detail,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: likeVisible ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                    children: [
                      if (likeVisible)
                        Row(
                          children: [
                            const Icon(Icons.thumb_up),
                            Text(
                              ' +$likes',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      Text(DateUtil.getDateString(postedDate)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
