//
//  WebKitVC.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 12/09/23.
//

import UIKit
import WebKit


class WebKitVC: UIViewController , WKUIDelegate , WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    let customLoader = CustomLoaderToRotate.initwith()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        //        loadHTMLString()
    }
}


extension WebKitVC {
    
    @IBAction func tapToReload(_ sender : UIButton){
        DispatchQueue.main.async {
            self.webView.reload()
        }
    }
    
    @IBAction func tapToBack(_ sender : UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func downloadWebView(_ sender : UIButton) {
        saveWebViewAsPDF(webView: webView)
    }
}

extension WebKitVC {
    
    func setCustomLoader(){
        customLoader.center = self.view.center
        self.view.addSubview(customLoader)
        customLoader.startAnimating()
    }
    
    func loadHTMLString(){
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    func prepareUI(){
        webView.navigationDelegate = self
        let myRequest = URLRequest(url: googleURL!)
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.bouncesZoom = false
        setCustomLoader()
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web page loaded successfully.")
        DispatchQueue.main.async {
            self.customLoader.stopAnimating()
        }
    }
    
    func saveWebViewAsPDF(webView: WKWebView) {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: webView.bounds)
        
        let pdfURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("webView\(Int(Date().timeIntervalSince1970)).pdf")
        
        do {
            try pdfRenderer.writePDF(to: pdfURL) { context in
                context.beginPage()
                webView.layer.render(in: context.cgContext)
            }
            print("PDF saved at \(pdfURL)")
        } catch {
            // Handle errors
            print("Error saving PDF: \(error.localizedDescription)")
        }
    }
}


