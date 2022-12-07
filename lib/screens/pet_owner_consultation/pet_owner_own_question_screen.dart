import 'package:barkibu/dto/owner_own_question_dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barkibu/cubit/cubit.dart';

class OwnerOwnQuestionScreen extends StatelessWidget {
  const OwnerOwnQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ownerOwnQuestionCubit = BlocProvider.of<OwnerOwnQuestionCubit>(context);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: ownerOwnQuestionCubit.getOwnerOwnQuestion(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (ownerOwnQuestionCubit.state.status) {
              case ScreenStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ScreenStatus.success:
                return const _OwnerOwnQuestion();
              case ScreenStatus.failure:
                Logout.logout(context);
                break;
            }
            return Container();
          }),
    ));
  }
}

class _OwnerOwnQuestion extends StatelessWidget {
  const _OwnerOwnQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultas'),
        centerTitle: true,
      ),
      body: BlocBuilder<OwnerOwnQuestionCubit, OwnerOwnQuestionState>(builder: (context, state) {
        return CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (state.ownerOwnQuestions!.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text('No hay consultas registradas'),
                    ),
                  ),
                for (OwnerOwnQuestionDto ownerOwnQuestionDto in state.ownerOwnQuestions!) _ownerOwnQuestionCard(context, ownerOwnQuestionDto),
                const SizedBox(height: 20),
                CustomMaterialButton(text: 'Añadir consulta', onPressed: () => Navigator.of(context).pushNamed('/pet_owner_register_question')),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ]);
      }),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 2,
      ),
    );
  }

  Widget _ownerOwnQuestionCard(BuildContext context, OwnerOwnQuestionDto ownerOwnQuestionDto) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomCircleAvatar(
                  photoPath: ownerOwnQuestionDto.photoPath ?? 'assets/default_pet.jpg',
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ownerOwnQuestionDto.problem,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ownerOwnQuestionDto.detailedDescription,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateUtil.getDateString(ownerOwnQuestionDto.questionDate)),
                      const SizedBox(height: 10),
                      CustomButtonSeeAnswers(
                          text: "Ver respuestas",
                          onPressed: () {
                            BlocProvider.of<OwnerOwnQuestionCubit>(context).setQuestionId(ownerOwnQuestionDto.questionId);
                            Navigator.of(context).pushNamed('/pet_owner_detail_question');
                          },
                          icon: Icons.remove_red_eye),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
