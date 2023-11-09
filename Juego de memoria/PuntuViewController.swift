import Foundation
import UIKit


class PuntuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return puntuaciones.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! puntuTableViewCell
        cell.puntuText.text = String(puntuaciones[indexPath.row])
        return cell
    }
    
    func getPuntu(){
        for i in 0...Utils.ids.count - 1 {
            let url = "https://api.restful-api.dev/objects?id=" + Utils.ids[i]
                guard let enpoint = URL(string: url) else{
                    print("URL Invalida")
                    return
                }
                URLSession.shared.dataTask(with: enpoint){
                     data, response, error in
                    if let data = data, let string = String(data: data, encoding: .utf8){
                        print(string)
                    }
                    let decoder = JSONDecoder()
                          if let data = data{
                              do{
                                let tasks = try decoder.decode([Utils.Puntuacion].self, from: data)
                                DispatchQueue.main.async {
                                    for task in tasks{
                                        print(task.data.puntuacion)
                                        self.puntuaciones.append(task.data.puntuacion)
                                        self.puntuTable.reloadData()
                                    }
                                }
                              }catch{
                                print(error)
                                return
                              }
                          }
                 
                 }.resume()
        }
    }
    
    @IBOutlet weak var puntuTable: UITableView!
    var puntuaciones:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        puntuTable.dataSource = self
        puntuTable.delegate = self
        getPuntu()
    }
}
