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
            
            callApi()
        
            

    }
    
    
    func showImages(){
        imagesCorrectas.insert(images[0], at: 0)
        let url = URL(string: imagesCorrectas[0])
        let data = try? Data(contentsOf: url!)
        RandomImageShown.image = UIImage(data: data!)
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
                        
                        self.images.insert(tasks.message, at:0)
                        
                        self.showImages()
      
                      }catch{
                        
                        
                        print(error)
                      }
                  }

            }
            
       
        task.resume()
        
    }
}
