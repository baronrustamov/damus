@_private(sourceFile: "ContentView.swift") import damus
import Starscream
import SwiftUI
import SwiftUI

@_dynamicReplacement(for: timeline_name(_:)) private func __preview__timeline_name(_ timeline: Timeline?) -> String {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 831)
    guard let timeline else {
        return ""
    }
    switch timeline {
    case .home:
        return __designTimeString("#6558.[20].[1].[0].[0]", fallback: "Home")
    case .notifications:
        return __designTimeString("#6558.[20].[1].[1].[0]", fallback: "Notifications")
    case .search:
        return __designTimeString("#6558.[20].[1].[2].[0]", fallback: "Universe 🛸")
    case .dms:
        return __designTimeString("#6558.[20].[1].[3].[0]", fallback: "DMs")
    }

#sourceLocation()
}

@_dynamicReplacement(for: find_event(state:evid:search_type:find_from:callback:)) private func __preview__find_event(state: DamusState, evid: String, search_type: SearchType, find_from: [String]?, callback: @escaping (NostrEvent?) -> ()) {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 782)
    if let ev = state.events.lookup(evid) {
        callback(ev)
        return
    }
    
    let subid = UUID().description
    
    var has_event = __designTimeBoolean("#6558.[19].[2].value", fallback: false)
    
    var filter = search_type == .event ? NostrFilter.filter_ids([ evid ]) : NostrFilter.filter_authors([ evid ])
    
    if search_type == .profile {
        filter.kinds = [__designTimeInteger("#6558.[19].[4].[0].[0].[0]", fallback: 0)]
    }
    
    filter.limit = __designTimeInteger("#6558.[19].[5].[0]", fallback: 1)
    var attempts = __designTimeInteger("#6558.[19].[6].value", fallback: 0)
    
    state.pool.subscribe_to(sub_id: subid, filters: [filter], to: find_from) { relay_id, res  in
        guard case .nostr_event(let ev) = res else {
            return
        }
        
        guard ev.subid == subid else {
            return
        }
        
        switch ev {
        case .event(_, let ev):
            has_event = true
            callback(ev)
            state.pool.unsubscribe(sub_id: subid)
        case .eose:
            if !has_event {
                attempts += __designTimeInteger("#6558.[19].[7].modifier[0].arg[3].value.[2].[1].[0].[0].[0].[0]", fallback: 1)
                if attempts == state.pool.descriptors.count / 2 {
                    callback(nil)
                }
                state.pool.unsubscribe(sub_id: subid, to: [relay_id])
            }
        case .notice(_):
            break
        }

    }

#sourceLocation()
}

@_dynamicReplacement(for: setup_notifications()) private func __preview__setup_notifications() {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 765)
    
    UIApplication.shared.registerForRemoteNotifications()
    let center = UNUserNotificationCenter.current()
    
    center.getNotificationSettings { settings in
        guard settings.authorizationStatus == .authorized else {
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                
            }
            
            return
        }
    }

#sourceLocation()
}

@_dynamicReplacement(for: update_filters_with_since(last_of_kind:filters:)) private func __preview__update_filters_with_since(last_of_kind: [Int: NostrEvent], filters: [NostrFilter]) -> [NostrFilter] {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 730)
    
    return filters.map { filter in
        let kinds = filter.kinds ?? []
        let initial: Int64? = nil
        let earliest = kinds.reduce(initial) { earliest, kind in
            let last = last_of_kind[kind]
            let since: Int64? = get_since_time(last_event: last)
            
            if earliest == nil {
                if since == nil {
                    return nil
                }
                return since
            }
            
            if since == nil {
                return earliest
            }
            
            return since! < earliest! ? since! : earliest!
        }
        
        if let earliest = earliest {
            var with_since = NostrFilter.copy(from: filter)
            with_since.since = earliest
            return with_since
        }
        
        return filter
    }

#sourceLocation()
}

@_dynamicReplacement(for: get_like_pow()) private func __preview__get_like_pow() -> [String] {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 725)
    return [__designTimeString("#6558.[16].[0].[0]", fallback: "00000")] // 20 bits

#sourceLocation()
}

@_dynamicReplacement(for: save_last_event(_:timeline:)) private func __preview__save_last_event(_ ev: NostrEvent, timeline: Timeline) {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 718)
    let str = timeline.rawValue
    UserDefaults.standard.set(ev.id, forKey: "last_\(str)")
    UserDefaults.standard.set(String(ev.created_at), forKey: "last_\(str)_time")

