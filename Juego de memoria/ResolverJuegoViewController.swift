import Foundation
import UIKit

class ResolverJuegoViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! imageCollectionViewCell
        let url:URL? = URL(string: images[indexPath.row])
        let data = try? Data(contentsOf: url!)
        
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
    
    var puntuacion = 0
    @IBOutlet weak var PuntuacionText: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PuntuacionText.text = "Puntuacion: " + String(puntuacion)
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        for image in imagesCorrectas{
            print(image)
        }
        
        
            
    }
    
}

