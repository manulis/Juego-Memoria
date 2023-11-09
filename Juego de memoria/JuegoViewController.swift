import Foundation
import UIKit

class JuegoViewController:  UIViewController {
    let endpoint = URL(string: "https://dog.ceo/api/breeds/image/random")
    struct image:Codable {
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
    
    //llama a una url que se encuntra en el array de imagenes para poder cargarla en la aplicación
    func cargarImagenDesdeURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error al cargar imagen: \(error)")
                return
            }
            if let data = data, let imagen = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.RandomImageShown.image = imagen
                }
            } else {
                print("No se pudo cargar la imagen desde los datos")
            }
        }.resume()
    }
    
    
    //muestra la secuencia de imagenes que el usuario tiene que memorizar
    func showImages(_ i: Int) {
        if i == 6 {
            ResolverButton.isHidden = false
            Utils.images.shuffle()
            return
        }
        Utils.imagesCorrectas.append(Utils.images[i])
        let urlString = Utils.imagesCorrectas[i]
        cargarImagenDesdeURL(urlString)
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.count += 1
            self.showImages(self.count)
        }
    }
    
    //Llamada a la API https://dog.ceo/api/breeds/image/random, hace 11 peticiones y en cada petición añade la url de la imagen al array images
    func CallApi(){
        for _ in 0...10{
            guard let UrlEndpoint = endpoint else {return}
           URLSession.shared.dataTask(with: UrlEndpoint){
                data, response, error in
                if let data = data, let string = String(data: data, encoding: .utf8){
                    print(string)
                }
                let decoder = JSONDecoder()
                      if let data = data{
                          do{
                            let tasks = try decoder.decode(image.self, from: data)
                            DispatchQueue.main.async {
                                Utils.images.append(tasks.message)
                            }
                          }catch{
                            print(error)
                            return
                          }
                      }
            
            }.resume()
        }
    }
}