#sourceLocation()
}

@_dynamicReplacement(for: get_last_event(_:)) private func __preview__get_last_event(_ timeline: Timeline) -> LastNotification? {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 705)
    let str = timeline.rawValue
    let last = UserDefaults.standard.string(forKey: "last_\(str)")
    let last_created = UserDefaults.standard.string(forKey: "last_\(str)_time")
        .flatMap { Int64($0) }
    
    return last.flatMap { id in
        last_created.map { created in
            return LastNotification(id: id, created_at: created)
        }
    }

#sourceLocation()
}

extension UINavigationController {
    @_dynamicReplacement(for: gestureRecognizerShouldBegin(_:)) private func __preview__gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 695)
        return viewControllers.count > __designTimeInteger("#6558.[12].[1].[0].[0]", fallback: 1)
    
#sourceLocation()
    }
}

extension UINavigationController {
    @_dynamicReplacement(for: viewDidLoad()) private func __preview__viewDidLoad() {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 690)
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    
#sourceLocation()
    }
}

@_dynamicReplacement(for: is_notification(ev:pubkey:)) private func __preview__is_notification(ev: NostrEvent, pubkey: String) -> Bool {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 681)
    if ev.pubkey == pubkey {
        return __designTimeBoolean("#6558.[11].[0].[0].[0]", fallback: false)
    }
    return ev.references(id: pubkey, key: __designTimeString("#6558.[11].[1].modifier[0].arg[1].value", fallback: "p"))

#sourceLocation()
}

@_dynamicReplacement(for: ws_nostr_event(relay:ev:)) private func __preview__ws_nostr_event(relay: String, ev: WebSocketEvent) -> NostrEvent? {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 656)
    switch ev {
    case .binary(let dat):
        return NostrEvent(content: "binary data? \(dat.count) bytes", pubkey: relay)
    case .cancelled:
        return NostrEvent(content: __designTimeString("#6558.[10].[0].[1].[0].arg[0].value", fallback: "cancelled"), pubkey: relay)
    case .connected:
        return NostrEvent(content: __designTimeString("#6558.[10].[0].[2].[0].arg[0].value", fallback: "connected"), pubkey: relay)
    case .disconnected:
        return NostrEvent(content: __designTimeString("#6558.[10].[0].[3].[0].arg[0].value", fallback: "disconnected"), pubkey: relay)
    case .error(let err):
        return NostrEvent(content: "error \(err.debugDescription)", pubkey: relay)
    case .text(let txt):
        return NostrEvent(content: "text \(txt)", pubkey: relay)
    case .pong:
        return NostrEvent(content: __designTimeString("#6558.[10].[0].[6].[0].arg[0].value", fallback: "pong"), pubkey: relay)
    case .ping:
        return NostrEvent(content: __designTimeString("#6558.[10].[0].[7].[0].arg[0].value", fallback: "ping"), pubkey: relay)
    case .viabilityChanged(let b):
        return NostrEvent(content: "viabilityChanged \(b)", pubkey: relay)
    case .reconnectSuggested(let b):
        return NostrEvent(content: "reconnectSuggested \(b)", pubkey: relay)
    }

#sourceLocation()
}

@_dynamicReplacement(for: get_since_time(last_event:)) private func __preview__get_since_time(last_event: NostrEvent?) -> Int64? {
#sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 648)
    if let last_event = last_event {
        return last_event.created_at - __designTimeInteger("#6558.[9].[0].[0].[0].[0]", fallback: 60) * __designTimeInteger("#6558.[9].[0].[0].[0].[1]", fallback: 10)
    }
    
    return nil

#sourceLocation()
}

