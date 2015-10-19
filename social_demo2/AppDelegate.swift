import UIKit

// Create some global variables here for easy access throughout the project
let white = UIColor.whiteColor() // 0
let black = UIColor.blackColor() // 1
let red = UIColor.redColor()
let green = UIColor.greenColor()
var userColor = white
var colorIndex = 0
var statusBarTextIsBlack = true // represents the color of the status bar text (true for black status bar text, false for white status bar text)
var textColor = black

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Load UI color from user defaults and assign it to the userColor variable
        if let userSelectedColorData  =  NSUserDefaults.standardUserDefaults().objectForKey("UserSelectedColor") as? NSData {
            if let userSelectedColor = NSKeyedUnarchiver.unarchiveObjectWithData(userSelectedColorData) as? UIColor {
                userColor = userSelectedColor
            }
        }
        
        // Load colorIndex from user defaults
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let loadColorIndex = defaults.valueForKey("ColorIndex") as? Int {
            colorIndex = loadColorIndex
        }
        
        // Based on the value of colorIndex, set the the following global vars to match the preferred color scheme.
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
        
        // Configure the appearance proxy (use the userColor var to set the color)
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barTintColor = userColor
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 22)!, NSForegroundColorAttributeName: textColor]
        UINavigationBar.appearance().tintColor = textColor
        UITabBar.appearance().tintColor = black
        UITextField.appearance().tintColor = black
        UITextField.appearance().font = UIFont(name:"Avenir Next", size:18)
        UITextField.appearance().textColor = UIColor(rgb: 0x474747)
        UITextField.appearance().attributedPlaceholder = NSAttributedString(string: "Enter your name",
            attributes:[NSForegroundColorAttributeName: UIColor(rgb: 0xa3a3a3)])
        
        // Set the color of the status bar text
        if statusBarTextIsBlack == true {
            UIApplication.sharedApplication().statusBarStyle = .Default
        } else {
            UIApplication.sharedApplication().statusBarStyle = .LightContent
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}