//
//  ViewController.swift
//  Juego de memoria
//
//  Created by user198742 on 11/10/2023.
//

import UIKit

public class ViewController: UIViewController {

    
    @IBOutlet weak var JugarButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        VisualConf(Button: JugarButton)
    }
    
    public func VisualConf(Button: UIButton)  {
        Button.layer.cornerRadius = 30.0
    }

}
