import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var JugarButton: UIButton!
    @IBOutlet weak var PuntuacionButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        Utils.cargarIds()
        Utils.VisualConf(JugarButton)
        Utils.VisualConf(PuntuacionButton)
    }
}
