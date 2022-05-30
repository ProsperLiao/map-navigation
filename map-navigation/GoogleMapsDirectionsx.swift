//
//  GoogleMapsDirections.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/30.
//
//  Referenced from https://github.com/honghaoz/Swift-Google-Maps-API
/*
import Foundation
import Alamofire
import CoreLocation
import Keys
import ObjectMapper

// Documentations: https://developers.google.com/maps/documentation/directions/

enum TravelMode: String {
    case driving    =   "DRIVING"
    case bicycling  =   "BICYCLING"
    case transit    =   "TRANSIT"
    case walking    =   "WALKING"
}

class GoogleMapsDirections {
    static let baseURLString = "https://maps.googleapis.com/maps/api/directions/json"
    
    // Request to Google Directions API
    class func direction(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, travelMode: TravelMode = .walking, completion: ((_ response: NSData?, _ error: NSError?) -> Void)? = nil) {
        
        let keys = MapNavigationKeys()
        
        let requestParameters: [String : Any] = [
            "origin" : "\(origin.latitude),\(origin.longitude)",
            "destination" : "\(destination.latitude),\(destination.longitude)",
            "mode" : travelMode.rawValue.lowercased(),
            "key" : "\(keys.googleMapsAPIKey)"
        ]
        
        let utilityQueue = DispatchQueue.global(qos: .utility)
        
        
        AF.request(baseURLString, method: .get, parameters: requestParameters).responseJSON { response in
            debugPrint(response)
            
            let json = response.result as! NSDictionary
            let routes = json["routes"] as! NSArray
            
            for route in routes
            {
                let values = route as! NSDictionary
                
                let routeOverviewPolyline = values["overview_polyline"] as! NSDictionary
                let points = routeOverviewPolyline["points"] as! String
//                let path = GMSPath.init(fromEncodedPath: points)
//
//                let polyline = GMSPolyline(path: path)
//                polyline.strokeColor = .black
//                polyline.strokeWidth = 2.0
//                polyline.map = self.mapView //where mapView is your @IBOutlet which is in GMSMapView!
//
                
            }
            
            
            
//            print(response.request as Any)  // original URL request
//            print(response.response as Any) // HTTP URL response
//            print(response.data as Any)     // server data
//            print(response.result as Any)   // result of response serialization
//            do{
//                let json = try JSON(data: response.data!)
//                let routes = json["routes"].arrayValue
//
//                // print route using Polyline
//                for route in routes{
//                    let routeOverviewPolyline = route["overview_polyline"].dictionary
//                    let points = routeOverviewPolyline?["points"]?.stringValue
//                    let path = GMSPath.init(fromEncodedPath: points!)
//                    let polyline = GMSPolyline.init(path: path)
//                    polyline.strokeWidth = 4
//                    polyline.strokeColor = UIColor.blue
//                    polyline.map = self.mapView
//                }
//            }catch let error {
//                print(error.localizedDescription)
//                               }
        }
    }
}
        
   /*
        AF.request(baseURLString, method: .get, parameters: requestParameters, encoding: JSONEncoding.default).responseDecodable(of: GoogleMapsDirections.Response.self, queue: utilityQueue) { response in
            print("This closure is executed on utilityQueue.")
            debugPrint(response)
            //                    if response.result.isFailure {
            //                        NSLog("Error: GET failed")
            //                        completion?(nil, NSError(domain: "GoogleMapsDirectionsError", code: -1, userInfo: nil))
            //                        return
            //                    }
            //
            //                    // Nil
            //                    if let _ = response.result.value as? NSNull {
            //                        completion?(Response(), nil)
            //                        return
            //                    }
            //
            //                    // JSON
            //                    guard let json = response.result.value as? [String : AnyObject] else {
            //                        NSLog("Error: Parsing json failed")
            //                        completion?(nil, NSError(domain: "GoogleMapsDirectionsError", code: -2, userInfo: nil))
            //                        return
            //                    }
            //
            //                    guard let directionsResponse = Mapper<Response>().map(JSON: json) else {
            //                        NSLog("Error: Mapping directions response failed")
            //                        completion?(nil, NSError(domain: "GoogleMapsDirectionsError", code: -3, userInfo: nil))
            //                        return
            //                    }
            //
            //                    var error: NSError?
            //
            //                    switch directionsResponse.status {
            //                    case .none:
            //                        let userInfo = [
            //                            NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "Status Code not found", comment: ""),
            //                            NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: "Status Code not found", comment: "")
            //                        ]
            //                        error = NSError(domain: "GoogleMapsDirectionsError", code: -4, userInfo: userInfo)
            //                                    case .some(let status):
            //                                        switch status {
            //                                        case .ok:
            //                                            break
            //                                        case .notFound:
            //                                            let userInfo = [
            //                                                NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "At least one of the locations specified in the request's origin, destination, or waypoints could not be geocoded.", comment: ""),
            //                                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                            ]
            //                                            error = NSError(domain: "GoogleMapsDirectionsError", code: -5, userInfo: userInfo)
            //                                        case .zeroResults:
            //                                            let userInfo = [
            //                                                NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "No route could be found between the origin and destination.", comment: ""),
            //                                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                            ]
            //                                            error = NSError(domain: "GoogleMapsDirectionsError", code: -6, userInfo: userInfo)
            //                                        case .maxWaypointsExceeded:
            //                                            let userInfo = [
            //                                                NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "Too many waypoints were provided in the request. The maximum allowed number of waypoints is 23, plus the origin and destination. (If the request does not include an API key, the maximum allowed number of waypoints is 8.", comment: ""),
            //                                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                            ]
            //                                            error = NSError(domain: "GoogleMapsDirectionsError", code: -7, userInfo: userInfo)
            //                                        case .invalidRequest:
            //                                            let userInfo = [
            //                                                NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "Provided request was invalid. Common causes of this status include an invalid parameter or parameter value.", comment: ""),
            //                                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                            ]
            //                                            error = NSError(domain: "GoogleMapsDirectionsError", code: -8, userInfo: userInfo)
            //                                        case .overQueryLimit:
            //                                            let userInfo = [
            //                                                NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "Service has received too many requests from your application within the allowed time period.", comment: ""),
            //                                                NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                            ]
            //                                            error = NSError(domain: "GoogleMapsDirectionsError", code: -9, userInfo: userInfo)
            //                                                           case .requestDenied:
            //                                                               let userInfo = [
            //                                                                   NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "Service denied use of the directions service by your application.", comment: ""),
            //                                                                   NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                                               ]
            //                                                               error = NSError(domain: "GoogleMapsDirectionsError", code: -10, userInfo: userInfo)
            //                                                           case .unknownError:
            //                                                               let userInfo = [
            //                                                                   NSLocalizedDescriptionKey : NSLocalizedString("StatusCodeError", value: "A directions request could not be processed due to a server error. The request may succeed if you try again.", comment: ""),
            //                                                                   NSLocalizedFailureReasonErrorKey : NSLocalizedString("StatusCodeError", value: directionsResponse.errorMessage ?? "", comment: "")
            //                                                               ]
            //                                                               error = NSError(domain: "GoogleMapsDirectionsError", code: -11, userInfo: userInfo)
            //                                                           }
            //                                                       }
            //
            //                                                       completion?(directionsResponse, error)
            //
        }
    }
}


extension GoogleMapsDirections {
    enum TravelMode: String {
        case driving    =   "DRIVING"
        case bicycling  =   "BICYCLING"
        case transit    =   "TRANSIT"
        case walking    =   "WALKING"
    }
    
    /// The status field within the Directions response object contains the status of the request,
    /// and may contain debugging information to help you track down why the Directions service failed.
    /// Reference: https://developers.google.com/maps/documentation/directions/intro#StatusCodes
    ///
    /// - ok:                   The response contains a valid result.
    /// - notFound:             At least one of the locations specified in the request's origin, destination, or waypoints could not be geocoded.
    /// - zeroResults:          No route could be found between the origin and destination.
    /// - maxWaypointsExceeded: Too many waypoints were provided in the request.
    /// - invalidRequest:       The provided request was invalid.
    /// - overQueryLimit:       The service has received too many requests from your application within the allowed time period.
    /// - requestDenied:        The service denied use of the directions service by your application.
    /// - unknownError:         Directions request could not be processed due to a server error.
    public enum StatusCode: String {
        case ok = "OK"
        case notFound = "NOT_FOUND"
        case zeroResults = "ZERO_RESULTS"
        case maxWaypointsExceeded = "MAX_WAYPOINTS_EXCEEDED"
        case invalidRequest = "INVALID_REQUEST"
        case overQueryLimit = "OVER_QUERY_LIMIT"
        case requestDenied = "REQUEST_DENIED"
        case unknownError = "UNKNOWN_ERROR"
    }
    
    public typealias LocationDegrees = Double
    public struct LocationCoordinate2D {
        public var latitude: LocationDegrees
        public var longitude: LocationDegrees
        
        public init(latitude: LocationDegrees, longitude: LocationDegrees) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    /**
     *  GeocodedWaypoint
     */
    public struct GeocodedWaypoint: Mappable {
        public var geocoderStatus: GeocoderStatus?
        public var partialMatch: Bool = false
        public var placeID: String?
        public var types: [AddressType] = []
        
        public init?(map: Map) { }
        
        public mutating func mapping(map: Map) {
            geocoderStatus <- (map["geocoder_status"], EnumTransform())
            partialMatch <- map["geocoded_waypoints"]
            placeID <- map["place_id"]
            types <- (map["types"], EnumTransform())
        }
    }
    
    struct DirectionResponse {
        public struct Response: Mappable {
            public var status: StatusCode?
            public var errorMessage: String?
            
            public var geocodedWaypoints: [GeocodedWaypoint] = []
            public var routes: [Route] = []
            
            public init() {}
            public init?(map: Map) { }
            
            public mutating func mapping(map: Map) {
                status <- (map["status"], EnumTransform())
                errorMessage <- map["error_message"]
                
                geocodedWaypoints <- map["geocoded_waypoints"]
                routes <- map["routes"]
            }
            
            /**
             *  GeocodedWaypoint
             */
//            public struct GeocodedWaypoint: Mappable {
//                public var geocoderStatus: GeocoderStatus?
//                public var partialMatch: Bool = false
//                public var placeID: String?
//                public var types: [AddressType] = []
//
//                public init?(map: Map) { }
//
//                public mutating func mapping(map: Map) {
//                    geocoderStatus <- (map["geocoder_status"], EnumTransform())
//                    partialMatch <- map["geocoded_waypoints"]
//                    placeID <- map["place_id"]
//                    types <- (map["types"], EnumTransform())
//                }
//            }
            
            /**
             *  Route
             */
            public struct Route: Mappable {
                public var summary: String?
                public var legs: [Leg] = []
                public var waypointOrder: [Int] = []
                public var overviewPolylinePoints: String?
                public var bounds: Bounds?
                public var copyrights: String?
                public var warnings: [String] = []
                public var fare: Fare?
                
                public init?(map: Map) { }
                
                public mutating func mapping(map: Map) {
                    summary <- map["summary"]
                    legs <- map["legs"]
                    waypointOrder <- map["waypointOrder"]
                    overviewPolylinePoints <- map["overview_polyline.points"]
                    bounds <- map["bounds"]
                    copyrights <- map["copyrights"]
                    warnings <- map["warnings"]
                    fare <- map["fare"]
                }
                
                /**
                 *  Leg
                 */
                public struct Leg: Mappable {
                    public var steps: [Step] = []
                    public var distance: Step.Distance?
                    public var duration: Step.Duration?
                    public var durationInTraffic: DurationInTraffic?
                    public var arrivalTime: Time?
                    public var departureTime: Time?
                    public var startLocation: LocationCoordinate2D?
                    public var endLocation: LocationCoordinate2D?
                    public var startAddress: String?
                    public var endAddress: String?
                    
                    public init?(map: Map) { }
                    
                    public mutating func mapping(map: Map) {
                        steps <- map["steps"]
                        distance <- map["distance"]
                        duration <- map["duration"]
                        durationInTraffic <- map["duration_in_traffic"]
                        arrivalTime <- map["arrival_time"]
                        departureTime <- map["departure_time"]
                        startLocation <- (map["start_location"], LocationCoordinate2DTransform())
                        endLocation <- (map["end_location"], LocationCoordinate2DTransform())
                        startAddress <- map["start_address"]
                        endAddress <- map["end_address"]
                    }
                    
                    /**
                     *  Step
                     */
                    public struct Step: Mappable {
                        /// formatted instructions for this step, presented as an HTML text string.
                        public var htmlInstructions: String?
                        public var distance: Distance?
                        public var duration: Duration?
                        public var startLocation: LocationCoordinate2D?
                        public var endLocation: LocationCoordinate2D?
                        public var polylinePoints: String?
                        public var steps: [Step] = []
                        public var travelMode: TravelMode?
                        public var maneuver: String?
                        public var transitDetails: TransitDetails?
                        
                        public init?(map: Map) { }
                        
                        public mutating func mapping(map: Map) {
                            htmlInstructions <- map["html_instructions"]
                            distance <- map["distance"]
                            duration <- map["duration"]
                            startLocation <- (map["start_location"], LocationCoordinate2DTransform())
                            endLocation <- (map["end_location"], LocationCoordinate2DTransform())
                            polylinePoints <- map["polyline.points"]
                            steps <- map["steps"]
                            travelMode <- map["travel_mode"]
                            maneuver <- map["maneuver"]
                            transitDetails <- map["transit_details"]
                        }
                        
                        /**
                         *  Distance
                         */
                        public struct Distance: Mappable {
                            public var value: Int? // the distance in meters
                            public var text: String? // human-readable representation of the distance
                            
                            public init?(map: Map) { }
                            
                            public mutating func mapping(map: Map) {
                                value <- map["value"]
                                text <- map["text"]
                            }
                        }
                        
                        /**
                         *  Duration
                         */
                        public struct Duration: Mappable {
                            public var value: Int? // the duration in seconds.
                            public var text: String? // human-readable representation of the duration.
                            
                            public init?(map: Map) { }
                            
                            public mutating func mapping(map: Map) {
                                value <- map["value"]
                                text <- map["text"]
                            }
                        }
                        
                        /**
                         *  TransitDetails
                         */
//                        public struct TransitDetails: Mappable {
//                            public var arrivalStop: Stop?
//                            public var departureStop: Stop?
//                            public var arrivalTime: Time?
//                            public var departureTime: Time?
//                            public var headsign: String?
//                            public var headway: Int?
//                            public var numStops: Int?
//                            public var line: TransitLine?
//
//                            public init?(map: Map) { }
//
//                            public mutating func mapping(map: Map) {
//                                arrivalStop <- map["arrival_stop"]
//                                departureStop <- map["departure_stop"]
//                                arrivalTime <- map["arrival_time"]
//                                departureTime <- map["departure_time"]
//                                headsign <- map["headsign"]
//                                headway <- map["headway"]
//                                numStops <- map["num_stops"]
//                                line <- map["line"]
//                            }
//
//                            /**
//                             *  Stop
//                             */
//                            public struct Stop: Mappable {
//                                public var location: LocationCoordinate2D?
//                                public var name: String?
//
//                                public init?(map: Map) { }
//
//                                public mutating func mapping(map: Map) {
//                                    location <- (map["location"], LocationCoordinate2DTransform())
//                                    name <- map["name"]
//                                }
//                            }
//
//                            /**
//                             *  TransitLine
//                             */
////                            public struct TransitLine: Mappable {
////                                public var name: String?
////                                public var shortName: String?
////                                public var color: Color?
////                                public var agencies: [TransitAgency] = []
////                                public var url: URL?
////                                public var icon: URL?
////                                public var textColor: Color?
////                                public var vehicle: [TransitLineVehicle] = []
////
////                                public init?(map: Map) { }
////
////                                public mutating func mapping(map: Map) {
////                                    name <- map["name"]
////                                    shortName <- map["short_name"]
////                                    color <- (map["color"], colorTransform())
////                                    agencies <- map["agencies"]
////                                    url <- (map["url"], URLTransform())
////                                    icon <- (map["icon"], URLTransform())
////                                    textColor <- (map["text_color"], colorTransform())
////                                    vehicle <- map["vehicle"]
////                                }
////
//////                                fileprivate func colorTransform() -> TransformOf<Color, String> {
//////                                    return TransformOf<Color, String>(fromJSON: { (value: String?) -> Color? in
//////                                        if let value = value {
//////                                            return Color(hexString: value)
//////                                        }
//////                                        return nil
//////                                    }, toJSON: { (value: Color?) -> String? in
//////                                        if let value = value {
//////                                            return value.hexString
//////                                        }
//////                                        return nil
//////                                    })
//////                                }
////
////                                /**
////                                 *  TransitAgency
////                                 */
////                                public struct TransitAgency: Mappable {
////                                    public var name: String?
////                                    public var phone: String?
////                                    public var url: URL?
////
////                                    public init?(map: Map) { }
////
////                                    public mutating func mapping(map: Map) {
////                                        name <- map["name"]
////                                        phone <- map["phone"]
////                                        url <- (map["url"], URLTransform())
////                                    }
////                                }
////
////                                /**
////                                 *  TransitLineVehicle
////                                 */
//////                                public struct TransitLineVehicle: Mappable {
//////                                    public var name: String?
//////                                    public var type: VehicleType?
//////                                    public var icon: URL?
//////
//////                                    public init?(map: Map) { }
//////
//////                                    public mutating func mapping(map: Map) {
//////                                        name <- map["name"]
//////                                        type <- (map["type"], EnumTransform())
//////                                        icon <- (map["icon"], URLTransform())
//////                                    }
//////                                }
////                            }
//                        }
                    }
                    
                    /**
                     *  DurationInTraffic
                     */
                    public struct DurationInTraffic: Mappable {
                        public var value: Int? // the duration in seconds.
                        public var text: String? // human-readable representation of the duration.
                        
                        public init?(map: Map) { }
                        
                        public mutating func mapping(map: Map) {
                            value <- map["value"]
                            text <- map["text"]
                        }
                    }
                    
                    /**
                     *  Time
                     */
//                    public struct Time: Mappable {
//                        public var value: Date? // the time specified as a JavaScript Date object.
//                        public var text: String? // the time specified as a string.
//                        public var timeZone: TimeZone? // the time zone of this station. The value is the name of the time zone as defined in the IANA Time Zone Database, e.g. "America/New_York".
//
//                        public init?(map: Map) { }
//
//                        public mutating func mapping(map: Map) {
//                            value <- (map["value"], DateTransformInteger())
//                            text <- map["text"]
//                            timeZone <- (map["time_zone"], timeZoneTransform())
//                        }
//
//                        fileprivate func timeZoneTransform() -> TransformOf<TimeZone, String> {
//                            return TransformOf<TimeZone, String>(fromJSON: { (value: String?) -> TimeZone? in
//                                if let value = value {
//                                    return TimeZone(identifier: value)
//                                }
//                                return nil
//                            }, toJSON: { (value: TimeZone?) -> String? in
//                                if let value = value {
//                                    return value.identifier
//                                }
//                                return nil
//                            })
//                        }
//                    }
                }
                
                /**
                 *  Bounds
                 */
                public struct Bounds: Mappable {
                    public var northeast: LocationCoordinate2D?
                    public var southwest: LocationCoordinate2D?
                    
                    public init?(map: Map) { }
                    
                    public mutating func mapping(map: Map) {
                        northeast <- (map["northeast"], LocationCoordinate2DTransform())
                        southwest <- (map["southwest"], LocationCoordinate2DTransform())
                    }
                }
                
                /**
                 *  Fare
                 */
                public struct Fare: Mappable {
                    public var currency: String?
                    public var value: Float?
                    public var text: String?
                    
                    public init?(map: Map) { }
                    
                    public mutating func mapping(map: Map) {
                        currency <- map["currency"]
                        value <- map["value"]
                        text <- map["text"]
                    }
                }
            }
        }
    }
    
    
    class LocationCoordinate2DTransform: TransformType {
        typealias Object = LocationCoordinate2D
        typealias JSON = [String : Any]
        
        func transformFromJSON(_ value: Any?) -> Object? {
            if let value = value as? JSON {
                guard let latitude = value["lat"] as? Double, let longitude = value["lng"] as? Double else {
                    NSLog("Error: lat/lng is not Double")
                    return nil
                }
                
                return LocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
            return nil
        }
        
        func transformToJSON(_ value: Object?) -> JSON? {
            if let value = value {
                return [
                    "lat" : "\(value.latitude)",
                    "lng" : "\(value.longitude)"
                ]
            }
            return nil
        }
    }
}
*/
*/
