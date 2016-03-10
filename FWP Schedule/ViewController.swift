//
//  ViewController.swift
//  FWP Schedule
//
//  Created by Peter Evans on 9/18/15.
//  Copyright © 2015 Peter Evans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentBlockLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var nextBlockLabel: UILabel!
    
    // tuples for each day of the week in the schedule. Each contains the starting time and name of each block.
    
    let mondaySchedule: [(String, String)] = [("14:10", "A"), ("15:05", "G1"), ("15:45", "B"), ("16:40", "MX"), ("17:20", "Advisory"), ("17:40", "C"), ("18:35", "Lunch"), ("19:05", "D"), ("20:00", "E"), ("20:55", "F"), ("21:51", "Go Home")]
    let tuesdaySchedule: [(String, String)] = [("14:10", "E"), ("15:05", "F"), ("16:00", "Conf"), ("16:20", "C"), ("17:15", "H2"), ("18:10", "Lunch"), ("18:40", "B"), ("19:35", "A"), ("20:30", "G2"), ("21:26", "Go Home")]
    let wednesdaySchedule: [(String, String)] = [("14:10", "C"), ("15:05", "D"), ("16:00", "GrRoom"), ("16:40", "MX"), ("17:20", "Advisory"), ("17:40", "H3"), ("18:35", "Lunch"), ("19:05", "F"), ("20:00", "E"), ("20:55", "G3"), ("21:51", "Go Home")]
    let thursdaySchedule: [(String, String)] = [("14:10", "F"), ("15:05", "E"), ("16:00", "Conf"), ("16:20", "D"), ("17:15", "H4"), ("18:10", "Lunch"), ("18:40", "A"), ("19:35", "B"), ("20:30", "G4"), ("21:26", "Go Home")]
    let fridaySchedule: [(String, String)] = [("14:10", "B"), ("15:05", "Stu Gov"), ("15:45", "A"), ("16:40", "MX"), ("17:20", "Advisory"), ("17:40", "H5"), ("18:35", "Lunch"), ("19:05", "C"), ("20:00", "D"), ("20:55", "G5"), ("21:51", "Go Home")]
    
    // variable to set the current day's schedule
    var todaySchedule: [(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // string to hold AM or PM
        var period: String = ""
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Weekday], fromDate: date)
        let day = components.weekday
        var hour = components.hour
        let minute = components.minute
        
        dayOfWeekLabel.text = determineDayOfWeek(day)
        
        // set the correct period
        if hour > 12 {
            hour = hour - 12
            period = "PM"
        }
        else if hour == 12 {
            period = "PM"
        }
        else {
            period = "AM"
        }
        
        // creates the string for the current time
        if minute >= 10 {
            currentTimeLabel.text = "\(hour):\(minute) \(period)"
        }
        else {
            currentTimeLabel.text = "\(hour):0\(minute) \(period)"
        }
        
        
        let timeOfDay: String = NSDate().description
        let timeRange = timeOfDay.startIndex.advancedBy(11)..<timeOfDay.startIndex.advancedBy(16)
        let time = timeOfDay.substringWithRange(timeRange)
        
        var index = 0
        
        while index < todaySchedule.count {
            if time < todaySchedule[0].0 {
                currentBlockLabel.text = "not started"
                nextBlockLabel.text = todaySchedule[0].1
                break
            }
            else if time >= todaySchedule[todaySchedule.count - 1].0 {
                currentBlockLabel.text = "School is over"
                nextBlockLabel.text = determineDayOfWeek(day + 1)
                break
            }
            else if time >= todaySchedule[index].0 && time < todaySchedule[index + 1].0 {
                currentBlockLabel.text = todaySchedule[index].1
                nextBlockLabel.text = todaySchedule[index + 1].1
                break
            }
            else {
                index = index + 1
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function to determine the day of the week and set up the proper schedule
    func determineDayOfWeek(day: Int) -> String  {
        
        switch (day) {
        case 1:
            currentBlockLabel.text = "No school today"
            nextBlockLabel.text = "Monday"
            return "Sunday"
        case 2:
            todaySchedule = mondaySchedule
            return "Monday"
        case 3:
            todaySchedule = tuesdaySchedule
            return "Tuesday"
        case 4:
            todaySchedule = wednesdaySchedule
            return "Wednesday"
        case 5:
            todaySchedule = thursdaySchedule
            return "Thursday"
        case 6:
            todaySchedule = fridaySchedule
            nextBlockLabel.text = "No school tomorrow"
            return "Friday"
        case 7:
            currentBlockLabel.text = "No school today"
            nextBlockLabel.text = "No school tomorrow"
            return "Saturday"
        default:
            currentBlockLabel.text = "No school today"
            return "Saturday"
        }
    }
    


}

