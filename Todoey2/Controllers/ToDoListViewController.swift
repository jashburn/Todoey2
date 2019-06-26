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
  
    // persistent data
    //let defaults = UserDefaults.standard
       let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // load persistent data & update for condition if there's no array
    
        //print(dataFilePath) - path set for plist with NSCoder
        
    
        //loading saved items
        
       loadItems()
        
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
        

        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
     
        //set the done property/ toggle the item
        
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }
//        else {
//            itemArray[indexPath.row].done = false
//        }
        
        // I was missing this line for toggling the checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        // Add this magic function to retrigger the delegate method once we've changed the done property
        
        tableView.reloadData()
        
       
        // the seleection will unhighlight itself when chosen
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
        
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
            
            // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            // from the above using User defaults to changing to use NS Coder
            
            self.saveItems()
            
     
            
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
    
    
    
    
    
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
      
        
        do {
            // this encodes the data
            let data = try encoder.encode(self.itemArray)
            // this writes the data to our data file path
            try data.write(to: self.dataFilePath!)
        }
            
        catch {
            // print out the encoding error
            print("Error encoding item array, \(error)")
            
        }
         self.tableView.reloadData()
        
    }
    
    func loadItems() {
        let data = try? Data(contentsOf: dataFilePath!)
        let decoder = PropertyListDecoder()
        
        do {
        itemArray = try decoder.decode([Item].self, from: data!)
        }
        catch {
            print("Error decoding item array, \(error)")
        }
    }
    
}