extension ContentView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 643)
        ContentView(keypair: Keypair(pubkey: __designTimeString("#6558.[8].[0].property.[0].[0].arg[0].value.arg[0].value", fallback: "3efdaebb1d8923ebd99c9e7ace3b4194ab45512e2be79c1b7d68d9243e0d2681"), privkey: nil))
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: connect()) private func __preview__connect() {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 602)
        let pool = RelayPool()
        let metadatas = RelayMetadatas()
        let relay_filters = RelayFilters(our_pubkey: pubkey)
        
        let new_relay_filters = load_relay_filters(pubkey) == nil
        for relay in BOOTSTRAP_RELAYS {
            if let url = URL(string: relay) {
                add_new_relay(relay_filters: relay_filters, metadatas: metadatas, pool: pool, url: url, info: .rw, new_relay_filters: new_relay_filters)
            }
        }
        
        pool.register_handler(sub_id: sub_id, handler: home.handle_event)

        self.damus_state = DamusState(pool: pool,
                                      keypair: keypair,
                                      likes: EventCounter(our_pubkey: pubkey),
                                      boosts: EventCounter(our_pubkey: pubkey),
                                      contacts: Contacts(our_pubkey: pubkey),
                                      tips: TipCounter(our_pubkey: pubkey),
                                      profiles: Profiles(),
                                      dms: home.dms,
                                      previews: PreviewCache(),
                                      zaps: Zaps(our_pubkey: pubkey),
                                      lnurls: LNUrls(),
                                      settings: UserSettingsStore(),
                                      relay_filters: relay_filters,
                                      relay_metadata: metadatas,
                                      drafts: Drafts(),
                                      events: EventCache(),
                                      bookmarks: BookmarksManager(pubkey: pubkey)
        )
        home.damus_state = self.damus_state!
        
        pool.connect()
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: add_relay(_:_:)) private func __preview__add_relay(_ pool: RelayPool, _ relay: String) {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 591)
        //add_rw_relay(pool, "wss://nostr-pub.wellorder.net")
        add_rw_relay(pool, relay)
        /*
        let profile = Profile(name: relay, about: nil, picture: nil)
        let ts = Int64(Date().timeIntervalSince1970)
        let tsprofile = TimestampedProfile(profile: profile, timestamp: ts)
        damus!.profiles.add(id: relay, profile: tsprofile)
         */
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: switch_timeline(_:)) private func __preview__switch_timeline(_ timeline: Timeline) {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 577)
        self.popToRoot()
        NotificationCenter.default.post(name: .switched_timeline, object: timeline)
        
        if timeline == self.selected_timeline {
            NotificationCenter.default.post(name: .scroll_to_top, object: nil)
            return
        }
        
        self.selected_timeline = timeline
        //NotificationCenter.default.post(name: .switched_timeline, object: timeline)
        //self.selected_timeline = timeline
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 265)
        VStack(alignment: .leading, spacing: __designTimeInteger("#6558.[7].[36].property.[0].[0].arg[1].value", fallback: 0)) {
            if let damus = self.damus_state {
                NavigationView {
                    TabView { // Prevents navbar appearance change on scroll
                        MainContent(damus: damus)
                            .toolbar() {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        isSideBarOpened.toggle()
                                    } label: {
                                        ProfilePicView(pubkey: damus_state!.pubkey, size: __designTimeInteger("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[0].arg[1].value.[0].arg[1].value.[0].arg[1].value", fallback: 32), highlight: .none, profiles: damus_state!.profiles)
                                            .opacity(isSideBarOpened ? __designTimeInteger("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[0].arg[1].value.[0].arg[1].value.[0].modifier[0].arg[0].value.then", fallback: 0) : __designTimeInteger("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[0].arg[1].value.[0].arg[1].value.[0].modifier[0].arg[0].value.else", fallback: 1))
                                            .animation(isSideBarOpened ? .none : .default, value: isSideBarOpened)
                                    }
                                    .disabled(isSideBarOpened)
                                }
                                
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    HStack(alignment: .center) {
                                        if home.signal.signal != home.signal.max_signal {
                                            NavigationLink(destination: RelayConfigView(state: damus_state!)) {
                                                Text("\(home.signal.signal)/\(home.signal.max_signal)", comment: __designTimeString("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[1].arg[1].value.[0].arg[1].value.[0].[0].[0].arg[1].value.[0].arg[1].value", fallback: "Fraction of how many of the user's relay servers that are operational."))
                                                    .font(.callout)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        
                                        // maybe expand this to other timelines in the future
                                        if selected_timeline == .search {
                                            Button(action: {
                                                //isFilterVisible.toggle()
                                                self.active_sheet = .filter
                                            }) {
                                                // checklist, checklist.checked, lisdt.bullet, list.bullet.circle, line.3.horizontal.decrease...,  line.3.horizontail.decrease
                                                Label(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[1].arg[1].value.[0].arg[1].value.[1].[0].[0].arg[1].value.[0].arg[0].value.arg[0].value", fallback: "Filter"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[1].arg[1].value.[0].arg[1].value.[1].[0].[0].arg[1].value.[0].arg[0].value.arg[1].value", fallback: "Button label text for filtering relay servers.")), systemImage: __designTimeString("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.[1].arg[1].value.[0].arg[1].value.[1].[0].[0].arg[1].value.[0].arg[1].value", fallback: "line.3.horizontal.decrease"))
                                                    .foregroundColor(.gray)
                                                    //.contentShape(Rectangle())
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .overlay(
                        SideMenuView(damus_state: damus, isSidebarVisible: $isSideBarOpened.animation())
                    )
                }
                .navigationViewStyle(.stack)
            
                TabBar(new_events: $home.new_events, selected: $selected_timeline, isSidebarVisible: $isSideBarOpened, action: switch_timeline)
                    .padding([.bottom], __designTimeInteger("#6558.[7].[36].property.[0].[0].arg[2].value.[0].[0].[1].modifier[0].arg[1].value", fallback: 8))
                    .background(Color(uiColor: .systemBackground).ignoresSafeArea())
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear() {
            self.connect()
            setup_notifications()
        }
        .sheet(item: $active_sheet) { item in
            switch item {
            case .report(let target):
                MaybeReportView(target: target)
            case .post:
                PostView(replying_to: nil, references: [], damus_state: damus_state!)
            case .reply(let event):
                ReplyView(replying_to: event, damus: damus_state!)
            case .event:
                EventDetailView()
            case .filter:
                let timeline = selected_timeline ?? .home
                if #available(iOS 16.0, *) {
                    RelayFilterView(state: damus_state!, timeline: timeline)
                        .presentationDetents([.height(__designTimeInteger("#6558.[7].[36].property.[0].[0].modifier[2].arg[1].value.[0].[4].[1].[0].[0].modifier[0].arg[0].value.[0].arg[0].value", fallback: 550))])
                        .presentationDragIndicator(.visible)
                } else {
                    RelayFilterView(state: damus_state!, timeline: timeline)
                }
            }
        }
        .onOpenURL { url in
            guard let link = decode_nostr_uri(url.absoluteString) else {
                return
            }
            
            switch link {
            case .ref(let ref):
                if ref.key == "p" {
                    active_profile = ref.ref_id
                    profile_open = true
                } else if ref.key == "e" {
                    find_event(state: damus_state!, evid: ref.ref_id, search_type: .event, find_from: nil) { ev in
                        if let ev {
                            active_event = ev
                        }
                    }
                    thread_open = true
                }
            case .filter(let filt):
                active_search = filt
                search_open = true
                break
                // TODO: handle filter searches?
            }
            
        }
        .onReceive(handle_notify(.boost)) { notif in
            current_boost = (notif.object as? NostrEvent)
        }
        .onReceive(handle_notify(.open_thread)) { obj in
            //let ev = obj.object as! NostrEvent
            //thread.set_active_event(ev)
            //is_thread_open = true
        }
        .onReceive(handle_notify(.reply)) { notif in
            let ev = notif.object as! NostrEvent
            self.active_sheet = .reply(ev)
        }
        .onReceive(handle_notify(.like)) { like in
        }
        .onReceive(handle_notify(.deleted_account)) { notif in
            self.is_deleted_account = true
        }
        .onReceive(handle_notify(.report)) { notif in
            let target = notif.object as! ReportTarget
            self.active_sheet = .report(target)
        }
        .onReceive(handle_notify(.block)) { notif in
            let pubkey = notif.object as! String
            self.blocking = pubkey
            self.confirm_block = true
        }
        .onReceive(handle_notify(.broadcast_event)) { obj in
            let ev = obj.object as! NostrEvent
            self.damus_state?.pool.send(.event(ev))
        }
        .onReceive(handle_notify(.unfollow)) { notif in
            guard let privkey = self.privkey else {
                return
            }
            
            guard let damus = self.damus_state else {
                return
            }
            
            let target = notif.object as! FollowTarget
            let pk = target.pubkey
            
            if let ev = unfollow_user(pool: damus.pool,
                                      our_contacts: damus.contacts.event,
                                      pubkey: damus.pubkey,
                                      privkey: privkey,
                                      unfollow: pk) {
                notify(.unfollowed, pk)
                
                damus.contacts.event = ev
                damus.contacts.remove_friend(pk)
                //friend_events = friend_events.filter { $0.pubkey != pk }
            }
        }
        .onReceive(handle_notify(.follow)) { notif in
            guard let privkey = self.privkey else {
                return
            }
            
            let fnotify = notif.object as! FollowTarget
            guard let damus = self.damus_state else {
                return
            }
            
            if let ev = follow_user(pool: damus.pool,
                                    our_contacts: damus.contacts.event,
                                    pubkey: damus.pubkey,
                                    privkey: privkey,
                                    follow: ReferencedId(ref_id: fnotify.pubkey, relay_id: nil, key: "p")) {
                notify(.followed, fnotify.pubkey)
                
                damus_state?.contacts.event = ev
                
                switch fnotify {
                case .pubkey(let pk):
                    damus.contacts.add_friend_pubkey(pk)
                case .contact(let ev):
                    damus.contacts.add_friend_contact(ev)
                }
            }
        }
        .onReceive(handle_notify(.post)) { obj in
            guard let privkey = self.privkey else {
                return
            }
            
            let post_res = obj.object as! NostrPostResult
            switch post_res {
            case .post(let post):
                //let post = tup.0
                //let to_relays = tup.1
                print("post \(post.content)")
                let new_ev = post_to_event(post: post, privkey: privkey, pubkey: pubkey)
                self.damus_state?.pool.send(.event(new_ev))
            case .cancel:
                active_sheet = nil
                print(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[14].arg[1].value.[2].[1].[1].arg[0].value", fallback: "post cancelled"))
            }
        }
        .onReceive(timer) { n in
            self.damus_state?.pool.connect_to_disconnected()
        }
        .onReceive(handle_notify(.new_mutes)) { notif in
            home.filter_muted()
        }
        .alert(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[17].arg[0].value.arg[0].value", fallback: "Deleted Account"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[17].arg[0].value.arg[1].value", fallback: "Alert message to indicate this is a deleted account")), isPresented: $is_deleted_account) {
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[17].arg[2].value.[0].arg[0].value.arg[0].value", fallback: "Logout"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[17].arg[2].value.[0].arg[0].value.arg[1].value", fallback: "Button to close the alert that informs that the current account has been deleted."))) {
                is_deleted_account = false
                notify(.logout, ())
            }
        }
        .alert(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[0].value.arg[0].value", fallback: "User blocked"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[0].value.arg[1].value", fallback: "Alert message to indicate the user has been blocked")), isPresented: $user_blocked_confirm, actions: {
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[2].value.[0].arg[0].value.arg[0].value", fallback: "Thanks!"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[2].value.[0].arg[0].value.arg[1].value", fallback: "Button to close out of alert that informs that the action to block a user was successful."))) {
                user_blocked_confirm = false
            }
        }, message: {
            if let pubkey = self.blocking {
                let profile = damus_state!.profiles.lookup(id: pubkey)
                let name = Profile.displayName(profile: profile, pubkey: pubkey).username
                Text("\(name) has been blocked", comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[3].value.[0].[0].[2].arg[1].value", fallback: "Alert message that informs a user was blocked."))
            } else {
                Text(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[3].value.[0].[1].[0].arg[0].value", fallback: "User has been blocked"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[18].arg[3].value.[0].[1].[0].arg[1].value", fallback: "Alert message that informs a user was blocked."))
            }
        })
        .alert(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[0].value.arg[0].value", fallback: "Create new mutelist"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[0].value.arg[1].value", fallback: "Title of alert prompting the user to create a new mutelist.")), isPresented: $confirm_overwrite_mutelist, actions: {
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[2].value.[0].arg[0].value.arg[0].value", fallback: "Cancel"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[2].value.[0].arg[0].value.arg[1].value", fallback: "Button to cancel out of alert that creates a new mutelist."))) {
                confirm_overwrite_mutelist = false
                confirm_block = false
            }

            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[2].value.[1].arg[0].value.arg[0].value", fallback: "Yes, Overwrite"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[2].value.[1].arg[0].value.arg[1].value", fallback: "Text of button that confirms to overwrite the existing mutelist."))) {
                guard let ds = damus_state else {
                    return
                }
                
                guard let keypair = ds.keypair.to_full() else {
                    return
                }
                
                guard let pubkey = blocking else {
                    return
                }
                
                guard let mutelist = create_or_update_mutelist(keypair: keypair, mprev: nil, to_add: pubkey) else {
                    return
                }
                
                damus_state?.contacts.set_mutelist(mutelist)
                ds.pool.send(.event(mutelist))

                confirm_overwrite_mutelist = false
                confirm_block = false
                user_blocked_confirm = true
            }
        }, message: {
            Text(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[3].value.[0].arg[0].value", fallback: "No block list found, create a new one? This will overwrite any previous block lists."), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[19].arg[3].value.[0].arg[1].value", fallback: "Alert message prompt that asks if the user wants to create a new block list, overwriting previous block lists."))
        })
        .alert(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[0].value.arg[0].value", fallback: "Block User"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[0].value.arg[1].value", fallback: "Title of alert for blocking a user.")), isPresented: $confirm_block, actions: {
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[2].value.[0].arg[0].value.arg[0].value", fallback: "Cancel"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[2].value.[0].arg[0].value.arg[1].value", fallback: "Alert button to cancel out of alert for blocking a user.")), role: .cancel) {
                confirm_block = false
            }
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[2].value.[1].arg[0].value.arg[0].value", fallback: "Block"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[2].value.[1].arg[0].value.arg[1].value", fallback: "Alert button to block a user.")), role: .destructive) {
                guard let ds = damus_state else {
                    return
                }

                if ds.contacts.mutelist == nil {
                    confirm_overwrite_mutelist = true
                } else {
                    guard let keypair = ds.keypair.to_full() else {
                        return
                    }
                    guard let pubkey = blocking else {
                        return
                    }

                    guard let ev = create_or_update_mutelist(keypair: keypair, mprev: ds.contacts.mutelist, to_add: pubkey) else {
                        return
                    }
                    damus_state?.contacts.set_mutelist(ev)
                    ds.pool.send(.event(ev))
                }
            }
        }, message: {
            if let pubkey = blocking {
                let profile = damus_state?.profiles.lookup(id: pubkey)
                let name = Profile.displayName(profile: profile, pubkey: pubkey).username
                Text("Block \(name)?", comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[3].value.[0].[0].[2].arg[1].value", fallback: "Alert message prompt to ask if a user should be blocked."))
            } else {
                Text(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[3].value.[0].[1].[0].arg[0].value", fallback: "Could not find user to block..."), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[20].arg[3].value.[0].[1].[0].arg[1].value", fallback: "Alert message to indicate that the blocked user could not be found."))
            }
        })
        .alert(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[0].value.arg[0].value", fallback: "Repost"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[0].value.arg[1].value", fallback: "Title of alert for confirming to repost a post.")), isPresented: $current_boost.mappedToBool()) {
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[2].value.[0].arg[0].value.arg[0].value", fallback: "Cancel"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[2].value.[0].arg[0].value.arg[1].value", fallback: "Button to cancel out of reposting a post."))) {
                current_boost = nil
            }
            Button(NSLocalizedString(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[2].value.[1].arg[0].value.arg[0].value", fallback: "Repost"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[2].value.[1].arg[0].value.arg[1].value", fallback: "Button to confirm reposting a post."))) {
                self.damus_state?.pool.send(.event(current_boost!))
            }
        } message: {
            Text(__designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[3].value.[0].arg[0].value", fallback: "Are you sure you want to repost this?"), comment: __designTimeString("#6558.[7].[36].property.[0].[0].modifier[21].arg[3].value.[0].arg[1].value", fallback: "Alert message to ask if user wants to repost a post."))
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: MaybeReportView(target:)) private func __preview__MaybeReportView(target: ReportTarget) -> some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 251)
        Group {
            if let ds = damus_state {
                if let sec = ds.keypair.privkey {
                    ReportView(pool: ds.pool, target: target, privkey: sec)
                } else {
                    EmptyView()
                }
            } else {
                EmptyView()
            }
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: MaybeProfileView) private var __preview__MaybeProfileView: some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 239)
        Group {
            if let pk = self.active_profile {
                let profile_model = ProfileModel(pubkey: pk, damus: damus_state!)
                let followers = FollowersModel(damus_state: damus_state!, target: pk)
                ProfileView(damus_state: damus_state!, profile: profile_model, followers: followers)
            } else {
                EmptyView()
            }
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: MaybeSearchView) private var __preview__MaybeSearchView: some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 229)
        Group {
            if let search = self.active_search {
                SearchView(appstate: damus_state!, search: SearchModel(contacts: damus_state!.contacts, pool: damus_state!.pool, search: search))
            } else {
                EmptyView()
            }
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: MainContent(damus:)) private func __preview__MainContent(damus: DamusState) -> some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 170)
        VStack {
            NavigationLink(destination: MaybeProfileView, isActive: $profile_open) {
                EmptyView()
            }
            if let active_event {
                let thread = ThreadModel(event: active_event, damus_state: damus_state!)
                NavigationLink(destination: ThreadView(state: damus_state!, thread: thread), isActive: $thread_open) {
                    EmptyView()
                }
            }
            NavigationLink(destination: MaybeSearchView, isActive: $search_open) {
                EmptyView()
            }
            switch selected_timeline {
            case .search:
                if #available(iOS 16.0, *) {
                    SearchHomeView(damus_state: damus_state!, model: SearchHomeModel(damus_state: damus_state!))
                        .scrollDismissesKeyboard(.immediately)
                } else {
                    // Fallback on earlier versions
                    SearchHomeView(damus_state: damus_state!, model: SearchHomeModel(damus_state: damus_state!))
                }
                
            case .home:
                PostingTimelineView
                
            case .notifications:
                NotificationsView(state: damus, notifications: home.notifications)
                
            case .dms:
                DirectMessagesView(damus_state: damus_state!)
                    .environmentObject(home.dms)
            
            case .none:
                EmptyView()
            }
        }
        .navigationBarTitle(timeline_name(selected_timeline), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    if selected_timeline == .home {
                        Image(__designTimeString("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].arg[0].value", fallback: "damus-home"))
                            .resizable()
                            .frame(width:__designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].modifier[1].arg[0].value", fallback: 30),height:__designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].modifier[1].arg[1].value", fallback: 30))
                            .shadow(color: Color(__designTimeString("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].modifier[2].arg[0].value.arg[0].value", fallback: "DamusPurple")), radius: __designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].modifier[2].arg[1].value", fallback: 2))
                            .opacity(isSideBarOpened ? __designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].modifier[3].arg[0].value.then", fallback: 0) : __designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].modifier[3].arg[0].value.else", fallback: 1))
                            .animation(isSideBarOpened ? .none : .default, value: isSideBarOpened)
                    } else {
                        timelineNavItem
                            .opacity(isSideBarOpened ? __designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[1].[0].modifier[0].arg[0].value.then", fallback: 0) : __designTimeInteger("#6558.[7].[32].[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[1].[0].modifier[0].arg[0].value.else", fallback: 1))
                            .animation(isSideBarOpened ? .none : .default, value: isSideBarOpened)
                    }
                }
            }
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: timelineNavItem) private var __preview__timelineNavItem: Text {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 151)
        switch selected_timeline {
        case .home:
            return Text(__designTimeString("#6558.[7].[31].property.[0].[0].[0].[0].arg[0].value", fallback: "Home"), comment: __designTimeString("#6558.[7].[31].property.[0].[0].[0].[0].arg[1].value", fallback: "Navigation bar title for Home view where posts and replies appear from those who the user is following."))
                .bold()
        case .dms:
            return Text(__designTimeString("#6558.[7].[31].property.[0].[0].[1].[0].arg[0].value", fallback: "DMs"), comment: __designTimeString("#6558.[7].[31].property.[0].[0].[1].[0].arg[1].value", fallback: "Toolbar label for DMs view, where DM is the English abbreviation for Direct Message."))
                .bold()
        case .notifications:
            return Text(__designTimeString("#6558.[7].[31].property.[0].[0].[2].[0].arg[0].value", fallback: "Notifications"), comment: __designTimeString("#6558.[7].[31].property.[0].[0].[2].[0].arg[1].value", fallback: "Toolbar label for Notifications view."))
                .bold()
        case .search:
            return Text(__designTimeString("#6558.[7].[31].property.[0].[0].[3].[0].arg[0].value", fallback: "Universe 🛸"), comment: __designTimeString("#6558.[7].[31].property.[0].[0].[3].[0].arg[1].value", fallback: "Toolbar label for the universal view where posts from all connected relay servers appear."))
                .bold()
        case .none:
            return Text(verbatim: __designTimeString("#6558.[7].[31].property.[0].[0].[4].[0].arg[0].value", fallback: ""))
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: popToRoot()) private func __preview__popToRoot() {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 144)
        profile_open = false
        thread_open = false
        search_open = false
        isSideBarOpened = false
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: contentTimelineView(filter:)) private func __preview__contentTimelineView(filter: (@escaping (NostrEvent) -> Bool)) -> some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 136)
        ZStack {
            if let damus = self.damus_state {
                TimelineView(events: home.events, loading: $home.loading, damus: damus, show_friend_icon: __designTimeBoolean("#6558.[7].[29].[0].arg[0].value.[0].[0].[0].arg[3].value", fallback: false), filter: filter)
            }
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: PostingTimelineView) private var __preview__PostingTimelineView: some View {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 103)
        VStack {
            ZStack {
                TabView(selection: $filter_state) {
                    contentTimelineView(filter: FilterState.posts.filter)
                        .tag(FilterState.posts)
                        .id(FilterState.posts)
                    contentTimelineView(filter: FilterState.posts_and_replies.filter)
                        .tag(FilterState.posts_and_replies)
                        .id(FilterState.posts_and_replies)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                if privkey != nil {
                    PostButtonContainer(is_left_handed: damus_state?.settings.left_handed ?? false) {
                        self.active_sheet = .post
                    }
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: __designTimeInteger("#6558.[7].[28].property.[0].[0].modifier[0].arg[1].value", fallback: 0)) {
            VStack(spacing: __designTimeInteger("#6558.[7].[28].property.[0].[0].modifier[0].arg[2].value.[0].arg[0].value", fallback: 0)) {
                CustomPicker(selection: $filter_state, content: {
                    Text(__designTimeString("#6558.[7].[28].property.[0].[0].modifier[0].arg[2].value.[0].arg[1].value.[0].arg[1].value.[0].arg[0].value", fallback: "Posts"), comment: __designTimeString("#6558.[7].[28].property.[0].[0].modifier[0].arg[2].value.[0].arg[1].value.[0].arg[1].value.[0].arg[1].value", fallback: "Label for filter for seeing only posts (instead of posts and replies).")).tag(FilterState.posts)
                    Text(__designTimeString("#6558.[7].[28].property.[0].[0].modifier[0].arg[2].value.[0].arg[1].value.[0].arg[1].value.[1].arg[0].value", fallback: "Posts & Replies"), comment: __designTimeString("#6558.[7].[28].property.[0].[0].modifier[0].arg[2].value.[0].arg[1].value.[0].arg[1].value.[1].arg[1].value", fallback: "Label for filter for seeing posts and replies (instead of only posts).")).tag(FilterState.posts_and_replies)
                })
                Divider()
                    .frame(height: __designTimeInteger("#6558.[7].[28].property.[0].[0].modifier[0].arg[2].value.[0].arg[1].value.[1].modifier[0].arg[0].value", fallback: 1))
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: privkey) private var __preview__privkey: String? {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 69)
        return keypair.privkey
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: pubkey) private var __preview__pubkey: String {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 65)
        return keypair.pubkey
    
#sourceLocation()
    }
}

extension FilterState {
    @_dynamicReplacement(for: filter(ev:)) private func __preview__filter(ev: NostrEvent) -> Bool {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 52)
        switch self {
        case .posts:
            return !ev.is_reply(nil)
        case .posts_and_replies:
            return __designTimeBoolean("#6558.[6].[2].[0].[1].[0]", fallback: true)
        }
    
#sourceLocation()
    }
}

extension Sheets {
    @_dynamicReplacement(for: id) private var __preview__id: String {
        #sourceLocation(file: "/Users/vladislavsorokin/reps/damus/damus/ContentView.swift", line: 32)
        switch self {
        case .report: return __designTimeString("#6558.[4].[5].property.[0].[0].[0].[0]", fallback: "report")
        case .post: return __designTimeString("#6558.[4].[5].property.[0].[0].[1].[0]", fallback: "post")
        case .reply(let ev): return __designTimeString("#6558.[4].[5].property.[0].[0].[2].[0].[0]", fallback: "reply-") + ev.id
        case .event(let ev): return __designTimeString("#6558.[4].[5].property.[0].[0].[3].[0].[0]", fallback: "event-") + ev.id
        case .filter: return __designTimeString("#6558.[4].[5].property.[0].[0].[4].[0]", fallback: "filter")
        }
    
#sourceLocation()
    }
}

import struct damus.TimestampedProfile
import enum damus.Sheets
import enum damus.ThreadState
import enum damus.FilterState
import struct damus.ContentView
import struct damus.ContentView_Previews
import struct damus.LastNotification
