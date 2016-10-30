

import UIKit

class ToDo: NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date()
    var image: UIImage?
    var category = 0
    var priority: Double = 0.0
    var complete = false
    var dueDate = Date()
    var priorityDisplayText = ""
    var addACategory = [""]
    
    let titleKey = "title"
    let textKey = "text"
    let dateKey = "date"
    let imageKey = "image"
    let categoryKey = "category"
    let priorityKey = "priority"
    let dueDateKey = "dueDate"
    let priorityDisplayTextKey = "displayText"
    let completeKey = "complete"
    var dateString: String {
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        return dateFormatter.string(from: dueDate)
    }
    
    override init() {
        super.init()
    }
    
    init(title: String, text: String, complete: Bool) {
        self.title = title
        self.text = text
        self.complete = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        self.category = aDecoder.decodeInteger(forKey: categoryKey)
        self.priority = aDecoder.decodeDouble(forKey: priorityKey)
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey) as! Date
        self.priorityDisplayText = aDecoder.decodeObject(forKey: priorityDisplayTextKey) as! String
        self.complete = aDecoder.decodeBool(forKey: completeKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(category, forKey: categoryKey)
        aCoder.encode(priority, forKey: priorityKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
        aCoder.encode(priorityDisplayText, forKey: priorityDisplayTextKey)
        aCoder.encode(complete, forKey: completeKey)
    }
}










