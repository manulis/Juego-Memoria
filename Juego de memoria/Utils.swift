import Foundation
import UIKit

class Utils {
    
    static let restfulApiEndPoint = URL(string: "https://api.restful-api.dev/objects")
    static var imagesCorrectas:[String] = []
    static var images:[String] = []
    static var ids:[String] = []

    static func VisualConf(_ Button: UIButton)  {
        Button.layer.cornerRadius = 30.0
    }
    
    static func cargarIds(){
        let array = UserDefaults.standard.object(forKey: "ids") as? [String] ?? [String]()
        print(array)
        for i in array{
            ids.append(i)
        }
    }
    
     struct Puntuacion: Codable{
        var id:String = ""
        var name:String
        var data:PuntuacionData
        init(_ name:String, _ data:PuntuacionData) {
            self.name = name
            self.data = data
        }
    }
    
  struct PuntuacionData:Codable {
        var puntuacion:Int
        init(_ puntuacion:Int){
            self.puntuacion = puntuacion
        }
    }
    
}
