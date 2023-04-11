class AuthException implements Exception {
  
  static const Map<String, String> erros = {
    'EMAIL_EXISTS':'o endereço de e-mail já está sendo usado por outra conta.',
    'OPERATION_NOT_ALLOWED':'o login por senha está desabilitado para este projeto.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':'bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.',
    'EMAIL_NOT_FOUND':'Não há registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.',
    'INVALID_PASSWORD':'A senha é inválida ou o usuário não possui senha.',
    'USER_DISABLED':'A conta de usuário foi desabilitada por um administrador.'
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return erros[key] ?? 'ocorreu um erro na autenticação';
  }
}