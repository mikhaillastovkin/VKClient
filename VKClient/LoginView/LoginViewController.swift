//
//  LoginViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 13.06.2021.
//

import WebKit
import Alamofire

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var wkWebView: WKWebView! {
        didSet {
            wkWebView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadVkToken()


    }

    func loadVkToken() {
        let baseUrl = "https://oauth.vk.com/authorize"
        let appId = "7923795"
        let parametrs: Parameters = [
            "client_id" : appId,
            "redirect_uri" : "https://oauth.vk.com/blank.html",
            "display" : "mobile",
            "scope" : "262150",
            "response_type" : "token",]
        let request = AF.request(baseUrl, method: .get, parameters: parametrs)
        guard let loadRequest = request.convertible.urlRequest else { return }

        wkWebView.load(loadRequest)
    }

}

extension LoginViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard navigationResponse.response.url?.path == "/blank.html",
              let fragment = navigationResponse.response.url?.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String : String]()) { res, par in
                var dict = res
                let key = par[0]
                let val = par[1]
                dict[key] = val
                return dict
            }
        Singletone.share.token = params["access_token"] ?? ""
        Singletone.share.idUser = params["user_id"] ?? "0"

        performSegue(withIdentifier: "fromLogintoTabBar", sender: nil)

        decisionHandler(.cancel)
    }

}
