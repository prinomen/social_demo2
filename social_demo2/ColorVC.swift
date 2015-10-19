import UIKit

class ColorVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Color"
        self.view.backgroundColor = white
        
        let switchDemo=UISwitch(frame:CGRectMake(150, 300, 0, 0))
        if userColor == white {
            switchDemo.on = false
        } else {
            switchDemo.on = true
        }
        switchDemo.addTarget(self, action: "switchValueDidChange:", forControlEvents: .ValueChanged)
        self.view.addSubview(switchDemo)
    }
    
    func switchValueDidChange(sender:UISwitch!) {
        if (sender.on == true) {
            colorIndex = 1
            
            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            let colorToSetAsDefault = black // make a var to hold the selected color
            let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(colorToSetAsDefault) // encode the data
            defaults.setObject(data, forKey: "UserSelectedColor")  // save the data and key to userDefaults
            defaults.synchronize() // synchronize with userDefaults
            
            // Also set userdefaults for colorIndex
            defaults.setObject(colorIndex, forKey: "ColorIndex")
            defaults.synchronize()
            
            UINavigationBar.appearance().barTintColor = colorToSetAsDefault // set appearance proxy to the preferred color
            userColor = colorToSetAsDefault // save the preferred color to the userColor global variable in AppDelegate
            
            // Run this switch to set the textColor global var to match the preferred color scheme, based on the value of colorIndex.
            switch colorIndex {
            case 0: // white
                textColor = green
                statusBarTextIsBlack = true
            case 1: // black
                textColor = red
                statusBarTextIsBlack = false
            default:
                break;
            }
            
            // Now update these appearance proxy items (they need the window to reload before they will manifest their changes).
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 22)!, NSForegroundColorAttributeName: textColor]
            UINavigationBar.appearance().tintColor = textColor
                        
            // Remove all views from the window and then re-add them in order to force the current view to immediately apply changes to UIAppearance.
            let windows : NSArray = UIApplication.sharedApplication().windows
            for window in windows as! [UIWindow] {
                for view in window.subviews {
                    view.removeFromSuperview()
                    window.addSubview(view)
                }
            }
            
            // Set the new color of the status bar text
            if statusBarTextIsBlack == true {
                UIApplication.sharedApplication().statusBarStyle = .Default
            } else {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            }
        } else {
            colorIndex = 0
            
            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            let colorToSetAsDefault = white // make a var to hold the selected color
            let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(colorToSetAsDefault) // encode the data
            defaults.setObject(data, forKey: "UserSelectedColor")  // save the data and key to userDefaults
            defaults.synchronize() // synchronize with userDefaults
            
            // Also set userdefaults for colorIndex
            defaults.setObject(colorIndex, forKey: "ColorIndex")
            defaults.synchronize()
            
            UINavigationBar.appearance().barTintColor = colorToSetAsDefault // set appearance proxy to the preferred color
            userColor = colorToSetAsDefault // save the preferred color to the userColor global variable in AppDelegate
            
            // Run this switch to set the textColor global var to match the preferred color scheme, based on the value of colorIndex.
            switch colorIndex {
            case 0: // white
                textColor = green
                statusBarTextIsBlack = true
            case 1: // black
                textColor = red
                statusBarTextIsBlack = false
            default:
                break;
            }
            
            // Now update these appearance proxy items (they need the window to reload before they will manifest their changes).
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 22)!, NSForegroundColorAttributeName: textColor]
            UINavigationBar.appearance().tintColor = textColor
            
            // Remove all views from the window and then re-add them in order to force the current view to immediately apply changes to UIAppearance.
            let windows : NSArray = UIApplication.sharedApplication().windows
            for window in windows as! [UIWindow] {
                for view in window.subviews {
                    view.removeFromSuperview()
                    window.addSubview(view)
                }
            }
            
            // Set the new color of the status bar text
            if statusBarTextIsBlack == true {
                UIApplication.sharedApplication().statusBarStyle = .Default
            } else {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            }
            
        }
    }
}