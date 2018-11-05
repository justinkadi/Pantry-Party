///////////////////
// NOTIFICATIONS //
///////////////////

// querying permission for notifications
let notificationCenter = UNUserNotificationCenter.current()

notificationCenter.getNotificationSettings { (settings) in
    // Do not schedule notifications if not authorized.
    guard settings.authorizationStatus == .authorized else {return}
    
    if settings.alertSetting == .enabled {
        // Schedule an alert-only notification.
        self.alertOnlyFunc()
    }
    else {
        // Schedule a notification with a badge and sound.
        self.badgeAndSoundFunc()
    }
}

// creating the notofication
// first, content
let content = UNNotificationContent()
content.title = "Weekly Staff Meeting"
content.body = "Every Tuesday at 2pm"
// let content = UNMutableNotificationContent()
// NSString.localizedUserNotificationStringForKey("Hello!", arguments: nil)
// in case the contents change between now and later
content.sound = UNNotificationSound.default()

// second, trigger
// Deliver the notification in five seconds.
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

// third, assign to request
// identifier can be used to remove notifications
let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)

// finnally, schedule
let center = UNUserNotificationCenter.current()
center.add(request) { (error) in
    if error != nil {
        // Handle any errors
    }
}



////////////////////
// TEXT DETECTION //
////////////////////

// add firebase https://firebase.google.com/docs/ios/setup
// add to podfile:
pod 'Firebase/Core'
pod 'Firebase/MLVision'
# If using an on-device API:
pod 'Firebase/MLVisionTextModel'

// back to SWIFT
import Firebase

let vision = Vision.vision()
let textRecognizer = vision.cloudTextRecognizer()
//let textRecognizer = vision.onDeviceTextRecognizer()

// OPTIONAL language hints
let options = VisionCloudTextRecognizerOptions()
options.languageHints = ["en", "hi"]
let textRecognizer = vision.cloudTextRecognizer(options: options)

// first rotate the UIImage
let image = VisionImage(image: uiImage)

// recognise
textRecognizer.process(visionImage) { result, error in
    guard error == nil, let result = res else {
        // ...
        let resultText = res.text
        for block in res.blocks {
            let blockText = block.text
            let blockConfidence = block.confidence
            let blockLanguages = block.recognizedLanguages
            let blockCornerPoints = block.cornerPoints
            let blockFrame = block.frame
            for line in block.lines {
                let lineText = line.text
                let lineConfidence = line.confidence
                let lineLanguages = line.recognizedLanguages
                let lineCornerPoints = line.cornerPoints
                let lineFrame = line.frame
                for element in line.elements {
                    let elementText = element.text
                    let elementConfidence = element.confidence
                    let elementLanguages = element.recognizedLanguages
                    let elementCornerPoints = element.cornerPoints
                    let elementFrame = element.frame
                }
            }
        }
    }
}


///////////////
// HTTP POST //
///////////////
// Use image name from bundle to create NSData
let image : UIImage = UIImage(named:"imageNameHere")!
// Now use image to create into NSData format
let imageData:NSData = UIImagePNGRepresentation(image)!
// converting img to base 64 str
let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)


// POST https://vision.googleapis.com/v1/images:annotate?key=YOUR_API_KEY

{
"requests":[
    {
    "image":
        {
        "content":strBase64
    },
    "features":[
        {
        "type":"TEXT_DETECTION",
        "maxResults":1
    }]
]
}
    }


// processing result
import Foundation

let data: Data // received from a network request, for example
let json = try? JSONSerialization.jsonObject(with: data, options: [])

let dictionary = json as? [String: Any]
let response = dictionary["responses"] as? [String: Any]
let array = response as? [Any]
let responseDict = array.first as? [String: Any]
let textAnnotations = responseDict["textAnnotations"] as? [String: Any]
let annotationsArray = textAnnotations as? [Any]
var str: String = ""
for object in annotationsArray {
    // access all objects in array
    var dict = object as? [String: Any]
    var description = dict["description"] as? [String: Any]
    str.append(description)
}

// access individual object in array
//
//if let dictionary = json as? [String: Any] {
//    if let response = dictionary["responses"] as? [String: Any] {
//        if let array = jsonWithArrayRoot as? [Any] {
//            if let firstObject = array.first {
//                // access individual object in array
//            }
//        }
//    }
//}
