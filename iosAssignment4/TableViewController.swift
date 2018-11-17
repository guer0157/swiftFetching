//
//  TableViewController.swift
//  iosAssignment4
//
//  Created by Cesar Guerrero on 2018-11-16.
//  Copyright © 2018 guer0157.AlgonquinCollege. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var jsonResponse:[[String:String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loadInfo(_ sender: Any) {
        let urlForFetch : URL = URL(string: "https://lenczes.edumedia.ca/mad9137/a4/respond.php")!
        let infoRequest: URLRequest = URLRequest(url: urlForFetch)
        let requestSession: URLSession = URLSession.shared
        
        let newTask = requestSession.dataTask(with: infoRequest, completionHandler: continueTask)
        
        newTask.resume()
    }
    func continueTask(serverData: Data?, serverResponse: URLResponse?, serverError: Error?)-> Void{
        if serverError != nil{
            self.handleData(responseString: "", error: serverError?.localizedDescription)
        }else{
            let passData=String(data: serverData!, encoding: .utf8)!
            self.handleData(responseString: passData as String, error: nil)
        }
    }
    
    func handleData(responseString:String, error:String?){
//        var outputText:String?
        
        if error != nil{
            print("Error is " + error!)
        }else{
            if let jsonObj = responseString.data(using: String.Encoding.utf8){
                do{
                    jsonResponse = try JSONSerialization.jsonObject(with: jsonObj, options: []) as? [[String:String]]
                }catch let handleError{
                    print(handleError.localizedDescription)
                }
            }
           
        }
        
        DispatchQueue.main.async(){
             self.tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let jsonResponse = self.jsonResponse {
            print(jsonResponse.count)
            return jsonResponse.count
        } else {
            return 0
        }
 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        
        if let resp = self.jsonResponse{
                    let jsonDictionaryRow = resp[indexPath.row] as [String:Any]
                    let evTitle = jsonDictionaryRow["eventTitle"] as! String
                    let evDatename = jsonDictionaryRow["eventDate"] as! String
                    cell.textLabel!.text = "\(evTitle) \(evDatename)"
        }else{
            cell.textLabel!.text="Nothing yet"
        }

        return cell
    }

}
