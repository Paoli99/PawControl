import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pawcontrol/constants/colors.dart';

void showMessage(BuildContext context, String message) {
  Flushbar(
    message: '$message',
    duration: Duration(milliseconds: 2500),
    backgroundColor: ColorsApp.redAccent400,
    messageColor: ColorsApp.white,
    icon: Icon(
      Icons.error_outline_outlined,
      color: ColorsApp.white,
    ),
  ).show(context);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFFFF405C),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading..."),
            ),
          ],
        ),
      );
    }),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "El correo ya se encuentra registrado.";
    case "account-exists-with-different-credential":
      return "El correo ya se encuentra registrado.";
    case "email-already-in-use":
      return "El correo ya se encuentra registrado.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Contraseña incorrecta";
    case "ERROR_USER_NOT_FOUND":
      return "Usuario no encontrado.";
    case "user-not-found":
      return "Usuario no encontrado.";
    case "invalid-credential":
      return "Usuario no encontrado.";
    case "ERROR_USER_DISABLED":
      return "Usuario no habilitado.";
    case "user-disabled":
      return "Usuario no habilitado.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Demasiadas solicitudes para iniciar sesión en esta cuenta.";
    case "operation-not-allowed":
      return "Demasiadas solicitudes para iniciar sesión en esta cuenta.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Demasiadas solicitudes para iniciar sesión en esta cuenta.";
    case "ERROR_INVALID_EMAIL":
      return "Correo no válido.";
    case "invalid-email":
      return "Correo no válido.";
    default:
      return "Inicio de sesión incorrecto. Por favor, inténtelo de nuevo.";
  }
}

bool loginValidation(BuildContext context, String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage(context, "Por favor, llene las casillas");
    return false;
  } else if (email.isEmpty) {
    showMessage(context, "Por favor, ingrese su correo electrónico");
    return false;
  } else if (password.isEmpty) {
    showMessage(context, "Por favor, ingrese su contraseña");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(BuildContext context, String firstName,String lastName, String phone , String address, String email, String password, String confirmPassword) {
  if (firstName.isEmpty && lastName.isEmpty && phone.isEmpty && address.isEmpty && email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
    showMessage(context, "Por favor, llene las casillas.");
    return false;
  } else if (firstName.isEmpty) {
    showMessage(context, "Por favor, ingrese un nombre.");
    return false;
  } else if (lastName.isEmpty) {
    showMessage(context, "Por favor, ingrese un apellido.");
    return false;
  } else if (phone.isEmpty && phone.length != 8 ) {
    showMessage(context, "Por favor, ingrese un numero de teléfono válido.");
    return false;
  }else if (address.isEmpty) {
    showMessage(context, "Por favor, ingrese una dirección.");
    return false;
  } else if (email.isEmpty) {
    showMessage(context, "Por favor, ingrese un correo electrónico.");
    return false;
  } else if (password.isEmpty) {
    showMessage(context, "Por favor, ingrese una contraseña.");
    return false;
  } else if (password != confirmPassword) {
    showMessage(context, "Las contraseñas no coinciden.");
    return false;
  } else {
    return true;
  }
}

