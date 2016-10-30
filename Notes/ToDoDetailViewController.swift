

import UIKit

class ToDoDetailViewController: UIViewController, UITextFieldDelegate {
    //IBOutlets
    @IBOutlet weak var toDoTitleField: UITextField!
    @IBOutlet weak var toDoTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var selectDate: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var completionSwitch: UISwitch!
    var gestureRecognizer: UITapGestureRecognizer!
    var todo = ToDo()
    var mainView = ToDosTableViewController()
    public static var categoryPickerArray = ["Home ToDo's","Work Todo's","Weekend ToDo's","Misc ToDo's"]
    
    //Plug in text field and button
    var addACategory = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTitleField.text = todo.title
        toDoTextView.text = todo.text
        
        if let image = todo.image {
            imageView.image = image
            addGestureRecognizer()
        } else {
            imageView.isHidden = false
        }
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = imageView.image {
            ToDoStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
        completionSwitch.isOn = todo.complete
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        todo.title = toDoTitleField.text!
        todo.text = toDoTextView.text
        todo.date = Date()
        todo.category = categoryPicker.selectedRow(inComponent: 0)
        todo.image = imageView.image
        todo.dueDate = selectDate.date
        todo.complete = completionSwitch.isOn
    }
    // MARK: - IBActions
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.showPicker(.photoLibrary)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveToDoItem(_ sender: AnyObject) {
        if sender.tag == 0 {
            todo.category = 0
            
        } else if sender.tag == 1 {
            todo.category = 1
            
        } else if sender.tag == 2 {
            todo.category = 2
        } else if sender.tag == 3 {
            todo.category = 3
        }
    }
    @IBAction func datePickerAction(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        let strDate = dateFormatter.string(from: selectDate.date)
        self.dueDate.text = strDate
        
    }
    @IBAction func completeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            todo.complete = true
        } else {
            todo.complete = false
        }
    }
}

extension ToDoDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            imageView.image = resizedImage
        }
    }
}

extension ToDoDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if todo.category == 0 || todo.category == 1 || todo.category == 2 || todo.category == 3{
            return ToDoDetailViewController.categoryPickerArray[row]
        } else if todo.category > 4 {
            todo.category += 1
            return addACategory[row]
        }
        return ToDoDetailViewController.categoryPickerArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ToDoDetailViewController.categoryPickerArray.count
    }
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
}
