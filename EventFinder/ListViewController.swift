//
//  ListViewController.swift
//  EventFinder
//
//  Created by Marwan Ait Addi on 08/04/2024.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var list: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredEvents: [Event]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readCSV() // Loads everything into the events array
        
        list.dataSource = self
        searchBar.delegate = self
        
        filteredEvents = events
        sortByDate(ascending: true) // Sorts filteredEvents by dates
        
        list.reloadData()
    }
    
    // MARK: -Tableview Implementation

    //Ici on retourne le nombre de cellules que l'on veut par section, pour le moment ce seras le nombre d'évenements dans la table events
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }

    //Ici on gère la construction d'une cellule a l'index IndexPath.row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = filteredEvents[indexPath.row]
        var icon : String
        
        // Ici on défini l'icone à utiliser pour afficher l'évenement
        switch event.type {
            case 1 :
                icon = "cle-de-sol"
                break
            case 2 :
                icon = "bouteille-de-biere"
                break
            case 3 :
                icon = "musee"
                break
            case 4 :
                icon = "sports"
                break
            default:
                icon = "boite-ouverte"
        }
        
        // On formatte la date pour l'afficher
        let date = Calendar.current.date(from: event.date)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "fr_FR")
        let dateStr = formatter.string(from: date!)
        
        cell.configure(withIcon: icon, title: event.name, date: dateStr)

        return cell
    }
    
    // MARK: -SearchBar implementation
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEvents = searchText.isEmpty ? events : events.filter { (item : Event) -> Bool in
            // Checks if whatever is in the searchtext is a substring of the name of an event
            // The list is therefore filtered depending on whatever is in the searchbar
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        sortByDate(ascending: true)
        list.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        // Reseting the list
        filteredEvents = events
        sortByDate(ascending: true)
        list.reloadData()
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
        
        // Ici on peuple la liste des events
        for row in rows{
            let columns = row.components(separatedBy: ",")
            if columns.count == 7{
                let name = columns[0]
                let desc = columns[1]
                let address = columns[2]
                let type = Int(columns[3]) ?? 0
                let latitude = Double(columns[4]) ?? 0
                let longitude = Double(columns[5]) ?? 0
                
                // Gestion de la date yyyy-mm-dd 20:00:00
                var date = DateComponents()
                date.calendar = Calendar.current
                let datentime = columns[6].components(separatedBy: " ") // On sépare la date et l'heure
                let d = datentime[0].components(separatedBy: "-") // On sépare les éléments de la date
                let t = datentime[1].components(separatedBy: ":") // On sépare les éléments de l'heure
                date.year = Int(d[0])
                date.month = Int(d[1])
                date.day = Int(d[2])
                date.hour = Int(t[0])
                date.minute = Int(t[1])
                date.second = Int(t[2])
                // Fin de la gestion de la date
                
                let event = Event(name: name, desc: desc, address: address, type: type, latitude: latitude, longitude: longitude, date: date)
                events.append(event)
            }
        }
        }
        
        
        // Removes past elements
        private func sortByDate(ascending: Bool){
            if ascending {
                filteredEvents.sort(by: {$0.date < $1.date})
            } else {
                filteredEvents.sort(by: {$0.date > $1.date})
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

// Permet de trier les évenements par date.
extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        return calendar.date(byAdding: lhs, to: now)! < calendar.date(byAdding: rhs, to: now)!
    }
}
