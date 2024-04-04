import 'package:chataty/features/contact/repo/contact_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsControllerProvider = FutureProvider((ref) {
  final contactsController = ref.watch(contactsRepoProvider);

  return contactsController.getAllContacts();
});
