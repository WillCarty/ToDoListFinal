
import UIKit

class ToDoStore {
    static let shared = ToDoStore()
        
    
    public var toDoItem: [[ToDo]]!
    fileprivate var toDoItemComplete: [[ToDo]]!
    
    var selectedImage: UIImage?
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            toDoItem = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [[ToDo]]
        } else {
            toDoItem = [[],[],[],[],[]]
            toDoItem[0].append(ToDo(title: "Item 1", text: "Do this on this date", complete: false))
            toDoItem[1].append(ToDo(title: "Item 2", text: "Do that on this date", complete: false))
            toDoItem[2].append(ToDo(title: "Item 3", text: "This is due on this date", complete: false))
            toDoItem[3].append(ToDo(title: "Item 4", text: "This is due on this date", complete: false))
            toDoItem[4].append(ToDo(title: "Item 5", text: "Uncatagorized", complete: false))
           
            save()
        }
            sort()
        
        }
    // MARK: - Public functions
    //List editing functions
    func getItem(_ index: Int, category: Int) -> ToDo {
        return toDoItem[category][index]
    }
        
    func addItem(_ todo: ToDo, category: Int) {
        toDoItem[category].insert(todo, at: 0)
    }
    
    func updateItem(_ todo: ToDo, index: Int, category: Int) {
        toDoItem[category][index] = todo
    }
    
    func deleteItem(_ index: Int, category: Int) {
        toDoItem[category].remove(at: index)
    }
    
    func getCount(category: Int) -> Int {
        return toDoItem[category].count
    }
    func completedToDo(_ todo: ToDo, category: Int) {
        if todo.complete == true{
            
        }
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(toDoItem, toFile: archiveFilePath())
    }
    //Sorting list via Priority
    func sort() {
        for i in 0..<toDoItem.count {
            toDoItem[i].sort(by: { (toDo1, toDo2) -> Bool in
                return toDo1.priority < toDo2.priority
            })
        }
    }
    
    // MARK: - Private Functions
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("ToDoStore.plist")
        return path
    }
}











