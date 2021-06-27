//
//  FutureTableViewController.swift
//  Weather
//
//  Created by ZL on 2021/5/27.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit

class FutureTableViewController: UITableViewController {

    var weatherDict = Dictionary<String,CityWeatherData>()
    var ID:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.weatherDict[ID!]?.daily.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID", for: indexPath) as! CustomCell

        // Configure the cell...
        tableView.rowHeight = 80
        let row = indexPath.row
        let data = weatherDict[ID!]?.daily[row]
        let calender:Calendar = Calendar(identifier: .gregorian)
        var comps:DateComponents = DateComponents()
        comps = calender.dateComponents([.year,.month,.weekday,.hour,.minute,.second], from: Date())
        let array = ["周日","周一","周二","周三","周四","周五","周六"]
        let str:String!
        switch indexPath.row {
        case 0:
            str = "今天"
            break
        case 1:
            str = "明天"
            break
        default:
            str = array[(comps.weekday! + row - 1)%7]
        }
        cell.week.text = str
        cell.date.text = String((data?.date[(data?.date.index((data?.date.startIndex)!, offsetBy: 5))!...])!)
        cell.icon.image = UIImage(named:"icon_gray_" +  (data!.wea_img)! + ".png")
        cell.tem.text = (data?.tem_day)! + "º/" + (data?.tem_night)! + "º"
        cell.wea.text = data?.wea
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
