//
//  Constants.swift
//  Keep Pace
//
//  Created by Fong Lor on 11/20/16.
//  Copyright © 2016 Capstone. All rights reserved.
//

import Foundation

struct K {
    
    struct Speed {
        static let slow = "Slow"
        static let medium = "Medium"
        static let fast = "Fast"
    }
    
    struct DefaultKey {
        static let speed = "speed"
    }
    
    struct SegueID {
        static let showSongList = "showSongList"
        static let showSong = "showSong"
    }
    
    struct BeatsPerMinuteRange {
        static let slowRange: ClosedRange<Int> = 0...100
        static let mediumRange: ClosedRange<Int> = 101...135
        static let fastRange: ClosedRange<Int> = 136...Int.max
    }
    
    struct ReuseID {
        static let cell = "cell"
    }
}
