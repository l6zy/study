//
//  ManageTableViewController.swift
//  Weather
//
//  Created by ZL on 2021/5/27.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit

class ManageTableViewController: UITableViewController {

    var countyList = Array<CountyData>() //保存城市信息
    var delList = [String:Int]() //保存删除城市的索引
    var count:Int = 0  //计数已删除的城市数量
    let str = NSHomeDirectory() + "/Documents/"  //app文档保存路径
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "管理已选城市"
        readFileCity()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.countyList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID", for: indexPath)

        // Configure the cell...
        let row = indexPath.row
        cell.textLabel?.text = self.countyList[row].name
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            print(row)
            self.countyList.remove(at: row)
            self.delList.updateValue(row, forKey: "row\(self.count)")
            self.count += 1
            self.writeFile()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }
    @IBAction func complete(_ sender: Any) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ManageCityNotification"), object: nil, userInfo: self.delList)
        }
    }
    
    func writeFile(){
        let fileUrl =  NSHomeDirectory() + "/Documents/json/localCity.json"
        var str = "["
        let n = countyList.count
        for i in 1 ... n{
            str += countyList[n - i].classToString() + ","
        }
        // str = str.substringToIndex(str.characters.endIndex.advancedBy(-1))
        str = String(str[..<str.index(str.endIndex, offsetBy: -1)])
        str += "]"
        try! str.write(toFile: fileUrl, atomically: true, encoding: String.Encoding.utf8)
    }

    //初始化读取本地已添加城市
    func readFileCity(){
        let fileUrl = "\(self.str)/json/localCity.json"
        
        let fileManager = FileManager.default
        let filePath: String = "\(self.str)/json"
        let exist = fileManager.fileExists(atPath: filePath)
        print(fileUrl)
        if exist{
            if fileManager.fileExists(atPath: "\(filePath)/localCity.json"){
                let data = NSData(contentsOfFile: fileUrl)
                let json = JSON(data: data! as Data)
                
                for h in json{
                    let city = CountyData(json: h.1)
                    if countyList.filter({ $0.id == city.id }).isEmpty{
                        countyList.insert(city, at: 0)
                    }
                }
            }
            else{
                let s = ""
                try! s.write(toFile: "\(filePath)/localCity.json", atomically: true, encoding: String.Encoding.utf8)
            }
        }else{
            
            try! fileManager.createDirectory(atPath: filePath,withIntermediateDirectories: true, attributes: nil)
            let s = ""
            
            try! s.write(toFile: "\(filePath)/localCity.json", atomically: true, encoding: String.Encoding.utf8)
        }
    }
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
