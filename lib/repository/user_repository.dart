import 'package:flutter/material.dart';

abstract class UserRepository {
  void checkUser();

  Future<void> createUser(BuildContext context, String email, String senha);

  Future<void> userSignIn(BuildContext context, String email, String password);
}
