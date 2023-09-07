from objectmaphelper import *

from .main_names import statusDesktop_mainWindow
from .main_names import statusDesktop_mainWindow_overlay
from .main_names import statusDesktop_mainWindow_overlay_popup2

# Scroll
o_Flickable = {"container": statusDesktop_mainWindow_overlay, "type": "Flickable", "unnamed": 1, "visible": True}

# Context Menu
o_StatusListView = {"container": statusDesktop_mainWindow_overlay, "type": "StatusListView", "unnamed": 1, "visible": True}


""" Onboarding """
# Before you get started Popup
acknowledge_checkbox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "objectName": "acknowledgeCheckBox", "type": "StatusCheckBox", "visible": True}
termsOfUseCheckBox_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "objectName":"termsOfUseCheckBox", "type": "StatusCheckBox", "visible": True}
getStartedStatusButton_StatusButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "getStartedStatusButton", "type": "StatusButton", "visible": True}

# Back Up Your Seed Phrase Popup
o_PopupItem = {"container": statusDesktop_mainWindow_overlay, "type": "PopupItem", "unnamed": 1, "visible": True}
i_have_a_pen_and_paper_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "objectName": "Acknowledgements_havePen", "type": "StatusCheckBox", "visible": True}
i_know_where_I_ll_store_it_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "objectName": "Acknowledgements_storeIt", "type": "StatusCheckBox", "visible": True}
i_am_ready_to_write_down_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "objectName": "Acknowledgements_writeDown", "type": "StatusCheckBox", "visible": True}
not_Now_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "type": "StatusButton", "unnamed": 1, "visible": True}
confirm_Seed_Phrase_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "objectName": "BackupSeedModal_nextButton", "type": "StatusButton", "visible": True}
backup_seed_phrase_popup_ConfirmSeedPhrasePanel_StatusSeedPhraseInput_placeholder = {"container": statusDesktop_mainWindow_overlay, "objectName": "ConfirmSeedPhrasePanel_StatusSeedPhraseInput_%WORD_NO%", "type": "StatusSeedPhraseInput", "visible": True}
reveal_seed_phrase_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "objectName": "ConfirmSeedPhrasePanel_RevealSeedPhraseButton", "type": "StatusButton", "visible": True}
blur_GaussianBlur = {"container": statusDesktop_mainWindow_overlay, "id": "blur", "type": "GaussianBlur", "unnamed": 1, "visible": True}
confirmSeedPhrasePanel_StatusSeedPhraseInput = {"container": statusDesktop_mainWindow_overlay, "type": "StatusSeedPhraseInput", "visible": True}
confirmFirstWord = {"container": statusDesktop_mainWindow_overlay, "objectName": "BackupSeedModal_BackupSeedStepBase_confirmFirstWord", "type": "BackupSeedStepBase", "visible": True}
confirmFirstWord_inputText = {"container": confirmFirstWord, "objectName": "BackupSeedStepBase_inputText", "type": "TextEdit", "visible": True}
continue_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "objectName": "BackupSeedModal_nextButton", "type": "StatusButton", "visible": True}
confirmSecondWord = {"container": statusDesktop_mainWindow_overlay, "objectName": "BackupSeedModal_BackupSeedStepBase_confirmSecondWord", "type": "BackupSeedStepBase", "visible": True}
confirmSecondWord_inputText = {"container": confirmSecondWord, "objectName": "BackupSeedStepBase_inputText", "type": "TextEdit", "visible": True}
i_acknowledge_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "objectName": "ConfirmStoringSeedPhrasePanel_storeCheck", "type": "StatusCheckBox", "visible": True}
completeAndDeleteSeedPhraseButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "BackupSeedModal_completeAndDeleteSeedPhraseButton", "type": "StatusButton", "visible": True}

