import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:sneepy/feature/profie/settings/view/profile_settings_view.dart';
import 'package:sneepy/feature/profie/settings/viewmodel/settings_viewmodel.dart';
import 'package:sneepy/product/widgets/button/standart_text_button.dart';
import 'package:sneepy/product/widgets/container/standart_container.dart';

import '../../../../product/constant/colors.dart';

class PhotosView extends StatelessWidget {
  PhotosView({super.key});
  final _vm = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    Future<File?> selectImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Column(
        children: [
          context.emptySizedHeightBoxLow3x,
          StandartContainer(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 9 / 16,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 5,
                              width: 64,
                              margin: context.verticalPaddingNormal,
                              decoration: BoxDecoration(
                                color: AppColors.athensGray,
                                borderRadius: context.highBorderRadius,
                              ),
                            ),
                            SettingsListTile(
                              text: 'text',
                              onTap: () async {
                                final image = await selectImage();
                                if (image != null) {
                                  _vm.setImage(index, image);
                                }
                              },
                            ),
                            SettingsListTile(
                              text: 'text',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('data'),
                                      actions: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: StandartTextButton(
                                                text: 'text',
                                                onPressed: () {},
                                              ),
                                            ),
                                            context.emptySizedWidthBoxLow3x,
                                            Expanded(
                                              child: StandartTextButton(
                                                text: 'text',
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  borderRadius: context.normalBorderRadius,
                  child: Observer(
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: context.normalBorderRadius,
                        color: AppColors.athensGray,
                      ),
                      child: _vm.images[index] != null
                          ? ClipRRect(
                              borderRadius: context.normalBorderRadius,
                              child: Image.file(
                                _vm.images[index]!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.add_circle_outline,
                              size: 72,
                              color: AppColors.blueRibbon,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}
