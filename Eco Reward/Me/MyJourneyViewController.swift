//
//  MyAccountViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 19/10/20.
//

import UIKit
import Charts
import TinyConstraints

class MyJourneyViewController: UIViewController {
    
    
    var yValuesArray: Array<ChartDataEntry> = []
    
    lazy var lineChartView: LineChartView  = {
        let chartView = LineChartView()
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(5, force: true)
        //yAxis.labelTextColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1.0)
        yAxis.labelTextColor = .systemGray
        yAxis.labelPosition = .outsideChart
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(30, force: true)
        
        chartView.animate(xAxisDuration: 3)
        
        
        
        return chartView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Journey"
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        //readUserInfo(completion: <#(Array<String>) -> Void#>)
        
        setData()

    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry)
    }
    
    
    func setData() {
        
        readUserInfo { (recordArray) in
     
            var array: Array<Double> = recordArray
     
            //print(recordArray)
            
            let count = recordArray.count

            let number = 30 - count
            
            for _ in 1...number {
                array.append(0)
                
            }
            
            array = array.reversed()
     
            for i in 1...30 {
                self.yValuesArray.append(ChartDataEntry(x: Double(i), y: Double(array[i-1])))
            }
            
            let set1 = LineChartDataSet(entries: self.yValuesArray, label: "Average Green Stars of Purchase for the Past 30 Days")
            
            let data = LineChartData(dataSet: set1)
            
            set1.mode = .cubicBezier
            set1.lineWidth = 3
            set1.setColor(.systemGray)
            set1.drawCirclesEnabled = false
            //set1.setCircleColor(NSUIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1.0))
            set1.drawHorizontalHighlightIndicatorEnabled = false
            
            
            self.lineChartView.data = data
        }
}
    

    

    
    

    
    
//    let yValues: [ChartDataEntry] = [
//        ChartDataEntry(x: 1, y: 1.1),
//        ChartDataEntry(x: 2, y: 2.5),
//        ChartDataEntry(x: 3, y: 3.4),
//        ChartDataEntry(x: 4, y: 4.6),
//        ChartDataEntry(x: 5, y: 3.2),
//        ChartDataEntry(x: 6, y: 4.2),
//        ChartDataEntry(x: 7, y: 4.3),
//        ChartDataEntry(x: 8, y: 4.4),
//        ChartDataEntry(x: 9, y: 4.7),
//        ChartDataEntry(x: 10, y: 3.9),
//        ChartDataEntry(x: 11, y: 4.0),
//        ChartDataEntry(x: 12, y: 4.5),
//        ChartDataEntry(x: 13, y: 4.5),
//        ChartDataEntry(x: 14, y: 4.5),
//        ChartDataEntry(x: 15, y: 4.5),
//        ChartDataEntry(x: 16, y: 4.5),
//        ChartDataEntry(x: 17, y: 4.5),
//        ChartDataEntry(x: 18, y: 4.5),
//        ChartDataEntry(x: 19, y: 4.5),
//        ChartDataEntry(x: 20, y: 4.5),
//        ChartDataEntry(x: 21, y: 4.5),
//        ChartDataEntry(x: 22, y: 4.5),
//        ChartDataEntry(x: 23, y: 4.5),
//        ChartDataEntry(x: 24, y: 4.5),
//        ChartDataEntry(x: 25, y: 4.5),
//        ChartDataEntry(x: 26, y: 4.5),
//        ChartDataEntry(x: 27, y: 4.5),
//        ChartDataEntry(x: 28, y: 4.5),
//        ChartDataEntry(x: 29, y: 4.5),
//        ChartDataEntry(x: 31, y: 4.5)
//
//
//    ]
    
    
    
    
}








//MARK: - Testing populate the purchase reocrd

// date, number of items, total green credit points, total spending
//    let dumbRecord1: Array = ["6/7/2019","10","25", "20.8"]
//    let dumbRecord2: Array = ["15/8/2020","10","15", "45.2"]
//    let dumbRecord3: Array = ["13/01/2020","10","30", "51.9"]
//    let dumbRecord4: Array = ["7/3/2017","5","12", "28.8"]
//    let dumbRecord5: Array = ["13/5/2018","7","35", "33.2"]
//    let dumbRecord6: Array = ["31/5/2019","12","34", "12.9"]


//        addNewRecord(record: dumbRecord1)
//        addNewRecord(record: dumbRecord2)
//        addNewRecord(record: dumbRecord3)
//        addNewRecord(record: dumbRecord4)
//        addNewRecord(record: dumbRecord5)
//        addNewRecord(record: dumbRecord6)
