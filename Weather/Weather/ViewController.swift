//
//  ViewController.swift
//  Weather
//
//  Created by ZL on 2021/5/26.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController ,UIScrollViewDelegate{
    var viewHeight:CGFloat = 0.0
    var viewWidth:CGFloat = 0.0
    var scrollView:UIScrollView!
    
    @IBOutlet weak var future: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView2: UIImageView!
    
    
    @IBOutlet weak var curTem: UILabel!
    @IBOutlet weak var curWea: UILabel!
    @IBOutlet weak var tomWea: UILabel!
    @IBOutlet weak var afTomWea: UILabel!
    
    @IBOutlet weak var curIcon: UIImageView!
    @IBOutlet weak var tomIcon: UIImageView!
    @IBOutlet weak var afTomIcon: UIImageView!
    
    @IBOutlet weak var curTemd2n: UILabel!
    @IBOutlet weak var tomTemd2n: UILabel!
    @IBOutlet weak var afTomTemd2n: UILabel!
    
    var countyList = Array<CountyData>()  //城市列表
    var curID:String!
    var weatherDict = Dictionary<String,CityWeatherData>()  //保存城市天气数据
    let str = NSHomeDirectory() + "/Documents/"  //app文档保存路径
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        readFileCity()
        
        viewHeight = self.view.frame.size.height
        viewWidth = self.view.frame.size.width
        
        self.view.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        future.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8013966182)
        future.layer.opacity = 0.2
        future.layer.cornerRadius = future.frame.size.height / 2

        self.scrollView = UIScrollView(frame: self.view.frame)
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(countyList.count), height: self.scrollView.frame.size.height)
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        self.pageControl.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.pageControl.alpha = 0.7
        self.pageControl.numberOfPages = countyList.count
        self.pageControl.currentPage = 0
        self.pageControl.addTarget(self, action: #selector(changePage(_:)), for: UIControl.Event.valueChanged)
        self.view.addSubview(self.pageControl)
        
        self.view.sendSubviewToBack(pageControl)
        self.view.sendSubviewToBack(scrollView)

        curTem.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        curTem.layer.shadowOffset = CGSize(width: 1, height: 1)
        curTem.layer.shadowOpacity = 0.5
        
//        self.view.backgroundColor = #colorLiteral(red: 0.5354888797, green: 0.6036995988, blue: 0.6476076749, alpha: 1)
//        AniTarget(start: 0, end: 24, time: 5, path: "yu_", times: 0)
//        AniTarget(start: 0, end: 119, time: 10, path: "al_", times: 0)
//        AniTarget2(time: 5, times: 2)
        //AniTarget(start: 2, end: 2, time: 1, path: "yun_", times: 0)
        //tomIcon.image = UIImage(named: "icon_yun.png")
        requestWeatherDataForId(cityId: countyList[self.pageControl.currentPage].id)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCityComplete(_:)) , name: Notification.Name(rawValue: "AddCityNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(manageCityComplete(_:)), name: Notification.Name(rawValue: "ManageCityNotification"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NotificationCenter.default.removeObserver(self)
    }
    
    // 帧动画播放器
    func AniTarget(start:Int,end:Int,time:Int,path:String,times:Int){
        //创建一个图片数组
        var images:Array<UIImage> = []
        for i in start ... end {
            let image = UIImage(named: "\(path)\(i).png")
            images.append(image!)
        }
        //设置图像视图的动画图片属性
        imageView.animationImages = images
        
        //设置帧动画的时长为五秒
        imageView.animationDuration = TimeInterval(time)
        
        //设置动画循环次数，0为无限播放
        imageView.animationRepeatCount = times
        
        //开始动画的播放
        imageView.startAnimating()
        
        self.view.addSubview(imageView)
        //将图片置入底层，防止遮挡天气数字
        self.view.sendSubviewToBack(imageView)
    }
    func AniTarget2(time:Int,times:Int){
        //创建一个图片数组
        var images:Array<UIImage> = []
        for i in 0 ... 30 {
            let image = UIImage(named: "dla_\(i).png")
            images.append(image!)
        }
        for i in 0 ... 24 {
            let image = UIImage(named: "dlb_\(i).png")
            images.append(image!)
        }
        for i in 0 ... 16 {
            let image = UIImage(named: "xla_\(i).png")
            images.append(image!)
        }
        for i in 0 ... 23 {
            let image = UIImage(named: "xlb_\(i).png")
            images.append(image!)
        }
        //设置图像视图的动画图片属性
        imageView2.animationImages = images
        
        //设置帧动画的时长为五秒
        imageView2.animationDuration = TimeInterval(time)
        
        //设置动画循环次数，0为无限播放
        imageView2.animationRepeatCount = times
        
        //开始动画的播放
        imageView2.startAnimating()
        
        self.view.addSubview(imageView2)
        //将图片置入底层，防止遮挡天气数字
        self.view.sendSubviewToBack(imageView2)
    }
    func startAni()
    {
        let str = weatherDict[curID]?.daily[0].wea_img
        if str == "qing" || str == "yun"  {
            let random = Int(arc4random()%8)
            AniTarget(start: random, end: random, time: 20, path: "yun_", times: 0)
            self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else if str == "lei" {
            self.view.backgroundColor = #colorLiteral(red: 0.5354888797, green: 0.6036995988, blue: 0.6476076749, alpha: 1)
            AniTarget(start: 0, end: 119, time: 10, path: "al_", times: 0)
            AniTarget2(time: 5, times: 2)
        }else if str == "yu" {
            self.view.backgroundColor = #colorLiteral(red: 0.5354888797, green: 0.6036995988, blue: 0.6476076749, alpha: 1)
            AniTarget(start: 0, end: 24, time: 5, path: "yu_", times: 0)
        }else if str == "yin" || str == "wu" {
            let random = Int(arc4random()%8)
            AniTarget(start: random, end: random, time: 20, path: "yun_", times: 0)
            self.view.backgroundColor = #colorLiteral(red: 0.5354888797, green: 0.6036995988, blue: 0.6476076749, alpha: 1)
        }else if str == "xue" || str == "bingbao" {
            let random = Int(arc4random()%8)
            AniTarget(start: random, end: random, time: 20, path: "yun_", times: 0)
            self.view.backgroundColor = #colorLiteral(red: 0.6007752103, green: 0.8330631037, blue: 1, alpha: 1)
        }else if str == "shachen" {
            let random = Int(arc4random()%8)
            AniTarget(start: random, end: random, time: 20, path: "yun_", times: 0)
            self.view.backgroundColor = #colorLiteral(red: 0.8997744563, green: 0.6884673549, blue: 0.3562196836, alpha: 1)
        }
    }
    
    //通过cityid请求天气数据
    func requestWeatherDataForId(cityId id: String){
        
        let weatherUrl = "https://www.tianqiapi.com/free/week?appid=74827762&appsecret=47IW7XPQ&cityid=" + id
        requestForUrl(url: weatherUrl)
        
    }
    
    //通过URL请求数据
    func requestForUrl(url: String){
        var json: JSON!
        //请求预报
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (Response) in

            if Response.result.error == nil{
                let data = Response.result.value
                json = JSON(data: data!)

                let da = CityWeatherData(json: json)
                let id = da.id
                self.curID = id
                self.weatherDict[id!] = da
                self.startAni()
                // let e = CountyData(id: id!, name: da.name)
                // self.countyList.append(e)
                // self.writeFile()
                
                let calender:Calendar = Calendar(identifier: .gregorian)
                var comps:DateComponents = DateComponents()
                comps = calender.dateComponents([.year,.month,.weekday,.hour,.minute,.second], from: Date())
                let array = ["周日","周一","周二","周三","周四","周五","周六"]
                // 设置标题
                self.title = self.weatherDict[id!]?.name
                // 设置大温度
                self.curTem.text = self.weatherDict[id!]?.daily[0].tem_day
                //设置未来三天温度
                self.curWea.text = "今天·" + (self.weatherDict[id!]?.daily[0].wea)!
                self.tomWea.text = "明天·" + (self.weatherDict[id!]?.daily[1].wea)!
                self.afTomWea.text = array[(comps.weekday! + 1)%6] + "·" + (self.weatherDict[id!]?.daily[2].wea)!
                //设置高低温
                self.curTemd2n.text = (self.weatherDict[id!]?.daily[0].tem_day)! + "º/" + (self.weatherDict[id!]?.daily[0].tem_night)! + "º"
                self.tomTemd2n.text = (self.weatherDict[id!]?.daily[1].tem_day)! + "º/" + (self.weatherDict[id!]?.daily[1].tem_night)! + "º"
                self.afTomTemd2n.text = (self.weatherDict[id!]?.daily[2].tem_day)! + "º/" + (self.weatherDict[id!]?.daily[2].tem_night)! + "º"
                
                //设置天气图片
                self.curIcon.image = UIImage(named: "icon_" + (self.weatherDict[id!]?.daily[0].wea_img)! + ".png")
                self.tomIcon.image = UIImage(named: "icon_" + (self.weatherDict[id!]?.daily[1].wea_img)! + ".png")
                self.afTomIcon.image = UIImage(named: "icon_" + (self.weatherDict[id!]?.daily[2].wea_img)! + ".png")
                
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "futureWeather" {
            let future = segue.destination as! FutureTableViewController
            future.weatherDict = self.weatherDict
            future.ID = curID
        }
    }
    
    //初始化读取本地已添加城市
    func readFileCity(){
        let fileUrl = "\(self.str)/json/localCity.json"
        
        let fileManager = FileManager.default
        let filePath: String = "\(self.str)/json"
        let exist = fileManager.fileExists(atPath: filePath)
        // print(fileUrl)
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
                //requestWeatherDataForId(cityId: "101200101")
                let s = "[{\"id\":\"101200101\",\"name\":\"武汉\"}]"
                try! s.write(toFile: "\(filePath)/localCity.json", atomically: true, encoding: String.Encoding.utf8)
            }
        }else{
            
            try! fileManager.createDirectory(atPath: filePath,withIntermediateDirectories: true, attributes: nil)
            let s = ""
            
            try! s.write(toFile: "\(filePath)/localCity.json", atomically: true, encoding: String.Encoding.utf8)
        }
    }
    
    //写入文件
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
    
    @objc func addCityComplete(_ notification:Notification){
        let data = notification.userInfo as! [String:String]
        print(data)
        
        let e = CountyData(id: data["id"]!, name: data["name"]!)
        self.countyList.append(e)
        self.writeFile()
        self.pageControl.numberOfPages = self.countyList.count
    }
    
    @objc func manageCityComplete(_ notification:Notification){
        let data = notification.userInfo as? [String:Int]
        print(data as Any)
        
        if data != nil {
            for i in 0..<data!.count{
                self.countyList.remove(at: data!["row\(i)"]!)
            }
            self.writeFile()
            self.pageControl.numberOfPages = self.countyList.count
        }

    }
    
    //屏幕滚动委托
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = self.scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x) / Int(viewWidth)
        //self.requestWeatherDataForId(cityId: self.countyList[self.pageControl.currentPage].id)
    }

    @IBAction func changePage(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPoint(x: self.viewWidth * CGFloat(whichPage), y: 0)
        })
        
    }
    
}

