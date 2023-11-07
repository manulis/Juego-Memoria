import Foundation
import UIKit



class PuntuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! puntuTableViewCell
        cell.puntuText.text = "Prueba"
        return cell
    }
    
    @IBOutlet weak var puntuTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puntuTable.dataSource = self
        puntuTable.delegate = self
    }
}
