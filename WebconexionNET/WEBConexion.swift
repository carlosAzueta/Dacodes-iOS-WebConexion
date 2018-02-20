//
//  WEBConexion.swift
//  WebconexionNET
//
//  Created by Carlos Azueta on 08/02/18.
//  Copyright © 2018 Carlos Azueta. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class WEBConexion: NSObject {
    
    // MARK: - Variables
    /// peticion de alamo http
    var  requestAlamo: Alamofire.Request?
    
    ///  indicatorAlamorfire
    var indicatorAlamo:UIActivityIndicatorView?
    
    /// mostrar alarta ne la peticion
    var showAlertInRequest:Bool = true
    
    // message que devuelve el header de la conexion contiene el message de error cuando es 400
    var  XResponseMessage:String?
    
    ///delegate WEBConexion
    var delegate:WEBConexionDelegate?
    
    
    // MARK: - Funcion inicial
    func callAlamo(URLString: URLConvertible,methodHttp: HTTPMethod, parameters: Parameters?, headers:HTTPHeaders?) {
        self.indicatorAlamo?.startAnimating()
        self.requestAlamo = request(URLString, method: methodHttp, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                if self.requestAlamo?.response?.statusCode != nil {
                    
                    self.estatusCode(status_code: (self.requestAlamo?.response?.statusCode)!)
                }
                
                if response.result.isFailure {
                    
                    /// error en la conexion
                    NSLog("Error: \(String(describing: response.result.error))")
                    self.didErrorConexion(error: response.result.error!)
                    
                    switch (response.result.error!._code) {
                        
                    case NSURLErrorNotConnectedToInternet, NSURLErrorTimedOut, NSURLErrorCannotParseResponse:
                        
                        ///Handler Error valid
                        /*validando el error, pasa por una clase que contiene los tipos de errores y este devuelve el mesnsage en un formato de objeto errorOBJ que contiene el codigo->statusCode y el mensage
                         */
                        WEBConexionError.init().validErrorStsatusCode(statusCodeError: response.result.error!._code, xMessage: self.XResponseMessage, handler: { (errorBOJ, isError) in
                            if isError {
                                self.showAlert(isHidden: self.showAlertInRequest, errorOBJ: errorBOJ)
                            }
                        })
                        
                        break
                    default:
                        
                        if response.response?.statusCode != nil {
                            ///Handler Error valid
                            /*validando el error, pasa por una clase que contiene los tipos de errores y este devuelve el mesnsage en un formato de objeto errorOBJ que contiene el codigo->statusCode y el mensage
                             */
                            WEBConexionError.init().validErrorStsatusCode(statusCodeError: (response.response?.statusCode)!, xMessage: nil, handler: { (errorOBJ,isError) in
                                if isError {
                                    self.showAlert(isHidden: self.showAlertInRequest, errorOBJ: errorOBJ) // error en resuesta
                                    return
                                }
                            })
                            break
                        }else {
                            /// error en la conexion de red.
                            let errorConexion       = WEBConexionError()//clase error
                            errorConexion.message   = (response.result.error?.localizedDescription)!//errror string
                            errorConexion.codeError = String(describing: response.response?.statusCode)
                            self.showAlert(isHidden: self.showAlertInRequest, errorOBJ: errorConexion)
                            // error en al coneexion.
                        }
                    }
                    
                }else{
                    
                    /// error server
                    WEBConexionError.init().validErrorStsatusCode(statusCodeError: (response.response!.statusCode), xMessage: self.XResponseMessage, handler: { (errorOBJ, isError) in
                        
                        if isError {
                            self.showAlert(isHidden: self.showAlertInRequest, errorOBJ: errorOBJ)
                            return
                        }
                        //#code.. success
                        self.parseResult(json: JSON(response.result.value!))///SUCESS PROCESS
                        self.indicatorAlamo?.stopAnimating()// detiene el indicator
                        // estatus code
                    })
                }
        }
    }
    
    // MARK: - OverrrideFunctios
    /// Respuesta de la peticion, esta repuesta es visialido en un override de la clanse donde se instancio la llamada De Alamorifre.
    ///
    /// - Parameter json: tipo JSON valos devuelto de la peticion.
    func parseResult(json:JSON) {
        assert(false, "este metodo es sobrescrito en la clase donde se le llama")
    }
    
    
    /// codigo de la peticion htttp:
    ///
    /// - Parameter status_code: codigo en INT en parseado en la clase WBerror
    func estatusCode(status_code:Int) {
        assert(false, "este metodo es sobrescrito en la clase donde se le llama")
    }
    
    
    /// Error en la conexion
    ///
    /// - Parameter error: Tipo Error
    func didErrorConexion(error:Error){
        assert(false, "este metodo es sobrescrito en la clase donde se le llama")
    }
    
    // MARK: - Alert Error
    /// Funcion para activar alarte de errores.
    ///
    /// - Parameters:
    ///   - isHidden: boleano para saber si mostrar la alerta
    ///   - errorOBJ: objeto que contiene el estatuscode y el mensage del error.
    private  func showAlert(isHidden:Bool,errorOBJ:WEBConexionError){
        print("error:\(errorOBJ.message) alertaVisible.\(isHidden)")
        self.indicatorAlamo?.stopAnimating()// detiene el indicator 
        guard isHidden else {
            return
        }
        alertError(title: nil, message: errorOBJ.message)
    }
    
    
    public func alertError(title:String?,message:String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let btnCancel = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alert.addAction(btnCancel)
        alert.show()
        
    }
    
}


// MARK: - Extension para una alerta Global

extension UIAlertController {
    
    func show() {
        present(true, completion: nil)
    }
    
    func present(_ animated: Bool, completion: (() -> Void)?) {
        for window in UIApplication.shared.windows {
            if window.isMember(of: UIWindow.classForCoder()) {
                if let rootVC = window.rootViewController {
                    presentFromController(rootVC, animated: animated, completion: completion)
                }
            }
        }
        /*
         if let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController {
         presentFromController(rootVC, animated: animated, completion: completion)
         }
         */
    }
    
    fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else {
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
            }
        }
    }
}



