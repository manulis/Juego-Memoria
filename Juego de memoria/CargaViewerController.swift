//
//  CargaViewerController.swift
//  Juego de memoria
//
//  Created by user198742 on 20/10/2023.
//

import Foundation
import UIKit

public class CargaViewerController: UIViewController {
    
     
    
    let endpoint = URL(string: "https://dog.ceo/api/breeds/image/random")
    
    
    public func returnImages() -> [String]{
        
        var images:[String] = []
    
        return images
    }
    
    public struct  image:Codable {
        let message:String
    }
    
    public func CallApi(){
        
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
                        
                        self.images.append(tasks.message)
      
                      }catch{
                        print(error)
                      }
                  }
        
                

            }
            
       
        task.resume()
        
    }
    
    
}

