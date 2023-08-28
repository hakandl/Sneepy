// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendsViewModel on _FriendsViewModelBase, Store {
  late final _$friendUserAtom =
      Atom(name: '_FriendsViewModelBase.friendUser', context: context);

  @override
  UserModel? get friendUser {
    _$friendUserAtom.reportRead();
    return super.friendUser;
  }

  @override
  set friendUser(UserModel? value) {
    _$friendUserAtom.reportWrite(value, super.friendUser, () {
      super.friendUser = value;
    });
  }

  @override
  String toString() {
    return '''
friendUser: ${friendUser}
    ''';
  }
}
