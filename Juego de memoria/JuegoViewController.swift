//
//  JuegoViewController.swift
//  Juego de memoria
//
//  Created by user198742 on 18/10/2023.
//

import Foundation
import UIKit

class JuegoViewController:  UIViewController {
    
    
    var images = [""]
    var imagesCorrectas = [""]
    
    
    @IBOutlet weak var RandomImageShown: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       showImages()
        
        
        
        
       
        
    }
    
    
    func showImages(){
        
        let count = 5
        
        for i in 0 ... count {
            
            imagesCorrectas.insert("", at: i)
            
            
        }
        
        
        let url = URL(string: "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*" )
        let data = try? Data(contentsOf: url!)
        RandomImageShown.image = UIImage(data: data!)
        
        
    }
    
    
    
}
