//
//  ListViewController.swift
//  EventFinder
//
//  Created by Marwan Ait Addi on 08/04/2024.
//

import UIKit

struct Event{
    var name: String
    var desc: String
    var address: String
    var type: Int
    var latitude: Int
    var longitude: Int
}

class ListViewController: UIViewController {

    @IBOutlet weak var List: UILabel!
    
    // Liste des évenements
    var events = [Event]()
    var data = ""
    
    //Path to the csv
    let filepath = Bundle.main.path(forResource: "events", ofType: "csv")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        readCSV()
    }
    
    func readCSV(){
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
                let latitude = Int(columns[4]) ?? 0
                let longitude = Int(columns[5]) ?? 0
                
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
