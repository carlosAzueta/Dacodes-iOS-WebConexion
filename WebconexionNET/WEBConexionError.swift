//
//  WEBConexionError.swift
//  WebconexionNET
//
//  Created by Carlos Azueta on 08/02/18.
//  Copyright © 2018 Carlos Azueta. All rights reserved.
//

import UIKit

class WEBConexionError: WEBConexion {

    var message:String = ""
    var codeError:String = ""
    
    /// Errores de la conexion API
    ///
    /// - Parameters:
    ///   - statusCodeError: codigo de tipo de error en int, este codigo lo proporciona alamorfire.
    ///   - handler: retorna el tipo de error en forma de objeto WBError, contiene el mensage y un boleao indicando su hubo error.
    func validErrorStsatusCode (statusCodeError:Int,xMessage:String?,handler:@escaping(WEBConexionError,Bool)->Void) {
        
        print("ErrorStatudCode: \(statusCodeError)")
        
        let error:WEBConexionError = WEBConexionError()
        
        switch statusCodeError {
            
        case 204:// - No Content
            error.message = "Ningún resultado." //NSLocalizedString("NO_CONTENT", comment: "NO_CONTENT")//"Ningún resultado."
            handler(error,true)
            
        case 400 :// - Bad Request
            error.message = xMessage!//"La operación no se pudo completar, intente más tarde."//NSLocalizedString("BAD_REQUEST", comment: "BAD_REQUEST")//"La operación no se pudo completar, intente más tarde."
            handler(error,true)
            
        case 401 :// - Unauthorized
            
            error.message = xMessage ?? "Unauthorized."//NSLocalizedString("UNAUTHORIZED", comment: "UNAUTHORIZED")//"rechazado no tien permisos."
            handler(error,true)
            
        case 404:// - Not Found
            error.message = "Recurso no encontrado."//NSLocalizedString("NOT_FOUND", comment: "NOT_FOUND")//"Recurso no encontrado."
            handler(error,true)
            
        case 500:// - Internal Server Error
            error.message = "Error interno del servidor"
            handler(error,true)//NSLocalizedString("ERROR_INTERNAL_SERVER", comment: "ERROR_INTERNAL_SERVER")//"Error interno del servidor"
            
        case -999 :
            error.message = "Peticion Cancelada"//NSLocalizedString("REQUEST_CANCEL", comment: "REQUEST_CANCEL")//"Peticion Cancelada"
            handler(error,true)
            
        case -1001 :
            error.message = "Tiempo de espera agotado"//NSLocalizedString("TIME_OUT", comment: "TIME_OUT")//"Tiempo de espera agotado"
            handler(error,true)
            
        case -1002 : error.message = "unsupported URL"//NSLocalizedString("TIME_OUT", comment: "TIME_OUT")//"Tiempo de espera agotado"
        handler(error,true)
            
        case -1009:// - Sin conexion a internet.
            error.message = "Sin acceso a internet"// NSLocalizedString("NO_INTERNET_CONNECTION", comment: "NO_INTERNET_CONNECTION")//"Sin acceso a internet"
            handler(error,true)
            
        default:
            error.message = ""
            handler(error,false)
        }
        
    }
    
}


