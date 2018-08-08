//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Timothy Platt on 07/08/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet."
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(){

        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var addCategoryTextField = UITextField()
        
        let addCategoryAlert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let addCategoryAction = UIAlertAction(title: "Add Category", style: .default) { (addCategoryAction) in
            
            let newCategory = Category()
            
            newCategory.name = addCategoryTextField.text!
            
            self.save(category: newCategory)
        }
        
        addCategoryAlert.addTextField { (UITextField) in
            UITextField.placeholder = "Create new item"
            addCategoryTextField = UITextField
        }
        
        addCategoryAlert.addAction(addCategoryAction)
        
        present(addCategoryAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
}
