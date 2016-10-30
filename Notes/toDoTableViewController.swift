

import UIKit

class ToDosTableViewController: UITableViewController, UISearchBarDelegate {
    var isComplete = false
    let todo = ToDoStore()
    public var numberOfSections = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.leftBarButtonItem = self.editButtonItem
                }
    
    //IBActions
    
    
    @IBAction func showComplete(_ sender: AnyObject) {
        isComplete = !isComplete
        tableView.reloadData()
    }
    
    
        //Funcs for adding search
        func updateSearchResults(for searchController: UISearchController) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoStore.shared.getCount(category: section)
            
        }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoTableViewCell.self)) as! ToDoTableViewCell
            cell.setupCell(ToDoStore.shared.getItem(indexPath.row, category: indexPath.section))
            if isComplete == false {
                if cell.todo.complete == true {
                    cell.isHidden = true
                }
            }
            return cell
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ToDoStore.shared.getItem(indexPath.row, category: indexPath.section).complete == true && isComplete == false {
            return 0
        } else {
            return 123
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard AddACategory.SectionTitles.indices ~= section else {
            print("No section title for this section")
            return nil
        }
        
        return AddACategory.SectionTitles[section]
    }


    //Functions for adding search
    
    //Functions for adding search
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ToDoStore.shared.deleteItem(indexPath.row, category: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section{
            return proposedDestinationIndexPath
        } else {
            return sourceIndexPath
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToDoSegue" {
            let toDoDetailVC = segue.destination as! ToDoDetailViewController
            let tableCell = sender as! ToDoTableViewCell
            toDoDetailVC.todo = tableCell.todo
        } else if segue.identifier == "editNoteSegue" {
            let toDoDetailVS = segue.destination as! ToDoDetailViewController
            let tableCell = sender as! ToDoTableViewCell
            toDoDetailVS.todo = tableCell.todo
            
        }
        
    }
    
    // MARK: - Unwind Segue
    @IBAction func saveToDoDetail(_ segue: UIStoryboardSegue) {
        let toDoDetailVC = segue.source as! ToDoDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            ToDoStore.shared.deleteItem(indexPath.row, category: indexPath.section)
            ToDoStore.shared.addItem(toDoDetailVC.todo, category: toDoDetailVC.todo.category)
            tableView.reloadData()
            
        } else {
            let indexPath = IndexPath(row: 0, section: toDoDetailVC.todo.category )
            ToDoStore.shared.addItem(toDoDetailVC.todo, category: indexPath.section)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        
        
        
        // tableView.reloadRows(at:IndexPath.row, with: .automatic)
        
    }
    
    
}