# Send Contact Request Popup
contactRequest_ChatKey_Input = {"container": statusDesktop_mainWindow_overlay, "objectName": "SendContactRequestModal_ChatKey_Input", "type": "TextEdit"}
contactRequest_SayWhoYouAre_Input = {"container": statusDesktop_mainWindow_overlay, "objectName": "SendContactRequestModal_SayWhoYouAre_Input", "type": "TextEdit"}
contactRequest_Send_Button = {"container": statusDesktop_mainWindow_overlay, "objectName": "SendContactRequestModal_Send_Button", "type": "StatusButton"}

# Change Language Popup
close_the_app_now_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "type": "StatusButton", "unnamed": 1, "visible": True}

# User Status Profile Menu
o_StatusListView = {"container": statusDesktop_mainWindow_overlay, "type": "StatusListView", "unnamed": 1, "visible": True}
userContextmenu_AlwaysActiveButton= {"container": o_StatusListView, "objectName": "userStatusMenuAlwaysOnlineAction", "type": "StatusMenuItem", "visible": True}
userContextmenu_InActiveButton= {"container": o_StatusListView, "objectName": "userStatusMenuInactiveAction", "type": "StatusMenuItem", "visible": True}
userContextmenu_AutomaticButton= {"container": o_StatusListView, "objectName": "userStatusMenuAutomaticAction", "type": "StatusMenuItem", "visible": True}
userContextMenu_ViewMyProfileAction = {"container": o_StatusListView, "objectName": "userStatusViewMyProfileAction", "type": "StatusMenuItem", "visible": True}
userLabel_StyledText = {"container": o_StatusListView, "type": "StyledText", "unnamed": 1, "visible": True}
o_StatusIdenticonRing = {"container": o_StatusListView, "type": "StatusIdenticonRing", "unnamed": 1, "visible": True}

# My Profile Popup
ProfileHeader_userImage = {"container": statusDesktop_mainWindow_overlay, "objectName": "ProfileDialog_userImage", "type": "UserImage", "visible": True}
ProfilePopup_displayName = {"container": statusDesktop_mainWindow_overlay, "objectName": "ProfileDialog_displayName", "type": "StatusBaseText", "visible": True}
ProfilePopup_editButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "editProfileButton", "type": "StatusButton", "visible": True}
ProfilePopup_SendContactRequestButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "profileDialog_sendContactRequestButton", "type": "StatusButton", "visible": True}
profileDialog_userEmojiHash_EmojiHash = {"container": statusDesktop_mainWindow_overlay, "objectName": "ProfileDialog_userEmojiHash", "type": "EmojiHash", "visible": True}
edit_TextEdit = {"container": statusDesktop_mainWindow_overlay, "id": "edit", "type": "TextEdit", "unnamed": 1, "visible": True}
https_status_app_StatusBaseText = {"container": edit_TextEdit, "type": "StatusBaseText", "unnamed": 1, "visible": True}

# Welcome Status Popup
agreeToUse_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "id": "agreeToUse", "type": "StatusCheckBox", "unnamed": 1, "visible": True}
readyToUse_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "id": "readyToUse", "type": "StatusCheckBox", "unnamed": 1, "visible": True}
i_m_ready_to_use_Status_Desktop_Beta_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "type": "StatusButton", "unnamed": 1, "visible": True}


""" Communities """

# Create Community Banner
create_new_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "objectName": "communityBannerButton", "type": "StatusButton", "visible": True}

