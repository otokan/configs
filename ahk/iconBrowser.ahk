


getIconCount(dll_name) {
    menu tmpmenu, add, tmplabel, getIconCount
    Loop {
        try {
            menu tmpmenu, icon, tmplabel, %dll_name%, %A_Index%
        }
        catch e
        {
            return % A_Index - 1
        }
    }
}

;menu tray, NoStandard
menu tray, add

dll_name = explorer.exe
size = 35

max := getIconCount(dll_name)


mainMenuLoop:
Loop {
    i := % A_Index - 1
    name := % "menu_" . (i*size) . "-" . (i+1)*size - 1
    Loop, %size% {
        ii := % A_Index - 1
        currentI := % i * size + ii
        menu %name%, add, %currentI%, histEntry
        try {
            menu %name%, icon, %currentI%, %dll_name%, %currentI%
        } catch {
            menu, tray, add, % ":"name
            break mainMenuLoop
        }
    }
    menu, tray, add, % ":"name
}
histEntry()
{

}
return

Numpad2::
    Reload
return
