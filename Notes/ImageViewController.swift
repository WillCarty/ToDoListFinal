

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = ToDoStore.shared.selectedImage {
            imageView.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: AnyObject) {
        ToDoStore.shared.selectedImage = nil
        dismiss(animated: true, completion: nil)
    }
}






