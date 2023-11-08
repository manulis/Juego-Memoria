import Foundation
import UIKit

class Utils {
    
    static let restfulApiEndPoint = URL(string: "https://api.restful-api.dev/objects")
    static var ids:[String] = []

    static func VisualConf(_ Button: UIButton)  {
        Button.layer.cornerRadius = 30.0
    }
    
    static func cargarIds(){
        let array = UserDefaults.standard.object(forKey: "ids") as? [String] ?? [String]()
        print(array)
        for i in 0...array.count - 1{
            ids.append(array[i])
        }
    }
    
}
