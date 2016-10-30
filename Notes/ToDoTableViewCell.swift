
import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoTitleLabel: UILabel!
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var toDoDateLabel: UILabel!
    @IBOutlet weak var toDoImage: UIImageView!
    
    weak var todo: ToDo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ todo: ToDo) {
        self.todo = todo
        toDoTitleLabel.text = todo.title
        toDoDateLabel.text = todo.dateString
        if let image = todo.image {
            toDoImage.image = image
            
        } else {
            toDoImage.isHidden = false
        }

       
    }
  //  func setupCellFiltered(_ filteredArray: )
}







