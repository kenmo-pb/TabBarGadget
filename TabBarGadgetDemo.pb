XIncludeFile "TabBarGadget.pbi"

Enumeration
	#Window
	#Image
	#Gadget_TabBar
	#Gadget_Vertical
	#Gadget_CloseButton
	#Gadget_SelectedCloseButton
	#Gadget_EmptyButton
	#Gadget_MirroredTabs
	#Gadget_TextCutting
	#Gadget_NoTabMoving
	#Gadget_TabRounding
	#Gadget_MultiLine
	#Gadget_BottomLine
	#Gadget_Editable
	#Gadget_MultiSelect
	#Gadget_CheckBox
	#Gadget_ReverseOrdering
	#Gadget_TabTextAlignment
	#Gadget_MinTabLength
	#Gadget_MaxTabLength
	#Gadget_Item
	#Gadget_ItemBackColor
	#Gadget_ItemFrontColor
	#Gadget_ItemText
	#Gadget_ItemImage
	#Gadget_ItemDisabled
	#Gadget_ItemSelected
	#Gadget_ItemChecked
	#Gadget_ItemCloseButton
	#Gadget_ItemCheckBox
	#Gadget_Events
	#Gadget_Container
EndEnumeration

Procedure BorderGadget(ID.i, X.i, Y.i, Width.i, Height.i, Text.s)
	Protected Result.i
	If ID = #PB_Any
		Result = ContainerGadget(ID, X, Y, Width, Height)
		SetGadgetData(Result, FrameGadget(#PB_Any, 0, 0, Width, Height, Text))
	Else
		Result = ContainerGadget(ID, X, Y, Width, Height)
		SetGadgetData(ID, FrameGadget(#PB_Any, 0, 0, Width, Height, Text))
	EndIf
	ProcedureReturn Result
EndProcedure

Procedure GetItemGadgetState()
	Select GetGadgetState(#Gadget_Item)
		Case -1
			ProcedureReturn #TabBarGadgetItem_None
		Case 0
			ProcedureReturn #TabBarGadgetItem_NewTab
		Default
			ProcedureReturn GetGadgetState(#Gadget_Item)-1
	EndSelect
EndProcedure

Procedure UpdateItemAttributes(Position)
	If GetGadgetText(#Gadget_ItemText) <> GetTabBarGadgetItemText(#Gadget_TabBar, Position)
		SetGadgetText(#Gadget_ItemText, GetTabBarGadgetItemText(#Gadget_TabBar, Position))
	EndIf
	SetGadgetState(#Gadget_ItemDisabled, (GetTabBarGadgetItemState(#Gadget_TabBar, Position)&#TabBarGadget_Disabled))
	SetGadgetState(#Gadget_ItemSelected, (GetTabBarGadgetItemState(#Gadget_TabBar, Position)&#TabBarGadget_Selected))
	SetGadgetState(#Gadget_ItemChecked, (GetTabBarGadgetItemState(#Gadget_TabBar, Position)&#TabBarGadget_Checked))
	SetGadgetState(#Gadget_ItemCloseButton, GetTabBarGadgetItemAttribute(#Gadget_TabBar, Position, #TabBarGadget_CloseButton))
	SetGadgetState(#Gadget_ItemCheckBox, GetTabBarGadgetItemAttribute(#Gadget_TabBar, Position, #TabBarGadget_CheckBox))
EndProcedure

Procedure UpdateItemGadget(Position)
	Protected Index
	ClearGadgetItems(#Gadget_Item)
	AddGadgetItem(#Gadget_Item, #PB_Default, "NewTab")
	For Index = 1 To CountTabBarGadgetItems(#Gadget_TabBar)
		AddGadgetItem(#Gadget_Item, #PB_Default, "Position "+Str(Index-1))
	Next
	SetTabBarGadgetState(#Gadget_TabBar, Position)
	SetGadgetState(#Gadget_Item, Position+1)
	UpdateItemAttributes(GetItemGadgetState())
EndProcedure



Define Color.i, FileName.s, Position.i

UsePNGImageDecoder()

OpenWindow(#Window, 0, 0, 800, 450, "TabBarGadget", #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_SizeGadget)

TabBarGadget(#Gadget_TabBar, 0, 0, WindowWidth(#Window), #TabBarGadget_DefaultHeight, #TabBarGadget_None, #Window)
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "In this")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "example")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "you can")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "feel the")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "power of")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "Pure Basic")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "and the")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "TabBarGadget")
	AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "include")
TabBarGadgetToolTip(#Gadget_TabBar, "%ITEM", "new", "close")

If ContainerGadget(#Gadget_Container, 0, GadgetHeight(#Gadget_TabBar), WindowWidth(#Window), WindowHeight(#Window)-GadgetHeight(#Gadget_TabBar), #PB_Container_Flat)
	
	If BorderGadget(#PB_Any, 5, 5, 170, 370, "Attributes for the bar")
		CheckBoxGadget(#Gadget_CloseButton, 10, 20, 130, 20, "tab close button")
		CheckBoxGadget(#Gadget_SelectedCloseButton, 10, 40, 130, 20, "selected tab close button")
		CheckBoxGadget(#Gadget_EmptyButton, 10, 60, 130, 20, "'new' tab")
		CheckBoxGadget(#Gadget_CheckBox, 10, 80, 130, 20, "tab check box")
		CheckBoxGadget(#Gadget_Vertical, 10, 100, 130, 20, "vertical tab bar")
		CheckBoxGadget(#Gadget_MirroredTabs, 10, 120, 130, 20, "mirror tab bar")
		CheckBoxGadget(#Gadget_ReverseOrdering, 10, 140, 130, 20, "reverse ordering")
		CheckBoxGadget(#Gadget_MultiLine, 10, 160, 130, 20, "multiline tab bar")
		CheckBoxGadget(#Gadget_TextCutting, 10, 180, 130, 20, "text cutting")
		CheckBoxGadget(#Gadget_Editable, 10, 200, 130, 20, "editable tab text")
		CheckBoxGadget(#Gadget_MultiSelect, 10, 220, 130, 20, "multi select")
		CheckBoxGadget(#Gadget_NoTabMoving, 10, 240, 130, 20, "no tab moving")
		CheckBoxGadget(#Gadget_BottomLine, 10, 260, 130, 20, "bottom line")
		TextGadget(#PB_Any, 10, 285, 90, 20, "tab text alignment:")
			SpinGadget(#Gadget_TabTextAlignment, 100, 280, 60, 20, -1, 1, #PB_Spin_Numeric)
			SetGadgetState(#Gadget_TabTextAlignment, GetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_TabTextAlignment))
		TextGadget(#PB_Any, 10, 305, 90, 20, "tab rounding:")
			SpinGadget(#Gadget_TabRounding, 100, 300, 60, 20, 0, 20, #PB_Spin_Numeric)
			SetGadgetState(#Gadget_TabRounding, GetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_TabRounding))
		TextGadget(#PB_Any, 10, 325, 90, 20, "min tab length:")
			SpinGadget(#Gadget_MinTabLength, 100, 320, 60, 20, 0, 1000, #PB_Spin_Numeric)
			SetGadgetState(#Gadget_MinTabLength, GetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MinTabLength))
		TextGadget(#PB_Any, 10, 345, 90, 20, "max tab length:")
			SpinGadget(#Gadget_MaxTabLength, 100, 340, 60, 20, 0, 1000, #PB_Spin_Numeric)
			SetGadgetState(#Gadget_MaxTabLength, GetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MaxTabLength))
		CloseGadgetList()
	EndIf
	
	If BorderGadget(#PB_Any, 180, 5, 375, 195, "Tabs")
		TextGadget(#PB_Any, 10, 28, 50, 20, "Position:")
		ComboBoxGadget(#Gadget_Item, 60, 25, 100, 20)
		ButtonGadget(#Gadget_ItemBackColor, 10, 50, 100, 20, "background color")
		ButtonGadget(#Gadget_ItemFrontColor, 115, 50, 100, 20, "text color")
		TextGadget(#PB_Any, 10, 78, 30, 20, "Text:")
		StringGadget(#Gadget_ItemText, 40, 75, 175, 20, GetTabBarGadgetText(#Gadget_TabBar))
		CheckBoxGadget(#Gadget_ItemDisabled, 10, 100, 100, 20, "disabled")
		CheckBoxGadget(#Gadget_ItemSelected, 10, 120, 100, 20, "seleced")
		CheckBoxGadget(#Gadget_ItemChecked, 10, 140, 100, 20, "checked")
		CheckBoxGadget(#Gadget_ItemCloseButton, 210, 100, 100, 20, "close button")
		CheckBoxGadget(#Gadget_ItemCheckBox, 210, 120, 100, 20, "check box")
		ButtonGadget(#Gadget_ItemImage, 10, 165, 100, 20, "image or icon", #PB_Button_Toggle)
		CloseGadgetList()
	EndIf
	
	If BorderGadget(#PB_Any, 180, 210, 225, 120, "Events")
		EditorGadget(#Gadget_Events, 10, 20, 200, 90, #PB_Editor_ReadOnly)
		CloseGadgetList()
	EndIf

UpdateItemGadget(0)

EndIf


Procedure Resize()
	
	If GetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_Vertical)
		ResizeGadget(#Gadget_TabBar, 0, 0, #PB_Ignore, WindowHeight(#Window))
		UpdateTabBarGadget(#Gadget_TabBar)
		ResizeGadget(#Gadget_Container, GadgetWidth(#Gadget_TabBar), 0, WindowWidth(#Window)-GadgetWidth(#Gadget_TabBar), WindowHeight(#Window))
	Else
		ResizeGadget(#Gadget_TabBar, 0, 0, WindowWidth(#Window), #PB_Ignore)
		UpdateTabBarGadget(#Gadget_TabBar)
		ResizeGadget(#Gadget_Container, 0, GadgetHeight(#Gadget_TabBar), WindowWidth(#Window), WindowHeight(#Window)-GadgetHeight(#Gadget_TabBar))
	EndIf
	
EndProcedure

BindEvent(#PB_Event_SizeWindow, @Resize())
Resize()


Repeat
	
	Select WaitWindowEvent()
			
		Case #PB_Event_CloseWindow
			
			End
			
		Case #PB_Event_SizeWindow
			
		Case #PB_Event_Gadget
			
			Select EventGadget()
				Case #Gadget_TabBar
					Select EventType()
						Case #TabBarGadget_EventType_NewItem
							AddGadgetItem(#Gadget_Events, 0, "NewItem: "+Str(GetTabBarGadgetItemPosition(#Gadget_TabBar, #TabBarGadgetItem_Event)))
							Position = AddTabBarGadgetItem(#Gadget_TabBar, #PB_Default, "New tab")
							UpdateItemGadget(Position)
						Case #TabBarGadget_EventType_CloseItem
							AddGadgetItem(#Gadget_Events, 0, "CloseItem: "+Str(GetTabBarGadgetItemPosition(#Gadget_TabBar, #TabBarGadgetItem_Event)))
							RemoveTabBarGadgetItem(#Gadget_TabBar, #TabBarGadgetItem_Event)
						Case #TabBarGadget_EventType_Change
							AddGadgetItem(#Gadget_Events, 0, "Change: "+Str(GetTabBarGadgetItemPosition(#Gadget_TabBar, #TabBarGadgetItem_Event)))
						Case #TabBarGadget_EventType_CheckBox
							AddGadgetItem(#Gadget_Events, 0, "CheckBox: "+Str(GetTabBarGadgetItemPosition(#Gadget_TabBar, #TabBarGadgetItem_Event)))
						Case #TabBarGadget_EventType_Resize
							AddGadgetItem(#Gadget_Events, 0, "Resize")
							Resize()
						Case #TabBarGadget_EventType_EditItem
							AddGadgetItem(#Gadget_Events, 0, "EditItem: "+Str(GetTabBarGadgetItemPosition(#Gadget_TabBar, #TabBarGadgetItem_Event)))
						Case #TabBarGadget_EventType_SwapItem
							AddGadgetItem(#Gadget_Events, 0, "SwapItem: "+Str(GetTabBarGadgetItemPosition(#Gadget_TabBar, #TabBarGadgetItem_Event)))
					EndSelect
					UpdateItemAttributes(GetItemGadgetState())
				Case #Gadget_CloseButton
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_CloseButton, GetGadgetState(#Gadget_CloseButton))
				Case #Gadget_SelectedCloseButton
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_SelectedCloseButton, GetGadgetState(#Gadget_SelectedCloseButton))
				Case #Gadget_EmptyButton
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_NewTab, GetGadgetState(#Gadget_EmptyButton))
				Case #Gadget_Vertical
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_Vertical, GetGadgetState(#Gadget_Vertical))
					Resize()
				Case #Gadget_MirroredTabs
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MirroredTabs, GetGadgetState(#Gadget_MirroredTabs))
				Case #Gadget_TextCutting
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_TextCutting, GetGadgetState(#Gadget_TextCutting))
				Case #Gadget_NoTabMoving
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_NoTabMoving, GetGadgetState(#Gadget_NoTabMoving))
				Case #Gadget_TabRounding
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_TabRounding, GetGadgetState(#Gadget_TabRounding))
				Case #Gadget_MultiLine
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MultiLine, GetGadgetState(#Gadget_MultiLine))
				Case #Gadget_BottomLine
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_BottomLine, GetGadgetState(#Gadget_BottomLine))
				Case #Gadget_Editable
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_Editable, GetGadgetState(#Gadget_Editable))
				Case #Gadget_MultiSelect
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MultiSelect, GetGadgetState(#Gadget_MultiSelect))
				Case #Gadget_CheckBox
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_CheckBox, GetGadgetState(#Gadget_CheckBox))
				Case #Gadget_ReverseOrdering
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_ReverseOrdering, GetGadgetState(#Gadget_ReverseOrdering))
				Case #Gadget_MinTabLength
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MinTabLength, GetGadgetState(#Gadget_MinTabLength))
				Case #Gadget_MaxTabLength
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_MaxTabLength, GetGadgetState(#Gadget_MaxTabLength))
				Case #Gadget_TabTextAlignment
					SetTabBarGadgetAttribute(#Gadget_TabBar, #TabBarGadget_TabTextAlignment, GetGadgetState(#Gadget_TabTextAlignment))
				Case #Gadget_Item
					SetGadgetText(#Gadget_ItemText, GetTabBarGadgetItemText(#Gadget_TabBar, GetItemGadgetState()))
					UpdateItemAttributes(GetItemGadgetState())
				Case #Gadget_ItemBackColor
					Color = GetTabBarGadgetItemColor(#Gadget_TabBar, GetTabBarGadgetState(#Gadget_TabBar), #PB_Gadget_BackColor)
					Color = ColorRequester(Color)
					If Color > -1
						SetTabBarGadgetItemColor(#Gadget_TabBar, GetItemGadgetState(), #PB_Gadget_BackColor, Color)
					EndIf
				Case #Gadget_ItemFrontColor
					Color = GetTabBarGadgetItemColor(#Gadget_TabBar, GetTabBarGadgetState(#Gadget_TabBar), #PB_Gadget_FrontColor)
					Color = ColorRequester(Color)
					If Color > -1
						SetTabBarGadgetItemColor(#Gadget_TabBar, GetItemGadgetState(), #PB_Gadget_FrontColor, Color)
					EndIf
				Case #Gadget_ItemText
					SetTabBarGadgetItemText(#Gadget_TabBar, GetItemGadgetState(), GetGadgetText(#Gadget_ItemText))
				Case #Gadget_ItemDisabled
					SetTabBarGadgetItemState(#Gadget_TabBar, GetItemGadgetState(), GetGadgetState(#Gadget_ItemDisabled)*#TabBarGadget_Disabled, #TabBarGadget_Disabled)
				Case #Gadget_ItemSelected
					SetTabBarGadgetItemState(#Gadget_TabBar, GetItemGadgetState(), GetGadgetState(#Gadget_ItemSelected)*#TabBarGadget_Selected, #TabBarGadget_Selected)
				Case #Gadget_ItemChecked
					SetTabBarGadgetItemState(#Gadget_TabBar, GetItemGadgetState(), GetGadgetState(#Gadget_ItemChecked)*#TabBarGadget_Checked, #TabBarGadget_Checked)
				Case #Gadget_ItemCloseButton
					SetTabBarGadgetItemAttribute(#Gadget_TabBar, GetItemGadgetState(), #TabBarGadget_CloseButton, GetGadgetState(#Gadget_ItemCloseButton))
				Case #Gadget_ItemCheckBox
					SetTabBarGadgetItemAttribute(#Gadget_TabBar, GetItemGadgetState(), #TabBarGadget_CheckBox, GetGadgetState(#Gadget_ItemCheckBox))
				Case #Gadget_ItemImage
					If GetGadgetState(#Gadget_ItemImage)
						FileName = OpenFileRequester("Image", "", "Images (*.bmp;*.png)|*.bmp;*.png", 0)
						If FileName And LoadImage(#Image, FileName)
							SetTabBarGadgetItemImage(#Gadget_TabBar, GetItemGadgetState(), ImageID(#Image))
						EndIf
					Else
						SetTabBarGadgetItemImage(#Gadget_TabBar, GetItemGadgetState(), #Null)
					EndIf
			EndSelect
			
	EndSelect
	
ForEver

; IDE Options = PureBasic 5.30 (Windows - x64)
; Folding = --
; EnableXP
; EnableCompileCount = 59
; EnableBuildCount = 0