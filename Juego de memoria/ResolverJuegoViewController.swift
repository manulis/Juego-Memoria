import Foundation
import UIKit

class ResolverJuegoViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! imageCollectionViewCell
        if pulsado {
            images[ocult] = ""
            pulsado = false
        }
        if let url = URL(string: images[indexPath.row]), let data = try? Data(contentsOf: url) {
            cell.imageView.image = UIImage(data: data)
        } else{
            cell.imageView.image = UIImage(named: "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imgWidth = view.bounds.width
        let imgHeight = imgWidth
        return CGSize(width: imgWidth, height: imgHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ocult = indexPath.row
        puntuacion += comprobarCorrecta(images[indexPath.row]) ? 5 : -3
        aciertos += comprobarCorrecta(images[indexPath.row]) ? 1 : 0
        fallos += comprobarCorrecta(images[indexPath.row]) ? 0 : 1
        print(comprobarCorrecta(images[indexPath.row]) ? "correcta" : "incorrecta")
        pulsado = true
        imageCollectionView.reloadData()
        
        if fallos == 3 || aciertos == 5 {
            collectionView.isHidden = true
            AceptarButton.isHidden = false
            TextoFin.text = fallos == 3 ? "Tuviste tres fallos, perdiste" : "¡Ganaste!"
            TextoFin.textColor = fallos == 3 ? UIColor.red : UIColor.blue
            guardarPuntu(puntuacion)
        }
           
        PuntuacionText.text = "Puntuación: " + String(puntuacion)
    }

    func comprobarCorrecta(_ image:String) -> Bool{
        for imageCorrecta in imagesCorrectas{
            if imageCorrecta == image{
                return true
            }
        }
        return false
    }
    
    func guardarPuntu(_ puntuacion: Int){
        let newPuntu = Utils.Puntuacion ("", Utils.PuntuacionData(puntuacion))
        let data = try! JSONEncoder().encode(newPuntu)
        var request = URLRequest(url: Utils.restfulApiEndPoint!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let json = String(data: data!, encoding: .utf8)
            print(json ?? "Error")
            do {
                let puntuJson = try JSONDecoder().decode(Utils.Puntuacion.self, from: data!)
                DispatchQueue.main.async {
                    print(puntuJson)
                    let id = puntuJson.id
                    Utils.ids.append(id)
                    UserDefaults.standard.set(Utils.ids, forKey: "ids")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
        
    var puntuacion = 0
    var pulsado:Bool = false
    var ocult = 1
    var aciertos:Int = 0
    var fallos:Int = 0
    @IBOutlet weak var PuntuacionText: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var TextoFin: UILabel!
    @IBOutlet weak var AceptarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AceptarButton.isHidden=true
        Utils.VisualConf(AceptarButton)
        PuntuacionText.text = "Puntuación: " + String(puntuacion)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
    }
}
