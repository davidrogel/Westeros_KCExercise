//
//  WikiViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 19/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var model: House
    
    init(model: House)
    {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        // Tan pronto como te des de alta en las notificaciones, haz el codigo para darte de baja
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(
            self,
            selector: #selector(houseDidChange(notification:)),
            name: name,
            object: nil) // objeto que manda la notificacion
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func syncModelWithView()
    {
        // Mostramos el loading indicator
        loadIndicator.isHidden = false
        // y lo animamos
        loadIndicator.startAnimating()
        
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
    
    @objc func houseDidChange(notification: Notification)
    {
        // Sacar el userInfo
        // Sacar la casa del userInfo
        // se pueden hacer guards uno detras de otro mediante comas(,)
        guard let info = notification.userInfo, let house = info[HOUSE_KEY] as? House else
        {
            return
        }
        
        // Actualizar mi modelo
        model = house
        
        // Sincronizar model y vista
        syncModelWithView()
    }
}

// Delegados
// Should: Para pedir permiso
// Will: Se está a punto de hacer algo 
// Did: Se ha terminado

extension WikiViewController : WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        // aqui tenemos que detener la animacion del loadIndicator
        loadIndicator.stopAnimating()
        // ocultar el loadIndicador
        loadIndicator.isHidden = true
    }
    
    // escaping es que la funcion se va a escapar al closure y se va a ejecutar más tarde
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        let type = navigationAction.navigationType
        switch type
        {
            case .linkActivated, .formSubmitted:
                decisionHandler(.cancel)
            default:
                decisionHandler(.allow)
        }
    }
}