# Create Community Popup
createCommunityNameInput_TextEdit = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityNameInput", "type": "TextEdit", "visible": True}
createCommunityDescriptionInput_TextEdit = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityDescriptionInput", "type": "TextEdit", "visible": True}
communityBannerPicker_BannerPicker = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityBannerPicker", "type": "BannerPicker", "visible": True}
addButton_StatusRoundButton = {"container": communityBannerPicker_BannerPicker, "id": "addButton", "type": "StatusRoundButton", "unnamed": 1, "visible": True}
communityLogoPicker_LogoPicker = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityLogoPicker", "type": "LogoPicker", "visible": True}
addButton_StatusRoundButton2 = {"container": communityLogoPicker_LogoPicker, "id": "addButton", "type": "StatusRoundButton", "unnamed": 1, "visible": True}
communityColorPicker_ColorPicker = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityColorPicker", "type": "ColorPicker", "visible": True}
StatusPickerButton = {"checkable": False, "container": communityColorPicker_ColorPicker, "type": "StatusPickerButton", "unnamed": 1, "visible": True}
communityTagsPicker_TagsPicker = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityTagsPicker", "type": "TagsPicker", "visible": True}
choose_tags_StatusPickerButton = {"checkable": False, "container": communityTagsPicker_TagsPicker, "type": "StatusPickerButton", "unnamed": 1, "visible": True}
archiveSupportToggle_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "id": "archiveSupportToggle", "type": "StatusCheckBox", "unnamed": 1, "visible": True}
requestToJoinToggle_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "id": "requestToJoinToggle", "type": "StatusCheckBox", "unnamed": 1, "visible": True}
pinMessagesToggle_StatusCheckBox = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "id": "pinMessagesToggle", "type": "StatusCheckBox", "unnamed": 1, "visible": True}
createCommunityNextBtn_StatusButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "createCommunityNextBtn", "type": "StatusButton", "visible": True}
createCommunityIntroMessageInput_TextEdit = {"container": statusDesktop_mainWindow_overlay, "objectName": "createCommunityIntroMessageInput", "type": "TextEdit", "visible": True}
createCommunityOutroMessageInput_TextEdit = {"container": statusDesktop_mainWindow_overlay, "objectName": "createCommunityOutroMessageInput", "type": "TextEdit", "visible": True}
createCommunityFinalBtn_StatusButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "createCommunityFinalBtn", "type": "StatusButton", "visible": True}

# Community channel popup:
createOrEditCommunityChannelNameInput_TextEdit = {"container": statusDesktop_mainWindow_overlay, "objectName": "createOrEditCommunityChannelNameInput", "type": "TextEdit", "visible": True}
createOrEditCommunityChannelDescriptionInput_TextEdit = {"container": statusDesktop_mainWindow_overlay, "objectName": "createOrEditCommunityChannelDescriptionInput", "type": "TextEdit", "visible": True}
createOrEditCommunityChannelBtn_StatusButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "createOrEditCommunityChannelBtn", "type": "StatusButton", "visible": True}
createOrEditCommunityChannel_EmojiButton = {"container": statusDesktop_mainWindow_overlay, "objectName": "StatusChannelPopup_emojiButton", "type": "StatusRoundButton", "visible": True}

""" Common """

# Select Color Popup
communitySettings_ColorPanel_HexColor_Input = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityColorPanelHexInput", "type": "TextEdit", "visible": True}
communitySettings_SaveColor_Button = {"container": statusDesktop_mainWindow_overlay, "objectName": "communityColorPanelSelectColorButton", "type": "StatusButton", "visible": True}

# Select Tag Popup
o_StatusCommunityTag = {"container": statusDesktop_mainWindow_overlay, "type": "StatusCommunityTag", "unnamed": 1, "visible": True}
confirm_Community_Tags_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "type": "StatusButton", "unnamed": 1, "visible": True}

# Signing phrase popup
signPhrase_Ok_Button = {"container": statusDesktop_mainWindow, "type": "StatusFlatButton", "objectName": "signPhraseModalOkButton", "visible": True}

