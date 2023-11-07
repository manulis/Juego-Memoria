import Foundation
import UIKit

var puntuacion:Int = 0

class ResolverJuegoViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! imageCollectionViewCell
        if pulsado == true{
            images[ocult] = ""
            pulsado = false
        }
        if images[indexPath.row] == ""{
            cell.imageView.image = UIImage(named: "")
            return cell
        }
        let url:URL? = URL(string: images[indexPath.row])
        let data = try? Data(contentsOf: url!)
        if data == nil{
            print("Error")
            cell.imageView.image = UIImage(named: "error.png")
        }else{
            cell.imageView.image = UIImage(data: data!)
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
        print(images[indexPath.row])
        print(indexPath.row)
        
        ocult = indexPath.row
        
        if comprobarCorrecta(images[indexPath.row]) == true{
            puntuacion+=5
            aciertos+=1
            print("correcta")
            pulsado = true
            imageCollectionView.reloadData()
        }
        else{
            puntuacion-=3
            fallos+=1
            print("incorrecta")
            pulsado = true
            imageCollectionView.reloadData()
        }
        if fallos == 3 {
            collectionView.isHidden=true
            AceptarButton.isHidden=false
            TextoFin.text = "Tuviste tres fallos, perdiste"
        }
        if aciertos == 5{
            collectionView.isHidden=true
            AceptarButton.isHidden=false
            TextoFin.text = "Ganaste!!!!"
            TextoFin.textColor = UIColor.blue
        }
        PuntuacionText.text = "Puntuación: " + String(puntuacion)
    }
    
    func addPuntu(_ puntuacion: Int){
        let endpointRestApiPuntu = "https://api.restful-api.dev/objects"
        
        
    }
    
    func comprobarCorrecta(_ image:String) -> Bool{
        for imageCorrecta in imagesCorrectas{
            if imageCorrecta == image{
                return true
            }
        }
        return false
    }
    
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
