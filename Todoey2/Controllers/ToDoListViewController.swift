//
//  ViewController.swift
//  Todoey2
//
//  Created by Cyberdyne on 6/12/19.
//  Copyright © 2019 Jeff Ashburn. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    // turn array into an array of item objects
    
    var itemArray = [Item]()

    
//    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogrogrons", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", ",q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    // persistent data
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // load persistent data & update for condition if there's no array
        
       
        
       
        // creating new item objects
        let newItem = Item()
        newItem.title = "Find Mike"
        //newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        //itemArray = defaults.array(forKey: "ToDoListArray") as! [String] and get rid
        // of force down cast, make it optional
        
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
            
        }
        
        // let's test our solution for duplicate checkmark
        
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
        
//        }
        
    }
    
    
    //MARK - Create tableview data source Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    
    //function creating tableView - how they (cells) are displayed
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // print statement to check
        print("CellForRowAtIndexPath - Called")
        
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //cell.textLabel?.text = itemArray[indexPath.row]
        
        // refactoring with a constant variable for itemArray[indexPath.row]
        
        let item = itemArray[indexPath.row]
        
        //cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.textLabel?.text = item.title
        
        
        
        // Ternary operator - replacing 5 lines of code with the if statement
        // Ternary operator format: value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        
        
        
        // eliminate the line below** 
        
//        // update in refactoring - will eliminate or replace this with the ternary operator
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row) // print row
//        print(itemArray[indexPath.row])
        
        
        // grab a reference to the cell which is at a paticular index path
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        // now the code to remove the checkmark
        
       // **this is gone because of above.
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            // change it to none
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        //set the done property
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }
        else {
            itemArray[indexPath.row].done = false
        }
        
        // Add this magic function to retrigger the delegate method once we've changed the done property
        
        tableView.reloadData()
        
       
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
            
            // create a new item
            let newItem = Item()
            
            //now rework the add item
            newItem.title = textField.text!
            
            
            
            // this doesn't work after changing to array of objects
            //self.itemArray.append(textField.text!)
            // and here's what works for appending
            
            self.itemArray.append(newItem)
            
            // save our appended array to the user defaults
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            //defaults.set(self.itemArray, forKey: "")
            
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

