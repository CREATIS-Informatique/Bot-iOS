//
//
//
//
//  Created by Theodros Mulugeta on 21.02.19.
//  Copyright © 2019 Theodros Mulugeta. All rights reserved.
//

import UIKit
import ApiAI

class ViewController: UIViewController {
    
    @IBOutlet weak var ReponseLabel: UILabel!
    
    @IBOutlet weak var QuestionTextField: UITextField!
    
    @IBAction func Envoyer(_ sender: Any) {
        DialogFlow()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func DialogFlow(){
        
        // Créer la liason
        
        let request = ApiAI.shared().textRequest()
        
        // Envoie la question
        
        if let text = self.QuestionTextField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        // Récupere la réponse
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.messages {
                let textResponseArray = textResponse[0] as NSDictionary
                
                // Affiche la réponse
                
                self.ReponseLabel.text = textResponseArray.value(forKey: "speech") as? String
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        // Clear le Text Field
        
        ApiAI.shared().enqueue(request)
        QuestionTextField.text = ""
        
    }
    
    // Descend le clavier
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
    }
    
}

