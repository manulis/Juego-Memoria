//
//  ViewController.swift
//  Juego de memoria
//
//  Created by user198742 on 11/10/2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var JugarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
     
        VisualConf()
        
    }
    
    
   

    
    func VisualConf()  {
      
        JugarButton.layer.cornerRadius = 30.0
    }


}


