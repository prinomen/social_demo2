import UIKit

class SettingsVC: UITableViewController, UITextFieldDelegate {
    
    let colorSection = ["My Color"]
    let miscSection = ["Help & Feedback"]
    
    // Gets the header view as a UITableViewHeaderFooterView and changes the section header text color, font, etc.
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = black
        headerView.textLabel!.font = UIFont(name: "Avenir Next", size: 17)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData() // reload the entire table (this will update the section header text so that it sets it to the current userColor)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCustomTableViewCell", forIndexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
            let title = colorSection[indexPath.row] as String
            cell.textLabel?.text = title
            cell.textLabel!.font = UIFont(name:"Avenir Next", size:18)
            cell.textLabel!.textColor = UIColor(rgb: 0x474747)
            if cell.textLabel?.text == "My Color" {
                cell.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
            let title = miscSection[indexPath.row] as String
            cell.textLabel?.text = title
            cell.textLabel!.font = UIFont(name:"Avenir Next", size:18)
            cell.textLabel!.textColor = UIColor(rgb: 0x474747)
            if cell.textLabel?.text == "Help & Feedback" {
                cell.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name"
        case 1:
            return "Color"
        default:
            return nil
        }
    }
    
    // This method fires when any of the cells are touched
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Setting up variables & constants
        let selectedSection = indexPath.section
        let selectedRow = indexPath.row
        var selectedItem : String?
        
        // Set the "selectedSection" variable to the selected cell
        if selectedSection == 0 {
            selectedItem = "Enter your name"
        } else if selectedSection == 1 && selectedRow == 0 {
            selectedItem = "My Color"
        } else if selectedSection == 2 {
            selectedItem = "Help & Feedback"
        }
        
        // Look at the selectedItem variable. If it's the "My color" or "Help & feedback", trigger the segue to the respective scene.
        switch selectedItem! {
        case "My Color":
            self.performSegueWithIdentifier("showMyColor", sender: self)
        case "Help & Feedback":
            self.performSegueWithIdentifier("showHelp", sender: self)
        default:
            break
        }
    }
    
    // Resign first responder when return key is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:")) // add a gesture recognizer to dismiss keyboard when tapping anywhere outside the text field
        
        // Prevents the default behavior of the nav bar "Back" button (which is a title from the previous screen) and instead uses an empty string, resulting in just a < chevron
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }
    
    // Dismisses keyboard when tapping anywhere outside the text field
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
}