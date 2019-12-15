; assign hotkey
; select & paste ?
; todo: bold current clipboard position

#SingleInstance ignore

menu, tray, icon, explorer.exe, 0

clipHistoryArr := Object()
maxTrayEntryLen := 60
maxHistSize := 20
clipHistoryEnabled = 1


;menu, tray, NoStandard

clipHistoryArr.InsertAt(1, clipboard)
updateMenu()

return

histEntry()
{
    index := A_ThisMenuItem
;    MsgBox, % index
    index := RegExReplace(index, "s)\. .*")
    index := RegExReplace(index, "&")
;    MsgBox, % "[[" . index . "]]"
    global clipHistoryArr
    clipboard = % clipHistoryArr[index]
}

cleanHistory()
{
    global clipHistoryArr
    global maxHistSize
    clipHistoryArr.RemoveAt(2, maxHistSize)
    updateMenu()
}

toggleEnabled()
{
    global clipHistoryEnabled
    if ( clipHistoryEnabled = 1 ) {
        clipHistoryEnabled = 0
    } else {
        clipHistoryEnabled = 1
    }
    updateMenu()
}

updateMenu()
{
    global maxTrayEntryLen
    global clipHistoryEnabled

    menu, tray, deleteAll
    menu, tray, add,
    menu, tray, add, clean history, cleanHistory
    menu, tray, add, enabled, toggleEnabled
    menu, tray, add,

    if ( clipHistoryEnabled = 1 ) {
        menu, tray, Check, enabled
    } else {
        menu, tray, Uncheck, enabled
    }

    global clipHistoryArr

    for index, element in clipHistoryArr {
        if ( StrLen(element) > maxTrayEntryLen ) {
            element := SubStr(element, 1, maxTrayEntryLen) . "..."
        }
        element := "&" . index . ". " . element,
        menu, tray, add, %element%,  histEntry
        if (index = 1 ) {
            ;element = % "** " . element . " **"
            ;menu tray, icon, % element, SHELL32.dll, 177
            menu tray, icon, % element, explorer.exe, 11
        }
    }
}

OnClipboardChange:
    if ( clipHistoryEnabled = 0 ) {
        return
    }
    if (A_EventInfo = 1) {
        ; remove duplicate if present
        for index, element in clipHistoryArr {
            if ( element = clipboard ) {
                clipHistoryArr.RemoveAt(index)
            }
        }

        clipHistoryArr.InsertAt(1, clipboard)
        if ( clipHistoryArr.maxIndex() > maxHistSize ) {
            clipHistoryArr.Pop()
        }
        updateMenu()
    }

return

Numpad1::Reload
return

Numpad3::menu, tray, show
