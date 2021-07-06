//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem, Equatable {
    let id: Int
    let title: String
    let description: String
    let priceStr: String?
    let imageUrl: String?
    let currencySymbol: String?
    
}

func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return
        lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.priceStr == rhs.priceStr
        && lhs.imageUrl == rhs.imageUrl
        && lhs.currencySymbol == rhs.currencySymbol
}
