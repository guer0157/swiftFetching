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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
//            add code to update tableview here.
            let
        }
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

//         Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
