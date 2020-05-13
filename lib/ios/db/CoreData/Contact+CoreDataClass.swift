//
//  Contact+CoreDataClass.swift
//  rn-contact-tracing
//
//  Created by Yonatan Rimon on 13/05/2020.
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: CoreDataCodable
{
    // *** coreData *** //
    enum CodingKeys: Any, CodingKey {
        case ephemeral_id
        case geohash
        case id
        case rssi
        case timestamp
    }
    
    // MARK: - Encodable
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(EphID, forKey: .ephemeral_id)
        try container.encode(location, forKey: .geohash)
        try container.encode(conatctId, forKey: .id)
        try container.encode(RSSI, forKey: .rssi)
        try container.encode(time, forKey: .timestamp)
    }
    
    // *** Class *** //
    var conatctId = 0
    var EphID: [UInt8] = []
    var RSSI: Int = 0
    var time: Int = 0
    var location: [UInt8] = []

    public func setContactData(ephemeral_id: [UInt8], rssi: Int, time: Int, location: [UInt8])
    {

        //A contact which was sent the user a BLE message.
        //
        //:param ephemeral_id:    The contact ephemeral id.
        //:param rssi:            Good question. my name contains covid but I don't know everything(covid6Pi).
        //:param time:            Time of contact as recorded by the receiving user.
        //:param location:        Location of user contact when BLE message received.

        // TODO: ASSERT
//        XCTAssert(ephemeral_id.count == const_MESSAGE_LEN);
//        super.init()
        self.EphID = ephemeral_id
        self.RSSI = rssi
        self.time = time
        self.location = location
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool
    {
        return  lhs.EphID == rhs.EphID &&
        //self.RSSI == other.RSSI && //// can't compare 2 "Any" without knowing the type...
        lhs.time == rhs.time &&
        lhs.location == rhs.location;
    }
}