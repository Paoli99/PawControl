// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, prefer_const_constructors, unnecessary_string_interpolations, avoid_print, use_rethrow_when_possible
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

void showGoodMessage(BuildContext context, String message) {
  Flushbar(
    message: '$message',
    duration: Duration(milliseconds: 2500),
    backgroundColor: ColorsApp.greenAccent400,
    messageColor: ColorsApp.white,
    icon: Icon(
      Icons.check_circle_outline,
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

Future<bool> isValidEmail(BuildContext context, String email) async {
  if (email.isEmpty) {
    showMessage(context, "Por favor, ingrese un correo electrónico.");
    return false;
  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email)) {
    showMessage(context, "El correo electrónico no tiene un formato válido.");
    return false;
  } else {
    try {
      bool emailExists = await checkIfEmailExistsInDatabase(email);
      if (!emailExists) {
        showMessage(context, "El correo electrónico no existe en la base de datos.");
      }
      return emailExists;
    } catch (e) {
      print('Error al verificar la existencia del correo en la base de datos: $e');
      showMessage(context, "Error al verificar la existencia del correo en la base de datos.");
      return false;
    }
  }
}

Future<bool> checkIfEmailExistsInDatabase(String email) async {
  try {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    return query.docs.isNotEmpty;
  } catch (e) {
    print('Error al verificar la existencia del correo en la base de datos: $e');
    throw e; 
  }
}


void updateUserInfo({
  required String userId,
  required String firstName,
  required String lastName,
  required String phone,
  required String address,
  required BuildContext context, 
}) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
    });
    showGoodMessage(context, 'Información del usuario actualizada correctamente en la base de datos');
  } catch (e) {
    showMessage(context, 'Error al actualizar la información del usuario: $e');
  }
}

Future<bool> registerPet({
  required BuildContext context,
  required String petName,
  required String selectedSpecies,
  required String selectedBreed,
  required String selectedSex,
  required String selectedColor,
  required String imageUrl,
  required DateTime selectedDate,
}) async {
  if (petName.isEmpty ||
      selectedSpecies.isEmpty ||
      selectedBreed.isEmpty ||
      selectedSex.isEmpty ||
      selectedColor.isEmpty ||
      imageUrl.isEmpty ||
      selectedDate == null) {
    String errorMessage = 'Por favor, complete todos los campos:\n';
    if (petName.isEmpty) {
      errorMessage += '- Ingrese el nombre de su mascota.\n';
    }
    if (selectedSpecies.isEmpty) {
      errorMessage += '- Seleccione la especie de su mascota.\n';
    }
    if (selectedBreed.isEmpty) {
      errorMessage += '- Seleccione la raza de su mascota.\n';
    }
    if (selectedSex.isEmpty) {
      errorMessage += '- Seleccione el sexo de su mascota.\n';
    }
    if (selectedColor.isEmpty) {
      errorMessage += '- Seleccione el color de su mascota.\n';
    }
    if (imageUrl.isEmpty) {
      errorMessage += '- Seleccione una imagen para su mascota.\n';
    }
    if (selectedDate == null) {
      errorMessage += '- Seleccione la fecha de nacimiento de su mascota.\n';
    }
    showMessage(context, errorMessage);
    return false;
  }

  showGoodMessage(context, 'Mascota registrada exitosamente.');
  return true;
}

Future<bool> validateLostPetForm({
  required BuildContext context,
  required String name,
  required String date,
  required String location,
  required String description,
  required int phone,
  required String imageUrl,
}) async {
  if (name.isEmpty || date.isEmpty || location.isEmpty || description.isEmpty || phone <= 0 || imageUrl.isEmpty) {
    showMessage(context, "Por favor, complete todos los campos antes de publicar.");
    return false;
  } else {
    return true;
  }
}

Future<bool> validateVaccineForm({
  required BuildContext context,
  required String vaccineName,
  required String productName,
  required String vaccineDate,
  required String nextVaccineDate,
  required List<String> imageUrls,
}) async {
  if (vaccineName.isEmpty || productName.isEmpty || vaccineDate.isEmpty || nextVaccineDate.isEmpty || imageUrls.any((url) => url.isEmpty)) {
    String errorMessage = "Por favor, complete todos los campos antes de registrar la vacuna:\n";
    if (vaccineName.isEmpty) {
      errorMessage += "- Ingrese el nombre de la vacuna.\n";
    }
    if (productName.isEmpty) {
      errorMessage += "- Ingrese el nombre del producto.\n";
    }
    if (vaccineDate.isEmpty) {
      errorMessage += "- Ingrese la fecha de vacunación.\n";
    }
    if (nextVaccineDate.isEmpty) {
      errorMessage += "- Ingrese la fecha de la próxima vacuna.\n";
    }
    if (imageUrls.any((url) => url.isEmpty)) {
      errorMessage += "- Suba todas las imágenes requeridas.\n";
    }
    showMessage(context, errorMessage);
    return false;
  }
  showGoodMessage(context, "Vacuna registrada exitosamente.");
  return true;
}