//
//  AddTableViewController.swift
//  Weather
//
//  Created by ZL on 2021/5/27.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {
    var listArr:[String]!
    var listCity:[String:String]!

    let str = NSHomeDirectory() + "/Documents/"  //app文档保存路径
    override func viewDidLoad() {
        super.viewDidLoad()

        let plistPath = Bundle.main.path(forResource: "City", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: plistPath!)
        self.listArr = (dict?.allKeys as! [String])
        self.listCity = (dict as! [String:String])
        self.title = "添加城市"

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listCity.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = listArr[row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            let row = indexPath.row
            let e = ["id":"\(self.listCity[self.listArr[row]]!)","name":"\(self.listArr[row])"]
            NotificationCenter.default.post(name: Notification.Name("AddCityNotification"), object: nil, userInfo: e)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true) {}
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