# Remove account popup:
mainWallet_Remove_Account_Popup_Account_Notification = {"container": statusDesktop_mainWindow, "objectName": "RemoveAccountPopup-Notification", "type": "StatusBaseText", "visible": True}
mainWallet_Remove_Account_Popup_Account_Path_Component = {"container": statusDesktop_mainWindow, "objectName": "RemoveAccountPopup-DerivationPath", "type": "StatusInput", "visible": True}
mainWallet_Remove_Account_Popup_Account_Path = {"container": mainWallet_Remove_Account_Popup_Account_Path_Component, "type": "TextEdit", "unnamed": 1, "visible": True}
mainWallet_Remove_Account_Popup_HavePenPaperCheckBox = {"checkable": True, "container": statusDesktop_mainWindow, "objectName": "RemoveAccountPopup-HavePenPaper", "type": "StatusCheckBox", "visible": True}
mainWallet_Remove_Account_Popup_ConfirmButton = {"container": statusDesktop_mainWindow, "objectName": "RemoveAccountPopup-ConfirmButton", "type": "StatusButton", "visible": True}
mainWallet_Remove_Account_Popup_CancelButton = {"container": statusDesktop_mainWindow, "objectName": "RemoveAccountPopup-CancelButton", "type": "StatusFlatButton", "visible": True}

# Add saved address popup
mainWallet_Saved_Addreses_Popup_Name_Input = {"container": statusDesktop_mainWindow, "objectName": "savedAddressNameInput", "type": "TextEdit"}
mainWallet_Saved_Addreses_Popup_Address_Input = {"container": statusDesktop_mainWindow, "objectName": "savedAddressAddressInput", "type": "StatusInput"}
mainWallet_Saved_Addreses_Popup_Address_Input_Edit = {"container": statusDesktop_mainWindow, "objectName": "savedAddressAddressInputEdit", "type": "TextEdit"}
mainWallet_Saved_Addreses_Popup_Address_Add_Button = {"container": statusDesktop_mainWindow, "objectName": "addSavedAddress", "type": "StatusButton"}
mainWallet_Saved_Addreses_Popup_Add_Network_Selector = {"container": statusDesktop_mainWindow, "objectName": "addSavedAddressNetworkSelector", "type": "StatusNetworkSelector", "visible": True}
mainWallet_Saved_Addreses_Popup_Add_Network_Button = {"container": statusDesktop_mainWindow_overlay, "objectName": "addNetworkTagItemButton", "type": "StatusRoundButton", "visible": True}
mainWallet_Saved_Addreses_Popup_Add_Network_Selector_Tag = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkSelectorTag", "type": "StatusNetworkListItemTag"}
mainWallet_Saved_Addresses_Popup_Add_Network_Selector_Mainnet_checkbox = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkSelectionCheckbox_Mainnet", "type": "StatusCheckBox", "visible": True}
mainWallet_Saved_Addresses_Popup_Add_Network_Selector_Optimism_checkbox = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkSelectionCheckbox_Optimism", "type": "StatusCheckBox", "visible": True}
mainWallet_Saved_Addresses_Popup_Add_Network_Selector_Arbitrum_checkbox = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkSelectionCheckbox_Arbitrum", "type": "StatusCheckBox", "visible": True}
mainWallet_Saved_Addresses_Popup_Network_Selector_Mainnet_network_tag = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkTagRectangle_Mainnet", "type": "Rectangle", "visible": True}
mainWallet_Saved_Addresses_Popup_Network_Selector_Optimism_network_tag = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkTagRectangle_Optimism", "type": "Rectangle", "visible": True}
mainWallet_Saved_Addresses_Popup_Network_Selector_Arbitrum_network_tag = {"container": statusDesktop_mainWindow_overlay, "objectName": "networkTagRectangle_Arbitrum", "type": "Rectangle", "visible": True}

# Context Menu
contextMenu_PopupItem = {"container": statusDesktop_mainWindow_overlay, "type": "PopupItem", "unnamed": 1, "visible": True}
contextMenuItem = {"container": statusDesktop_mainWindow_overlay, "type": "StatusBaseText", "unnamed": 1, "visible": True}

# Confirmation Popup
confirmButton = {"container": statusDesktop_mainWindow_overlay, "objectName": RegularExpression("confirm*"), "type": "StatusButton"}

