//
//  QuickTranslateTableViewController.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 03/04/24.
//

import UIKit

class QuickTranslateTableViewController: UITableViewController {
    
    // reload the data when the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
       
    }
    
    // display an edit button when the view is created
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }
    
    // Tell the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Tell the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sampleData.count
        } else {
            return 0
        }
    }
    
    // Tell the data source to return the height of the rows in the table view.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    // Ask the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceCell", for: indexPath) as! QuickTranslateViewCell
        
        // Fetch model object to display
        let sentence = sampleData[indexPath.row]
        
        // Configure cell
        cell.update(with: sentence)
        cell.showsReorderControl = true
        
        // Return cell
        return cell
    }
    
    // Ask the data source to commit the insertion or deletion of a specified row in the receiver.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sampleData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Tell the data source to move a row at a specific location in the table view to another location.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedSentence = sampleData.remove(at: fromIndexPath.row)
        sampleData.insert(movedSentence, at: to.row)
    }
    
    // Ask the delegate for the editing style of a row at a particular location in a table view.
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ho selezionato \(sampleData[indexPath.row])")
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("Ho selezionato \(sampleData[indexPath.row])")
    }
    
}
