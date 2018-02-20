//
//  ViewController.swift
//  WebconexionNET
//
//  Created by Carlos Azueta on 08/02/18.
//  Copyright © 2018 Carlos Azueta. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController,WEBConexionDelegate {

    ///conexion alamorfire
    var conexionAlamorfire = WCPerfil()
    
    @IBOutlet var indicatorView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // delegate para la conexion de alamorfire
        self.conexionAlamorfire.delegate = self
        self.conexionAlamorfire.indicatorAlamo = indicatorView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
     // MARK: - IBActions
    ///con soporte
    @IBAction func senderBaseUnsuport(){
     
        getGerentesUnsupport()
    }
    
    
    ///sin soporte
    @IBAction func senderBase(){
        getGerentes()
    }
    
    
    func didSuccess(data: Any?, sender: Any?) {
        let json = data as? JSON
        print(json)
    }
    
    
    ///funcion para get de los gerentes
    func getGerentes(){
        
        self.conexionAlamorfire.getPerfil()
    }
    
    ///funcion no soportada para get de los gerentes
    func getGerentesUnsupport(){
        //self.conexionAlamorfire.showAlertInRequest = false
        self.conexionAlamorfire.getPerfilUnsupport()
    }
}