# Picture Edit Popup
o_StatusSlider = {"container": statusDesktop_mainWindow_overlay, "type": "StatusSlider", "unnamed": 1, "visible": True}
cropSpaceItem_Item = {"container": statusDesktop_mainWindow_overlay, "id": "cropSpaceItem", "type": "Item", "unnamed": 1, "visible": True}
make_picture_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "objectName": "imageCropperAcceptButton", "type": "StatusButton", "visible": True}
o_DropShadow = {"container": statusDesktop_mainWindow_overlay, "type": "DropShadow", "unnamed": 1, "visible": True}

# Emoji Popup
mainWallet_AddEditAccountPopup_AccountEmojiSearchBox = {"container": statusDesktop_mainWindow, "objectName": "StatusEmojiPopup_searchBox", "type": "TextEdit", "visible": True}
mainWallet_AddEditAccountPopup_AccountEmoji = {"container": statusDesktop_mainWindow, "type": "StatusEmoji", "visible": True}

# Delete Popup
o_StatusDialogBackground = {"container": statusDesktop_mainWindow_overlay, "type": "StatusDialogBackground", "unnamed": 1, "visible": True}
delete_StatusButton = {"checkable": False, "container": statusDesktop_mainWindow_overlay, "objectName": "deleteChatConfirmationDialogDeleteButton", "type": "StatusButton", "visible": True}

# Shared Popup
sharedPopup_Popup_Content = {"container": statusDesktop_mainWindow, "objectName": "KeycardSharedPopupContent", "type": "Item"}
sharedPopup_Password_Input = {"container": sharedPopup_Popup_Content, "objectName": "keycardPasswordInput", "type": "TextField"}
sharedPopup_Primary_Button = {"container": statusDesktop_mainWindow, "objectName": "PrimaryButton", "type": "StatusButton", "visible": True, "enabled": True}

# Wallet Account Popup
mainWallet_AddEditAccountPopup_derivationPath = {"container": statusDesktop_mainWindow, "objectName": RegularExpression("AddAccountPopup-PreDefinedDerivationPath*"), "type": "StatusListItem", "visible": True}
mainWallet_Address_Panel = {"container": statusDesktop_mainWindow, "objectName": "addressPanel", "type": "StatusAddressPanel", "visible": True}
addAccountPopup_GeneratedAddress = {"container": statusDesktop_mainWindow_overlay_popup2, "type": "Rectangle", "visible": True}
address_0x_StatusBaseText = {"container": statusDesktop_mainWindow_overlay_popup2, "text": RegularExpression("0x*"), "type": "StatusBaseText", "unnamed": 1, "visible": True}
addAccountPopup_GeneratedAddressesListPageIndicatior_StatusPageIndicator = {"container": statusDesktop_mainWindow_overlay_popup2, "objectName": "AddAccountPopup-GeneratedAddressesListPageIndicatior", "type": "StatusPageIndicator", "visible": True}
page_StatusBaseButton = {"checkable": False, "container": addAccountPopup_GeneratedAddressesListPageIndicatior_StatusPageIndicator, "objectName": RegularExpression("Page-*"), "type": "StatusBaseButton", "visible": True}

# Add/Edit account popup:
grid_Grid = {"container": statusDesktop_mainWindow_overlay, "id": "grid", "type": "Grid", "unnamed": 1, "visible": True}
color_StatusColorRadioButton = {"checkable": True, "container": statusDesktop_mainWindow_overlay, "type": "StatusColorRadioButton", "unnamed": 1, "visible": True}

