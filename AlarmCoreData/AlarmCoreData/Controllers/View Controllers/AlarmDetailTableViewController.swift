//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Karl Pfister on 1/19/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - Properties
    var alarm: Alarm?
    var isAlarmOn: Bool = true
    var defaultColor: UIColor = .white

    //MARK: - Outlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let color = contentView.backgroundColor {
            defaultColor = color
        }
        updateView()
    }

    //MARK: - Helper Functions
    func updateView() {
        guard let alarm = alarm else {return}
        alarmFireDatePicker.date = alarm.fireDate!
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        designIsEnabledButton()
    }

    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = defaultColor
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }

    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, title != "" else {return}


        if let alarm = alarm{
            AlarmController.sharedInstance.update(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isEnabled: isAlarmOn)
        } else{
            AlarmController.sharedInstance.createAlarm(withTitle: title, on: isAlarmOn, and: alarmFireDatePicker.date)
        }
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.sharedInstance.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        }else{
            isAlarmOn = !isAlarmOn
        }
        designIsEnabledButton()
    }
}
