import UIKit


func presentError(error: NSError?) {
    let alertView = UIAlertView(title: "Error", message: error?.description, delegate: nil, cancelButtonTitle: "Ok")
    alertView.show()
}