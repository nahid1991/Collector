//
//  ItemTableViewController.swift
//  The Collector
//
//  Created by Nahid on 22/6/19.
//  Copyright © 2019 Nahid. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }
    
    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataItems = try? context.fetch(Item.fetchRequest()) as? [Item] {
                items = coreDataItems
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: items[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            if let detailVC = segue.destination as? DetailViewController {
                if let itemToSend = sender as? Item {
                    detailVC.item = itemToSend
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let cellItem = items[indexPath.row]
        
        cell.textLabel?.text = cellItem.title
        
        if let cellItemImageData = cellItem.imageData {
            if let cellItemImage = UIImage(data: cellItemImageData) {
                cell.imageView?.image = cellItemImage
            }
        }

        // Configure the cell...

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let itemToBeDeleted = items[indexPath.row]
                
                context.delete(itemToBeDeleted)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                
                getItems()
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
