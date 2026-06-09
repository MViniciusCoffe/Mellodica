class FieldsValidators {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email é obrigatório";
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value) ? null : "E-mail Inválido";
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Senha é obrigatória";
    if (value.length < 6) return "Senha deve ter pelo menos 6 caracteres";
    return null;
  }

  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "$fieldName é obrigatório";
    return null;
  }
}
