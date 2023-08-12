part of 'register_view.dart';

class RegisterStep1Section extends StatelessWidget {
  const RegisterStep1Section({super.key, required this.vm});
  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(
          text: LocaleKeys
              .auth_register_youMustEnterThisRequiredInformationToRegister
              .tr(),
        ),
        context.emptySizedHeightBoxLow3x,
        vm.nameInput,
        context.emptySizedHeightBoxLow,
        vm.emailInput,
        context.emptySizedHeightBoxLow,
        vm.passwordInput,
      ],
    );
  }
}

class RegisterStep2Section extends StatelessWidget {
  const RegisterStep2Section({super.key, required this.vm});
  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(
          text: LocaleKeys
              .auth_register_nowLetsContinueWithSomeOfYourPersonalInformation
              .tr(),
        ),
        context.emptySizedHeightBoxLow3x,
        vm.ageInput,
        context.emptySizedHeightBoxLow,
        InkWell(
          child: vm.genderInput,
          onTap: () => genderModalBottomSheet(context),
        ),
        context.emptySizedHeightBoxLow,
        InkWell(
          child: vm.countryInput,
          onTap: () => countriesModalBottomSheet(context),
        ),
      ],
    );
  }

  Future<dynamic> genderModalBottomSheet(BuildContext context) {
    return showStandartModalBottomSheet(
      context,
      isDynamicHeight: true,
      child: Column(
        children: [
          SelectCard(
            leading: const Icon(Icons.female),
            title: Text(
              LocaleKeys.auth_register_woman.tr(),
            ),
            trailing: Radio(
              value: vm.gender == Gender.female.name,
              groupValue: true,
              onChanged: (value) => selectGender(context),
            ),
            onTap: () => selectGender(context),
          ),
          SelectCard(
            leading: const Icon(Icons.male),
            title: Text(
              LocaleKeys.auth_register_man.tr(),
            ),
            trailing: Radio(
              value: vm.gender == Gender.male.name,
              groupValue: true,
              onChanged: (value) => selectGender(context),
            ),
            onTap: () => selectGender(context),
          ),
        ],
      ),
    );
  }

  Future<dynamic> countriesModalBottomSheet(BuildContext context) {
    return showStandartModalBottomSheet(
      context,
      child: ListView.separated(
        itemCount: vm.countries.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final currentCountry = vm.countries[index];
          return SelectCard(
            title: Text(
              currentCountry.name ?? AppStrings.empty,
            ),
            leading: Transform.scale(
              scale: NumberEnum.oneFive.value,
              child: Text(
                currentCountry.emoji ?? AppStrings.empty,
              ),
            ),
            onTap: () => selectCountry(index, context),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          color: AppColors.athensGray,
        ),
      ),
    );
  }

  void selectGender(BuildContext context) {
    vm.selectGender();
    context.pop();
  }

  void selectCountry(int index, BuildContext context) {
    vm.selectCountry(index);
    context.pop();
  }
}

class RegisterStep3Section extends StatelessWidget {
  const RegisterStep3Section({super.key, required this.vm});
  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(
          text: LocaleKeys
              .auth_register_enterTheUsernameOfTheSocialMediaAccountsYouWantToShare
              .tr(),
        ),
        context.emptySizedHeightBoxLow3x,
        vm.snapchatInput,
        context.emptySizedHeightBoxLow,
        vm.instagramInput,
        context.emptySizedHeightBoxLow,
        vm.twitterInput,
      ],
    );
  }
}

class RegisterStep4Section extends StatelessWidget {
  const RegisterStep4Section({super.key, required this.vm});

  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleLargeText(
          text: LocaleKeys.auth_register_finallyLetsAddPhoto.tr(),
        ),
        context.emptySizedHeightBoxLow3x,
        Observer(builder: (_) {
          return Expanded(
            child: InkWell(
              onTap: vm.image == null ? () => addPhoto(context) : null,
              borderRadius: context.normalBorderRadius,
              child: Container(
                width: context.width,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: context.normalBorderRadius,
                  color: AppColors.athensGray,
                ),
                child: vm.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : vm.image != null
                        ? ClipRRect(
                            borderRadius: context.normalBorderRadius,
                            child: Image.file(
                              vm.image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.add_circle_outline,
                            size: NumberEnum.oneHundredTwentyEight.value,
                            color: AppColors.blueRibbon,
                          ),
              ),
            ),
          );
        }),
        context.emptySizedHeightBoxLow3x,
      ],
    );
  }

  Future<void> addPhoto(BuildContext context) async {
    final result = await vm.selectImage();
    if (result.success == false) {
      if (context.mounted) {
        responseError(context, result);
      }
    }
  }
}
