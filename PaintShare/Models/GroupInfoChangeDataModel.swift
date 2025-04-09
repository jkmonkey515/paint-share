//
//  GroupInfoChangeDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI
import Promises

class GroupInfoChangeDataModel: ObservableObject {
    
    var id: Int? = nil
    
    @Published var needNotAppearRefresh: Bool = false
    
    @Published var groupName: String = "" {
        didSet {
            groupNameMessage = ""
        }
    }
    
    @Published var groupOwnerName: String = ""
    
    @Published var phone: String = "" {
        didSet {
            phoneMessage = ""
        }
    }
    
    @Published var description: String = "" {
        didSet {
            descriptionMessage = ""
        }
    }
    
    var groupImgKey: String? = nil
    
    @Published var logo: UIImage? = Constants.imageHolderUIImage!
    
    @Published var groupPublic: Bool = false
    
    @Published var goodsPublic: Bool = false
    
    @Published var numberOfJoined: Int = 0
    
    @Published var numberOfShared: Int = 0
    
    // validation messages
    @Published var groupNameMessage: String = ""
    
    @Published var phoneMessage: String = ""
    
    @Published var descriptionMessage: String = ""
    
    var updatedAt: UInt64 = 0
    
    @Published var navigationTag: Int? = nil
    
    @Published var lat: Double = 0
    
    @Published var lng: Double = 0
    
    //地址
    @Published var warehouseNameMessage: String = ""
    
    @Published var zipcode: String = ""{
        didSet {
            zipcodeMessage = ""
        }
    }
    
    @Published var zipcodeMessage: String = ""
    
    @Published var municipalitieName: String = ""{
        didSet {
            municipalitieNameMessage = ""
        }
    }
    
    @Published var municipalitieNameMessage: String = ""
    
    @Published var addressName: String = ""{
        didSet {
            addressNameMessage = ""
        }
    }
    
    @Published var addressNameMessage: String = ""
    
    
    //picker 都道府県
    @Published var prefs: [PickItem] = []
    
    @Published var showPrefPick: Bool = false
    
    @Published var addBottom: Bool = false
    
    @Published var prefKey = -1
    
    @Published var prefValue: String = ""
    
    @Published var showGroupCreatedDialog: Bool = false
    
    func reset() {
        id = nil
        groupName = ""
        groupOwnerName = ""
        phone = ""
        description = ""
        groupImgKey = nil
        logo = Constants.imageHolderUIImage!
        groupPublic = false
        goodsPublic = false
        numberOfJoined = 0
        numberOfShared = 0
        groupNameMessage = ""
        phoneMessage = ""
        descriptionMessage = ""
        updatedAt = 0
        navigationTag = nil
        prefKey = -1
        prefValue = ""
        zipcode=""
        zipcodeMessage=""
        municipalitieName=""
        municipalitieNameMessage = ""
        addressName=""
        addressNameMessage = ""
    }
    
    func setPrefValue(){
        let pref=prefs.first(where: {$0.key == prefKey})
        prefValue=pref?.value ?? ""
    }
    
