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
    let endpoint = URL(string: "https://dog.ceo/api/breeds/image/random")
    
    
    struct  image:Codable {
        let message:String
    }

    
    @IBOutlet weak var RandomImageShown: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
       showImages()
        
        
    }
    
    
    func showImages(){
        
        
        
        
        for i in 0...5{
            
            imagesCorrectas.insert("https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*", at:i )
            
            images.append(imagesCorrectas[i])
        
            let url = URL(string: imagesCorrectas[i] )
            
            let data = try? Data(contentsOf: url!)
            
            RandomImageShown.image = UIImage(data: data!)
        }
            
        
        callApi()
        
        
    }
    
    
    
    func callApi() {
        
        guard let UrlEndpoint = endpoint else {
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: UrlEndpoint){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
            
            let decoder = JSONDecoder()

                  if let data = data{
                      do{
                        
                        let tasks = try decoder.decode(image.self, from: data)
                          
                        print(type(of:tasks.message))
                        
                        self.images.insert(tasks.message, at:1)
                        
                      }catch{
                          print(error)
                      }
                  }
            
            print(self.images[1])
            
        }

        task.resume()
        
    }
  
}


