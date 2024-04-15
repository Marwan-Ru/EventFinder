//
//  ListViewController.swift
//  EventFinder
//
//  Created by Marwan Ait Addi on 08/04/2024.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var list: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readCSV() // Loads everything into the events array
        
        list.dataSource = self
        list.reloadData()
    }
    
    // MARK: -Tableview Implementation

    //Ici on retourne le nombre de cellules que l'on veut par section, pour le moment ce seras le nombre d'évenements dans la table events
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    //Ici on gère la construction d'une cellule a l'index IndexPath.row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = events[indexPath.row]
        
        cell.configure(withIcon: "EventFinder-icon", title: event.name, subtitle: event.desc)

        return cell
    }
    
    
    // MARK: -Private
    
    // Liste des évenements
    private var data = ""
    
    //Path to the csv
    let filepath = Bundle.main.path(forResource: "events", ofType: "csv")
    
    private func readCSV(){
        do {
            data = try String(contentsOfFile: filepath!)
        } catch {
            print(error)
            return
        }
        
        // On divise le string en array de lignes
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst() //La première ligne est inutile
        
        for row in rows{
            let columns = row.components(separatedBy: ",")
            if columns.count == 6{
                let name = columns[0]
                let desc = columns[1]
                let address = columns[2]
                let type = Int(columns[3]) ?? 0
                let latitude = Double(columns[4]) ?? 0
                let longitude = Double(columns[5]) ?? 0
                
                let event = Event(name: name, desc: desc, address: address, type: type, latitude: latitude, longitude: longitude)
                events.append(event)
            }
        }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
