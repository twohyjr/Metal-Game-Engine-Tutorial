import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var check_ShowMesh1: NSButton!
    @IBOutlet weak var check_ShowMesh2: NSButton!
    @IBOutlet weak var check_ShowMainMesh: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        check_ShowMesh1.state = Settings.ShowLeftChest ? .on : .off
        check_ShowMesh2.state = Settings.ShowRightChest ? .on : .off
        check_ShowMainMesh.state = Settings.ShowMainChest ? .on : .off
        // Do view setup here.
    }
    
    @IBAction func check_ShowMesh1(_ sender: NSButton) {
        Settings.ShowLeftChest = sender.state == .on ? true : false
    }
    
    @IBAction func check_ShowMesh2(_ sender: NSButton) {
        Settings.ShowRightChest = sender.state == .on ? true : false
    }
    
    @IBAction func check_MainMesh(_ sender: NSButton) {
        Settings.ShowMainChest = sender.state == .on ? true : false
    }
}
