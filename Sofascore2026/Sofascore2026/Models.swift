//
//  Models.swift
//  Sofascore2026
//
//  Created by akademija on 14.03.2026..
//

import SofaAcademic

    struct Sport {
        public let name: String
        public let icon: String

        init(name: String, icon: String) {
            self.name = name
            self.icon = icon
        }
    }

struct EventData {
    public let league: League
    
}
