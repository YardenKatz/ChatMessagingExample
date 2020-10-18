//
//  ChatViewController.swift
//  ChatPlayground
//
//  Created by David Salzer on 18/10/2020.
//

import UIKit

class ChatViewController: UITableViewController {
    
    var myData: [MyMessageStruct] = SampleData().sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register the cell
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "chatCell")
        
        tableView.separatorStyle = .none
        tableView.backgroundView = GrayGradientView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatMessageCell
        
        // don't show the profile image if this message is from the same person
        //  as the previous message
        var isSameAuthor = false
        if indexPath.row > 0 {
            if myData[indexPath.row].name == myData[indexPath.row - 1].name {
                isSameAuthor = true
            }
        }
        
        cell.fillData(myData[indexPath.row], isSameAuthor: isSameAuthor)
        
        return cell
    }
    
}

