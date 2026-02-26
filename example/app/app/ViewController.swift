import UIKit
import WebKit
import AffiseAttributionLib
import SwiftUI


class ViewController: UIViewController, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var webViewWrapper: UIView!
    @IBOutlet weak var eventsWrapper: UIScrollView!
    @IBOutlet weak var storeWrapper: UIView!
    
    var webView: WKWebView?
    
    private let listEvents: [Event] = DefaultEventsFactory().createEvents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        // Do any additional setup after loading the view.
        
        let buttons = listEvents.enumerated().map { (index, event) -> UIButton in
            let button = UIButton(type: .system)
            if let subscribeEvent = event as? BaseSubscriptionEvent {
                button.setTitle(subscribeEvent.subtype(), for: .normal)
            } else {
                button.setTitle(event.getName(), for: .normal)
            }
            button.frame = CGRect(x: 0, y: 0, width: 0, height: 60)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            button.setTitleColor(UIColor.white, for: .normal)
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            button.backgroundColor = UIColor(red: 38/255, green: 34/255, blue: 58/255, alpha: 1)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            return button
        }

        buttons.forEach {
            stackView.addArrangedSubview($0)
        }
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0,
                                          width: eventsWrapper.frame.width,
                                          height: eventsWrapper.bounds.height), configuration: config)
        if let webView = webView,
            let indexURL = Bundle.main.url(forResource: "index", withExtension: "html") {
            
            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL)
            webViewWrapper.addSubview(webView)
            
            webView.fillAnchor(webViewWrapper)
            Affise.registerWebView(webView)
        }
                
        storeUi(storeWrapper)
    }
    
    func storeUi(_ root: UIView) {
        if #available(iOS 13.0, *) {
            if let view = UIHostingController(rootView: StoreView()).view {
                root.addSubview(view)
                view.fillAnchor(root)
            }
        } else {
            let label = UILabel()
            label.text = "No SwiftUi View"
            label.textColor = UIColor.red
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            
            root.addSubview(label)
            label.fillAnchor(root)
        }
    }
    
    @objc
    func pressed(sender: UIButton!) {
        // Send event
        listEvents[sender.tag].send();
    }
    
    @IBAction func didValueChangedControl(_ sender: UISegmentedControl) {
        eventsWrapper.isHidden = sender.selectedSegmentIndex != 0
        webViewWrapper.isHidden = sender.selectedSegmentIndex != 1
        storeWrapper.isHidden = sender.selectedSegmentIndex != 2
    }
}

extension UIView {
    func fillAnchor(_ root: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: root.topAnchor, constant: 0).isActive = true
        self.leftAnchor.constraint(equalTo: root.leftAnchor, constant: 16).isActive = true
        self.bottomAnchor.constraint(equalTo: root.bottomAnchor, constant: 0).isActive = true
        self.rightAnchor.constraint(equalTo: root.rightAnchor, constant: -16).isActive = true
    }
}
