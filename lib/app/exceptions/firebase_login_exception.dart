import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLoginException implements FirebaseAuthException {
  
  static const Map<String, String> erros = {
    'EMAIL_EXISTS':'o endereço de e-mail já está sendo usado por outra conta.',
    'OPERATION_NOT_ALLOWED':'o login por senha está desabilitado para este projeto.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':'bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.',
    'EMAIL_NOT_FOUND':'Não há registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.',
    'INVALID_PASSWORD':'A senha é inválida ou o usuário não possui senha.',
    'USER_DISABLED':'A conta de usuário foi desabilitada por um administrador.',
    'user-not-found':'Usuário não encontrado.'
  };
  final String key;

  FirebaseLoginException(this.key);

  @override
  String toString() {
    return erros[key] ?? 'ocorreu um erro na autenticação';
  }
  
  @override
  // TODO: implement code
  String get code => throw UnimplementedError();
  
  @override
  // TODO: implement credential
  AuthCredential? get credential => throw UnimplementedError('Houve algo de errado!');
  
  @override
  // TODO: implement email
  String? get email => throw UnimplementedError();
  
  @override
  // TODO: implement message
  String? get message => throw UnimplementedError();
  
  @override
  // TODO: implement phoneNumber
  String? get phoneNumber => throw UnimplementedError();
  
  @override
  // TODO: implement plugin
  String get plugin => throw UnimplementedError();
  
  @override
  // TODO: implement stackTrace
  StackTrace? get stackTrace => throw UnimplementedError();
  
  @override
  // TODO: implement tenantId
  String? get tenantId => throw UnimplementedError();
}