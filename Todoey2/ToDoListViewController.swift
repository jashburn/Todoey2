//
//  ViewController.swift
//  Todoey2
//
//  Created by Cyberdyne on 6/12/19.
//  Copyright © 2019 Jeff Ashburn. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogrogron"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK - Create tableview data source Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //cell.textLabel?.text = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row) // print row
//        print(itemArray[indexPath.row])
        
        
        // grab a reference to the cell which is at a paticular index path
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        // now the code to remove the checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // change it to none
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        // the seleection will unhighlight itself when chosen
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    


}

