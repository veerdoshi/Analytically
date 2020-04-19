import UIKit
import CalendarKit
import DateToolsSwift

enum SelectedStyle {
  case Dark
}

var hometicker : Int = 0

class CalendarViewController: DayViewController, DatePickerControllerDelegate {

  var data = [["Appointment with Jack Clinsworth",
               "Johnson Building, Room 34B"],

              ["Meeting with Dr. Hansbury",
               "Lynch Building"],

              ["Meeting with Alex Kinney",
               "Johnson Building, Room 39A",
               "(Addressing billing information)"],

              ["Appointment with Jerry Saunders",
               "Room 101",
               "Regular Checkup"],

              ["Call with Janet Kliffburg",
               "(408) 124-2451",
               "(Addressing symptoms)"],

              ["Meeting with Nathan Shaw",
               "Lynch Building"],

              ["Meeting with Dr. Patronelli",
               "Radiology Research"],

              ["Call with John Griswold",
               "(510) 525-1274"],

              ["Lecture on ICU developments",
               "Johnson Building, Theatre"]

              ]

  var colors = [UIColor.init(red: 0, green: 185/255, blue: 1, alpha: 1),
                UIColor.init(red: 0.8470588, green: 0.0117647, blue: 0.4039215686, alpha: 1),
                UIColor.init(red: 1, green: 193/255, blue: 0, alpha: 1),
                UIColor.init(red: 0, green: 1, blue: 185/255, alpha: 1)]

  var currentStyle = SelectedStyle.Dark
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Calendar"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dark",
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(CalendarViewController.changeStyle))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Change Date",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(CalendarViewController.presentDatePicker))
    navigationController?.navigationBar.isTranslucent = false
    currentStyle = .Dark
    var style: CalendarStyle!
    style = StyleGenerator.darkStyle()
    updateStyle(style)
  }

  @objc func changeStyle() {
    var title: String!
    var style: CalendarStyle!

    currentStyle = .Dark
    title = "Dark"
    style = StyleGenerator.defaultStyle()

    updateStyle(style)
    navigationItem.rightBarButtonItem!.title = title
    navigationController?.navigationBar.barTintColor = style.header.backgroundColor
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:style.header.swipeLabel.textColor]
    reloadData()
  }

  @objc func presentDatePicker() {
    let picker = DatePickerController()
    picker.date = dayView.state!.selectedDate
    picker.delegate = self
    let navC = UINavigationController(rootViewController: picker)
    navigationController?.present(navC, animated: true, completion: nil)
  }

  func datePicker(controller: DatePickerController, didSelect date: Date?) {
    if let date = date {
      dayView.state?.move(to: date)
    }
    controller.dismiss(animated: true, completion: nil)
  }

  // MARK: EventDataSource
  override func eventsForDate(_ date: Date) -> [EventDescriptor] {
    var date = date.add(TimeChunk.dateComponents(hours: Int(arc4random_uniform(10) + 5)))
    var events = [Event]()

    for i in 0...4 {
      let event = Event()
      let duration = Int(arc4random_uniform(160) + 60)
      let datePeriod = TimePeriod(beginning: date,
                                  chunk: TimeChunk.dateComponents(minutes: duration))

      event.startDate = datePeriod.beginning!
      event.endDate = datePeriod.end!

      var info = data[Int(arc4random_uniform(UInt32(data.count)))]
      
      let timezone = TimeZone.ReferenceType.default
      info.append(datePeriod.beginning!.format(with: "dd.MM.YYYY", timeZone: timezone))
      info.append("\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))")
      event.text = info.reduce("", {$0 + $1 + "\n"})
      event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
      event.isAllDay = Int(arc4random_uniform(2)) % 2 == 0
      
      // Event styles are updated independently from CalendarStyle
      // hence the need to specify exact colors in case of Dark style
        event.textColor = textColorForEventInDarkTheme(baseColor: event.color)
        event.backgroundColor = event.color.withAlphaComponent(0.6)
  
      
      events.append(event)

      let nextOffset = Int(arc4random_uniform(250) + 40)
      date = date.add(TimeChunk.dateComponents(minutes: nextOffset))
      event.userInfo = String(i)
    }

    return events
  }
  
  private func textColorForEventInDarkTheme(baseColor: UIColor) -> UIColor {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    baseColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return UIColor(hue: h, saturation: s * 0.3, brightness: b, alpha: a)
  }

  // MARK: DayViewDelegate
  override func dayViewDidSelectEventView(_ eventView: EventView) {
    guard let descriptor = eventView.descriptor as? Event else {
      return
    }
    print("Event has been selected: \(descriptor) \(String(describing: descriptor.userInfo))")
    self.performSegue(withIdentifier: "calendarToOverview", sender: self)
  }

  override func dayViewDidLongPressEventView(_ eventView: EventView) {
    guard let descriptor = eventView.descriptor as? Event else {
      return
    }
    //print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
    print("Event has been longPressed: \(String(describing: descriptor.userInfo))")
    self.performSegue(withIdentifier: "calendarToPatient", sender: self)
  }

  override func dayView(dayView: DayView, willMoveTo date: Date) {
    print("DayView = \(dayView) will move to: \(date)")
  }
  
  override func dayView(dayView: DayView, didMoveTo date: Date) {
    print("DayView = \(dayView) did move to: \(date)")
  }

  override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
    print("Did long press timeline at date \(date)")
    self.performSegue(withIdentifier: "calendarToOrder", sender: self)
    
  }
}
