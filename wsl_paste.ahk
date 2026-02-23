#Requires AutoHotkey v2.0

; Works ONLY when the active window is Windows Terminal
#HotIf WinActive("ahk_exe WindowsTerminal.exe")
$^v:: {
    ; 1. If the clipboard has TEXT (not an image) – do a normal paste
    if (A_Clipboard != "") {
        Send("^{v}")
        return
    }

    ; 2. If there's no text, look for the screenshots folder
    userProfile := EnvGet("USERPROFILE")
    
    paths := [
        userProfile "\Pictures\Screenshots",
        userProfile "\OneDrive\Pictures\Screenshots",
        userProfile "\OneDrive - Personal\Pictures\Screenshots"
    ]

    validDir := ""
    for index, dir in paths {
        if DirExist(dir) {
            validDir := dir
            break
        }
    }

    if (validDir = "") {
        Send("^{v}")
        return
    }

    ; 3. Find the most recent screenshot
    latestFile := ""
    latestTime := ""

    Loop Files, validDir "\*.png" {
        if (latestTime = "" || A_LoopFileTimeModified > latestTime) {
            latestTime := A_LoopFileTimeModified
            latestFile := A_LoopFilePath
        }
    }

    ; 4. Perform a "real" paste
    if (latestFile != "") {
        drive := StrLower(SubStr(latestFile, 1, 1))
        rest := StrReplace(SubStr(latestFile, 3), "\", "/")
        wslPath := "/mnt/" drive rest

        ; Save whatever is currently in the clipboard (image)
        savedClip := ClipboardAll()
        
        ; Temporarily put the ready-made path text into the clipboard
        A_Clipboard := wslPath
        Sleep(50) ; Give the system a tiny moment to update
        
        ; Do the actual paste (Claude Code will recognize this as a full path and turn it into [image#1])
        Send("^{v}")
        
        ; Wait a bit and restore the image back to the clipboard
        Sleep(150)
        A_Clipboard := savedClip
    } else {
        Send("^{v}")
    }
}
#HotIf