mainWallet_AddEditAccountPopup_Content = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-Content", "type": "Item", "visible": True}
mainWallet_AddEditAccountPopup_PrimaryButton = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-PrimaryButton", "type": "StatusButton", "visible": True}
mainWallet_AddEditAccountPopup_BackButton = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-BackButton", "type": "StatusBackButton", "visible": True}
mainWallet_AddEditAccountPopup_AccountNameComponent = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-AccountName", "type": "StatusInput", "visible": True}
mainWallet_AddEditAccountPopup_AccountName = {"container": mainWallet_AddEditAccountPopup_AccountNameComponent, "type": "TextEdit", "unnamed": 1, "visible": True}
mainWallet_AddEditAccountPopup_AccountColorComponent = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-AccountColor", "type": "StatusColorSelectorGrid", "visible": True}
mainWallet_AddEditAccountPopup_AccountColorSelector = {"container": mainWallet_AddEditAccountPopup_AccountColorComponent, "type": "Repeater", "objectName": "statusColorRepeater", "visible": True, "enabled": True}
mainWallet_AddEditAccountPopup_AccountEmojiPopupButton = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-AccountEmoji", "type": "StatusFlatRoundButton", "visible": True}
mainWallet_AddEditAccountPopup_SelectedOrigin = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-SelectedOrigin", "type": "StatusListItem", "visible": True}
mainWallet_AddEditAccountPopup_OriginOption_Placeholder = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-OriginOption-%NAME%", "type": "StatusListItem", "visible": True}
mainWallet_AddEditAccountPopup_OriginOptionNewMasterKey = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-OriginOption-LABEL-OPTION-ADD-NEW-MASTER-KEY", "type": "StatusListItem", "visible": True}
addAccountPopup_OriginOption_StatusListItem = {"container": statusDesktop_mainWindow_overlay, "type": "StatusListItem", "visible": True}

mainWallet_AddEditAccountPopup_OriginOptionWatchOnlyAcc = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-OriginOption-LABEL-OPTION-ADD-WATCH-ONLY-ACC", "type": "StatusListItem", "visible": True}
mainWallet_AddEditAccountPopup_AccountWatchOnlyAddressComponent = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-WatchOnlyAddress", "type": "StatusInput", "visible": True}
mainWallet_AddEditAccountPopup_AccountWatchOnlyAddress = {"container": mainWallet_AddEditAccountPopup_AccountWatchOnlyAddressComponent, "type": "TextEdit", "unnamed": 1, "visible": True}
mainWallet_AddEditAccountPopup_EditDerivationPathButton = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-EditDerivationPath", "type": "StatusButton", "visible": True}
mainWallet_AddEditAccountPopup_ResetDerivationPathButton = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-ResetDerivationPath", "type": "StatusLinkText", "enabled": True, "visible": True}
mainWallet_AddEditAccountPopup_DerivationPathInputComponent = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-DerivationPathInput", "type": "DerivationPathInput", "visible": True}
mainWallet_AddEditAccountPopup_DerivationPathInput = {"container": mainWallet_AddEditAccountPopup_DerivationPathInputComponent, "type": "TextEdit", "unnamed": 1, "visible": True}
mainWallet_AddEditAccountPopup_PreDefinedDerivationPathsButton = {"container": mainWallet_AddEditAccountPopup_DerivationPathInputComponent, "objectName": "chevron-down-icon", "type": "StatusIcon", "visible": True}
mainWallet_AddEditAccountPopup_GeneratedAddressComponent = {"container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-GeneratedAddress", "type": "StatusListItem", "visible": True}
mainWallet_AddEditAccountPopup_NonEthDerivationPathCheckBox = {"checkable": True, "container": statusDesktop_mainWindow, "objectName": "AddAccountPopup-ConfirmAddingNonEthDerivationPath", "type": "StatusCheckBox", "visible": True}
mainWallet_AddEditAccountPopup_MasterKey_ImportPrivateKeyOption = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-ImportPrivateKey", "type": "StatusListItem", "visible": True}
mainWallet_AddEditAccountPopup_PrivateKey = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-PrivateKeyInput", "type": "StatusPasswordInput", "visible": True}
mainWallet_AddEditAccountPopup_PrivateKeyNameComponent = {"container": mainWallet_AddEditAccountPopup_Content, "objectName": "AddAccountPopup-PrivateKeyName", "type": "StatusInput", "visible": True}
mainWallet_AddEditAccountPopup_PrivateKeyName = {"container": mainWallet_AddEditAccountPopup_PrivateKeyNameComponent, "type": "TextEdit", "unnamed": 1, "visible": True}