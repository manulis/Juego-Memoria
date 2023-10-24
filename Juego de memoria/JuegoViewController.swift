//
//  JuegoViewController.swift
//  Juego de memoria
//
//  Created by user198742 on 18/10/2023.
//

import Foundation
import UIKit

class JuegoViewController:  UIViewController {

    let endpoint = URL(string: "https://dog.ceo/api/breeds/image/random")
    
    var imagesCorrectas:[String] = []

    var images:[String] = []
    
    struct  image:Codable {
        let message:String
    }

    @IBOutlet weak var EmpezarButton: UIButton!
    @IBOutlet weak var RandomImageShown: UIImageView!
    @IBOutlet weak var Error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Error.isHidden=true
        CallApi()
        EmpezarButton.layer.cornerRadius = 30.0
        RandomImageShown.isHidden = true
    }
    
    @IBAction func EmpezarJuego(_ sender: Any) {
        EmpezarButton.isHidden = true
        RandomImageShown.isHidden = false
        for i in 0...5{
            showImages(i)
            print(i)
        }
    }
    
    func showImages(_ i:Int){
        imagesCorrectas.append(images[i])
        let url = URL(string: images[i])
        let data = try? Data(contentsOf: url!)
        RandomImageShown.image = UIImage(data: data!)
        
    }
    
    func CallApi(){
        for i in 0...10{
            guard let UrlEndpoint = endpoint else {
                return
            }
           URLSession.shared.dataTask(with: UrlEndpoint){
                data, response, error in
                if let data = data, let string = String(data: data, encoding: .utf8){
                    print(string)
                }
                let decoder = JSONDecoder()
                      if let data = data{
                          do{
                            let tasks = try decoder.decode(image.self, from: data)
                            print(tasks.message)
                            self.images.append(tasks.message)
                            print(i)
                          }catch{
                            print(error)
                            self.EmpezarButton.isEnabled = false
                            self.Error.isHidden = false
                            return
                          }
                      }
            
            }.resume()
        }
    }
        
}