    func initAdressData(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_LOCATION_DATA, type: [AreaCategory].self, dialogsDataModel: dialogsDataModel)
            .then{
                areaCategoryResult in
                DispatchQueue.main.async {
                    self.prefs=[]
                    for area in areaCategoryResult ?? []{
                        for pref in area.prefectures ?? []{
                            self.prefs.append(PickItem(key: pref.code, value:pref.name))
                        }
                        
                    }
                }
            }
    }
    
    func setGroupInfo(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER, type: UserDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                userDto -> Promise<GroupDto?> in
                if userDto != nil {
                    self.groupOwnerName = "\(userDto!.lastName)　\(userDto!.firstName)"
                    self.phone = userDto!.phone
                }
                
                return UrlUtils.getRequest(url: UrlConstants.GROUP_GET_LOGGED_IN_USER_GROUP, type: GroupDto.self, dialogsDataModel: dialogsDataModel)
            }
            .then {
                groupDto in
                DispatchQueue.main.async {
                    mainViewDataModel.loggedInUserGroup = groupDto
                    if (mainViewDataModel.loggedInUserGroup != nil) {
                        self.id = mainViewDataModel.loggedInUserGroup!.id
                        self.groupName = mainViewDataModel.loggedInUserGroup!.groupName
                        self.phone = mainViewDataModel.loggedInUserGroup!.phone
                        self.description = mainViewDataModel.loggedInUserGroup!.description
                        self.groupImgKey = mainViewDataModel.loggedInUserGroup!.groupImgKey
                        self.groupPublic = mainViewDataModel.loggedInUserGroup!.groupPublic == 1
                        self.goodsPublic = mainViewDataModel.loggedInUserGroup!.goodsPublic == 1
                        self.updatedAt = mainViewDataModel.loggedInUserGroup!.updatedAt
                        self.loadImg(dialogsDataModel: dialogsDataModel)
                        self.getMembersCount(dialogsDataModel: dialogsDataModel)
                        self.zipcode = mainViewDataModel.loggedInUserGroup?.zipcode ?? ""
                        self.prefValue = mainViewDataModel.loggedInUserGroup?.prefecture ?? ""
                        self.municipalitieName = mainViewDataModel.loggedInUserGroup?.city ?? ""
                        self.addressName = mainViewDataModel.loggedInUserGroup?.address ?? ""
                    }
                }
            }
    }
    
    func loadImg(dialogsDataModel: DialogsDataModel) {
        if (self.groupImgKey == nil) {
            return
        }
        UrlUtils.getData(urlString: UrlConstants.IMAGE_S3_ROOT + self.groupImgKey!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async {
                self.logo = UIImage(data: data)
            }
        }
    }
    
    func getMembersCount(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_GROUP_RELATION_MEMBERS_COUNT + "?groupId=\(self.id!)", type: MemberCountDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                memberCountDto in
                if (memberCountDto != nil) {
                    self.numberOfJoined = memberCountDto!.totalJoined
                    self.numberOfShared = memberCountDto!.totalShared
                }
            }
    }
    
    func saveGroupUploadImage(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, groupManagementDataModel: GroupManagementDataModel) {
        if self.logo != Constants.imageHolderUIImage! {
            let imageData = self.logo!.jpegData(compressionQuality: 0.6)!
            let request = MultipartFormDataRequest(url: URL(string: UrlConstants.FILE_UPLOAD_IMAGE)!)
            request.addDataField(named: "file", data: imageData, mimeType: "image/jpeg")
            
            UrlUtils.imgUploadRequest(request: request, dialogsDataModel: dialogsDataModel)
                .then {
                    dataString in
                    DispatchQueue.main.async {
                        self.saveGroup(imgKey: dataString, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, groupManagementDataModel: groupManagementDataModel)
                    }
                }
        } else {
            self.saveGroup(imgKey: nil, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, groupManagementDataModel: groupManagementDataModel)
        }
    }
    
    func saveGroup(imgKey: String?, mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, groupManagementDataModel: GroupManagementDataModel) {
        var isCreateGroup: Bool = (id == nil)
        let body = GroupBody(id: id, groupName: groupName, phone: phone, description: description, groupImgKey: imgKey, groupPublic: groupPublic ? 1 : 0, goodsPublic: goodsPublic ? 1 : 0, zipcode: zipcode, prefecture: prefValue, city: municipalitieName, address: addressName, lat: lat, lng: lng)
        UrlUtils.postRequest(url: UrlConstants.GROUP_SAVE, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                if (isCreateGroup) {
                    self.showGroupCreatedDialog = true
                } else {
                    dialogsDataModel.showSavedDialog = true
                }
                mainViewDataModel.getLoggedInUserGroup(dialogsDataModel: dialogsDataModel)
                groupManagementDataModel.selectedTab = 0
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let groupNameError = validationError.errors["groupName"] {
                        self.groupNameMessage = groupNameError
                    }
                    if let phoneError = validationError.errors["phone"] {
                        self.phoneMessage = phoneError
                    }
                    if let descriptionError = validationError.errors["description"] {
                        self.descriptionMessage = descriptionError
                    }
                    //zipcodeMessage
                    if let zipcodeError = validationError.errors["zipcode"]{
                        self.zipcodeMessage = zipcodeError
                    }
                    //municipalitieNameMessage
                    if let cityError = validationError.errors["city"]{
                        self.municipalitieNameMessage = cityError
                    }
                    //addressNameMessage
                    if let addressError = validationError.errors["address"]{
                        self.addressNameMessage = addressError
                    }
                }
            }
    }
    
    func getAddressByCoordinate(lat: Double, lng: Double, dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_ADDRESS_BY_COORDINATE+"?lat=\(lat)&lng=\(lng)", type: GeocodingAddressDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                response in
                DispatchQueue.main.async {
                    self.zipcode = response?.zipcode ?? ""
                    self.prefValue = response?.prefecture ?? ""
                    self.municipalitieName = response?.city ?? ""
                    self.addressName = response?.address ?? ""
                }
            }
    }
    
    func deleteGroup(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, groupManagementDataModel: GroupManagementDataModel) {
        UrlUtils.postRequest(url: UrlConstants.GROUP_DELETE, body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                DispatchQueue.main.async {
                    self.reset()
                    mainViewDataModel.getLoggedInUserGroup(dialogsDataModel: dialogsDataModel)
                    groupManagementDataModel.selectedTab = 0
                }
            }
    }
}
