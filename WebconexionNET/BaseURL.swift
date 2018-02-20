//
//  BaseURL.swift
//  WebconexionNET
//
//  Created by Carlos Azueta on 08/02/18.
//  Copyright © 2018 Carlos Azueta. All rights reserved.
// http://calin.hol.es/JsonEstaciones.php

import UIKit

class BaseURL: WEBConexion {
    
    // baseUnsupportURL
    static let baseUnsupportURL = "www.calin.hol.es/"
    
    // baseURL
    static let baseURL = "http://calin.hol.es/"
    
    //apis URL
    ///lista de gerentes URL
    static let gerentes = baseURL + "JsonEstaciones.php"
    static let gerentesUnsupport  = baseUnsupportURL + "JsonEstaciones.php"
    

}
