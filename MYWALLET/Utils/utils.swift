//
//  utils.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 20/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import PKHUD

struct Constants {
    struct Servers {
        static let URL_SERVER = "http://209.222.19.75/wsAutorizador/api/autorizador/"
        static let endLogin = "AUTORIZADOR_ValidaUsuario/"
        static let endSMS = "AUTORIZADOR_ValidacionSMS"
        static let endMovements = "AUTORIZADOR_GetSaldosMovimientos"
        static let endAutorizacion = "AUTORIZADOR_ResultadoTransaccion"
        static let ENDS: [String: String] = [
            "LOGIN": endLogin,
            "SMS": endSMS,
            "MOVEMENTS": endMovements,
            "AUTORIZADOR": endAutorizacion
        ]
        static let timeOut = 30.0
    }
    
    struct ServerParameters {
        static var LOGIN: [String: String] = [
            "Telefono": ""
        ]
        static var SMS: [String: String] = [
            "Telefono":"",
            "OneSignalUserID":"1234",
            "OneSignalRegistrationID":"1234",
            "CodigoValidacion":"123456"
        ]
        static var MOVEMENTS: [String: String] = [
            "TokenSeguridad":""
        ]
        static var AUTORIZE: [String: Any] = [
            "EsAutorizado":true,
            "ID_Operacion":"123"
        ]
        static let PARAMETERS: [String: [String: String]] = [
            "LOGIN": LOGIN,
            "SMS": SMS,
            "MOVEMENTS": MOVEMENTS
        ]
    }
    
    struct TextFieldsHeaderView {
        static let MY_WALLET = "My Wallet"
        static let LOGIN = "LOGIN"
        static let SMS_VALIDATION = "SMS Validación"
    }
    struct textAlertParam {
        static let SIMPLEALERTH = "Aviso"
        static let SIMPLEALERTB = "Aun no ha ingresado el número, por favor intente otra vez"
        static let SIMPLEALERTBUT = "OK"
        static let HEADER1 = "Para vincular la aplicacion a tu cuenta por favor introduce tu número telefónico"
        static let MESSAGEBODDY1 = "Teléfono"
        static let MESSAGEBUTTON1 = "INGRESAR"
        static let TEXTALERTPARAM2 = [
            "titleHeader":"Introduce el código de validación que recibiste vía SMS",
            "messageBody":"Código de validación",
            "messageButton":"VALIDAR",
            ]
        static let TEXTALERTPARAMETERSINCORRECT = [
            "titleHeader":"El código de validación es incorrecto, por favor intenta nuevamente",
            "messageBody":"Código de validación",
            "messageButton":"VALIDAR",
            ]
        static let TEXTALERTPARAMETERSINCORRECTLOGIN = [
            "titleHeader":"El número que ingresó no es valido, por favor intente de nuevo",
            "messageBody":"Número",
            "messageButton":"INGRESAR",
            ]
    }
    struct progressIndicator {
        static func viewProgress() {
            HUD.show(.progress)
        }
        static func dismissProgress() {
            HUD.hide()
        }
        static func progressText(_ title: String, _ subtitle: String) {
            HUD.show(.labeledProgress(title: title, subtitle: subtitle))
            if HUD.isVisible {
                HUD.hide(afterDelay: Servers.timeOut, completion: {
                    error in
                    HUD.show(.label("Internet connection is failed, please check the connection and try again"))
                    HUD.hide(afterDelay: 6.0)
                })
            }
        }
        static func errorProgress(_ title: String, _ subtitle: String) {
            while true {
                if !HUD.isVisible {
                    debugPrint("is not visible now")
                    //HUD.show(.labeledError(title: title, subtitle: subtitle))
                    break
                }
            }
        }
    }
}
