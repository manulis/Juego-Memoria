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

