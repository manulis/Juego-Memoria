import Foundation
import UIKit

var puntuacion:Int = 0
var imgSelec:[String]=[]
class ResolverJuegoViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! imageCollectionViewCell
        let url:URL? = URL(string: images[indexPath.row])
        let data = try? Data(contentsOf: url!)
        if data == nil{
            print("Error")
            imageCollectionView.isHidden = true
            TextoFin.text = "Parece que hubo un error"
        }
        cell.imageView.image = UIImage(data: data!)
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
        
        if comprobarCorrecta(images[indexPath.row]) == true{
            puntuacion+=1
            print("correcta")
        }
        else{
            puntuacion-=1
            fallos+=1
            print("incorrecta")
        }
        
        if fallos == 3 {
            collectionView.isHidden=true
            TextoFin.text = "Tuviste tres fallos, fin del juego"
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
    
    var fallos:Int = 0
    @IBOutlet weak var PuntuacionText: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var TextoFin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PuntuacionText.text = "Puntuación: " + String(puntuacion)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
    }
}
