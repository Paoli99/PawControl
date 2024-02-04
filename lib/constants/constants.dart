import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pawcontrol/constants/colors.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    timeInSecForIosWeb: 1,
    backgroundColor: ColorsApp.red700,
    textColor: ColorsApp.white70,
    fontSize: 16.0,
  );
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
      return "No se encontró ningún usuario con este correo.";
    case "user-not-found":
      return "No se encontró ningún usuario con este correo.";
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

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Por favor, llene las casillas");
    return false;
  } else if (email.isEmpty) {
    showMessage("Por favor, ingrese su correo electrónico");
    return false;
  } else if (password.isEmpty) {
    showMessage("Por favor, ingrese su contraseña");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Por favor, llene las casillas");
    return false;
  } else if (name.isEmpty) {
    showMessage("Por favor, ingrese un nombre");
    return false;
  } else if (email.isEmpty) {
    showMessage("Por favor, ingrese un correo electrónico");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Por favor, ingrese un número telefónico");
    return false;
  } else if (password.isEmpty) {
    showMessage("Por favor, ingrese una contraseña");
    return false;
  } else {
    return true;
  }
}
