//
//  WCPerfil.swift
//  WebconexionNET
//
//  Created by Carlos Azueta on 08/02/18.
//  Copyright © 2018 Carlos Azueta. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class WCPerfil: WEBConexion {
    
    let header:HTTPHeaders = ["":""]
    let para:Parameters    = ["":""]
    
    func getPerfil(){
        callAlamo(URLString: BaseURL.gerentes, methodHttp: .get, parameters: para, headers: header)
    }
    
    func getPerfilUnsupport(){
        callAlamo(URLString: BaseURL.baseUnsupportURL, methodHttp: .get, parameters: para, headers: header)
    }
    
    override func parseResult(json: JSON) {
        self.delegate?.didSuccess(data: json, sender: "siguienteURL")
        
    }
    
    
    override func didErrorConexion(error: Error) {
        
    }

    
    override func estatusCode(status_code: Int) {
        
    }
}
