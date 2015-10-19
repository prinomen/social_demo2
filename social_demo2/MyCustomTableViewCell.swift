import UIKit

class MyCustomTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: NameTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
        nameField.addTarget(nil, action:"dummy:", forControlEvents:.EditingDidEndOnExit)
        
        loadName() // FIX: Find a way to call this method from the applicationDidBecomeActive method of AppDelegate.swift
        nameField.text = nameField.text!.cleanString // Remove any extra leading or trailing whitespace from nameField (its possible for app to terminate without performing this step before saving to userdefaults)
    }
    
    // Saves contents of the Name field to NSUserDefaults when user is finished editing the field
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        // If user only entered blank characters, delete field contents and save and empty string to NSUserDefaults
        nameField.text = nameField.text!.isBlankField ? "" : nameField.text!.cleanString // Remove any extra leading or trailing whitespace
        
        if nameField.text!.isBlankField {
            // If user only entered blank characters, delete field contents and save and empty string to NSUserDefaults
            nameField.text = ""
            let nameSave: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            nameSave.setObject(self.nameField.text, forKey: "name")
            nameSave.synchronize()
            return true
        } else {
            nameField.text = nameField.text!.cleanString // Remove any extra leading or trailing whitespace
            // If user entered some characters, save that to userdefaults
            let nameSave: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            nameSave.setObject(self.nameField.text, forKey: "name")
            nameSave.synchronize()
            return true
        }
    }
    
    // Prevent characters from being entered in the field if the length will exceed the limit. Save contents of the Name field to NSUserDefaults when any change is made.
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength : Int
        
        if string == "\n" {
            nameField.resignFirstResponder() // dismiss keyboard if Return is pressed
            return false // do not enter a Return character; end loop
        } else {
            newLength = nameField.text!.characters.count + string.characters.count - range.length // how long will the field become if the user is allowed to make this change?
        }
        
        // Don't allow user to make this change if it will cause the field to exceed the character limit
        return newLength <= 50 // Bool
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // Loads contents of the Name field from NSUserDefaults
    func loadName() {
        let nameLoad: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.nameField.text = nameLoad.objectForKey("name") as? String
    }
}