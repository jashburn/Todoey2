//
//  ViewController.swift
//  Todoey2
//
//  Created by Cyberdyne on 6/12/19.
//  Copyright © 2019 Jeff Ashburn. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogrogron"]
    
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
    
    
    //MARK - Add New Items

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController (title: "Add New Todey Item", message: "", preferredStyle: .alert)
       // var newItem = alertTextField
        
        let action = UIAlertAction (title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on out UIAlert
            
            self.itemArray.append(textField.text!)
            
            // refreshes table view to load new item
            self.tableView.reloadData()
            
        }
        
        // last, add the textfield in the alert
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Item here!"
            textField = alertTextField
            
        }
        
        // now we add the action to our alert
        
        alert.addAction(action)
        
        // now we present our alert
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    


}

