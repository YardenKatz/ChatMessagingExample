//
//  SampleData.swift
//  ChatPlayground
//
//  Created by Yarden Katz on 18/10/2020.
//

import Foundation

struct MyMessageStruct {
    var time: String = " "
    var name: String = " "
    var profileImageName: String = ""
    var contentImageName: String = ""
    var message: String = " "
}

class SampleData: NSObject {
    let sampleStrings: [String] = [
        "First message with short text.",
        "Second message with longer text that should cause word wrapping in this cell.",
        "Third message with some embedded newlines.\nThis line comes after a newline (\"\\n\"), so we can see if that works the way we want.",
        "Message without content image.",
        "Longer Message without content image.\n\nWith a pair of embedded newline (\"\\n\") characters giving us a \"blank line\" in the message text.",
        "The sixth message, also without a content image."
    ]
    
    lazy var sampleData: [MyMessageStruct] = [
        MyMessageStruct(time: "08:36", name: "Bob",   profileImageName: "pro1", contentImageName: "content1", message: sampleStrings[0]),
        MyMessageStruct(time: "08:47", name: "Bob",   profileImageName: "pro1", contentImageName: "content2", message: sampleStrings[1]),
        MyMessageStruct(time: "08:59", name: "Joe",   profileImageName: "pro2", contentImageName: "content3", message: sampleStrings[2]),
        MyMessageStruct(time: "09:06", name: "Steve", profileImageName: "pro3", contentImageName:         "", message: sampleStrings[3]),
        MyMessageStruct(time: "09:21", name: "Bob",   profileImageName: "pro1", contentImageName:         "", message: sampleStrings[4]),
        MyMessageStruct(time: "09:45", name: "Joe",   profileImageName: "pro2", contentImageName:         "", message: sampleStrings[5]),
    ]
}
