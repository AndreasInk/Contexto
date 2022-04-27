//
//  Noti.swift
//  Contexto
//
//  Created by Andreas Ink on 4/25/22.
//

import SwiftUI
import Accelerate
import TabularData
class Noti: NSObject, ObservableObject {
    @Published var showShare = false
    @Published var yes: [Rating]  = [Rating]()
   
    @UserDefault("noti", defaultValue: [NotiData()]) var noti: [NotiData]
    
    @Published var currentNoti: NotiData?
    
    func populateGraphData() {
//        for data in currentNoti.ratings {
//
//           // yes.append(Rating(rating: Int(vDSP.mean(noti.ratings.filter{$0.category == data.category}.map{Double($0.rating)})), date: data.date))
//            print(data)
//        }
    }
    func contextualize(for feeling: String, with noti: NotiData) {
        for cat in noti.ratingCategories {
            print(cat)
            if feeling == cat.title {
               
                if let index = self.noti.firstIndex(where: { not in
                    return not.id == noti.id
                }) {
                  self.noti[index].ratings.append(Rating(category: cat.title, rating: cat.value, date: Date().formatted(date: .numeric, time: .shortened)))
              }
            }
        }
    }
    func createNoti(_ noti: NotiData, at interval: TimeInterval) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("YEZUS")
                var actions: [UNNotificationAction] = []
                for cat in noti.ratingCategories {
                    actions.append(UNNotificationAction(identifier: cat.title, title:  cat.title))
                    print("okok")
  
                }
            
    // Define the notification type
    let meetingInviteCategory =
          UNNotificationCategory(identifier: "FEELS",
                                 actions: actions,
          intentIdentifiers: [],
          hiddenPreviewsBodyPlaceholder: "",
          options: .customDismissAction)
    // Register the notification type.
    
    notificationCenter.setNotificationCategories([meetingInviteCategory])
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let content = UNMutableNotificationContent()
                content.title = noti.title
        content.body = ""
        content.userInfo = ["ID" : noti.id]
        content.categoryIdentifier = "FEELS"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request)
                print(request)
            }
    }
   
}
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
extension Noti: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
           didReceive response: UNNotificationResponse,
           withCompletionHandler completionHandler:
             @escaping () -> Void) {
           
       // Get the meeting ID from the original notification.
       let userInfo = response.notification.request.content.userInfo
       let id = userInfo["ID"] as! String
     
            print(response.actionIdentifier)
       // Perform the task associated with the action.
        contextualize(for: response.actionIdentifier, with: self.noti.first(where: { noti in
            return noti.id == id
        }) ?? NotiData())
        
       // Always call the completion handler when done.
       completionHandler()
    }
}

enum Feel: Int, Codable {
    case Not_At_All = 1
    case A_Little_Bit = 2
    case Somewhat = 3
    case Very_Much = 4
    case Exteremly = 5
}

struct NotiData: Codable, Identifiable {
    var id: String = UUID().uuidString
    var ratings: [Rating] = []
    var title: String = "How happy are you currently?"
    var ratingCategories: [RatingCategory] = [RatingCategory(title: "Not at all", value: 1), RatingCategory(title: "A little bit", value: 2), RatingCategory(title: "Somewhat", value: 3), RatingCategory(title: "Very much", value: 4), RatingCategory(title: "Extremely", value: 5) ]
    var hourIncrement = 0
    var from = Date()
    var to = Date()
}
struct Rating: Codable, Identifiable {
    var id: String = UUID().uuidString
    var category: String = ""
    var rating: Int
    var date: String = Date().formatted(date: .numeric, time: .shortened)
}

struct RatingCategory: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: Int
}
