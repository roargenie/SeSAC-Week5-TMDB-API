

import UIKit
import WebKit



class WebKitViewController: UIViewController {
    
    static let identifier = "WebKitViewController"
    
    var movieID: Int = 0
    var key: String = ""
    
    @IBOutlet weak var webkitView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webkitView.navigationDelegate = self
        
        requestVideo()
    }
    
    func requestVideo() {
        APIManagers.shared.videoRequest(movie_id: movieID) { data in
            self.key = data[0].key
            
            let destinationURL = "https://www.youtube.com/watch?v=\(self.key)"
            
            DispatchQueue.main.async {
                self.openWeb(destinationURL)
            }
        }
        
    }
    
}

extension WebKitViewController: WKNavigationDelegate {
    func openWeb(_ urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        
        webkitView.load(request)
    }
    
}
