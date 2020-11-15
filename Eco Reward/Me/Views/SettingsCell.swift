//
//  SettingsCell.swift
//  Eco Reward
//
//  Created by Yang Xu on 16/10/20.
//

import UIKit

class SettingsCell: UITableViewCell {



    // Properties

//    lazy var switchControl: UISwitch = {
//        let switchControl = UISwitch()
//        switchControl.isOn = true
//        switchControl.onTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
//        switchControl.translatesAutoresizingMaskIntoConstraints = false
//        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
//        return switchControl
//    }()



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        addSubview(switchControl)
//        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    @objc func handleSwitchAction(sender: UISwitch) {
//        if sender.isOn {
//            print("On")
//        } else {
//            print("Off")
//        }
//    }

}
