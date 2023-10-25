//
//  JuegoViewController.swift
//  Juego de memoria
//
//  Created by user198742 on 18/10/2023.
//

import Foundation
import UIKit


class JuegoViewController:  UIViewController {
    var imagesCorrectas:[String] = []
    var images:[String] = []
    let endpoint = URL(string: "https://dog.ceo/api/breeds/image/random")
    
    struct  image:Codable {
        let message:String
    }

    @IBOutlet weak var EmpezarButton: UIButton!
    @IBOutlet weak var ResolverButton: UIButton!
    @IBOutlet weak var RandomImageShown: UIImageView!
    @IBOutlet weak var Error: UILabel!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Error.isHidden=true
        CallApi()
        Utils.VisualConf(EmpezarButton)
        Utils.VisualConf(ResolverButton)
        RandomImageShown.isHidden = true
        ResolverButton.isHidden = true
    }
    
    @IBAction func EmpezarJuego(_ sender: Any) {
        EmpezarButton.isHidden = true
        RandomImageShown.isHidden = false
        showImages(count)
    }
    
    func showImages(_ i: Int){
        if i == 6{
            ResolverButton.isHidden = false
            return
        }
        imagesCorrectas.append(images[i])
        let url = URL(string: images[i])
        let data = try? Data(contentsOf: url!)
        RandomImageShown.image = UIImage(data: data!)
        print(i)
        let deadlineTime = DispatchTime.now() + .seconds(1)
           DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.count+=1
            self.showImages(self.count)
           }
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
