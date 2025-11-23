tell application "Microsoft PowerPoint" to activate

use scripting additions

set theDateTime to (do shell script "date -j +\"%F-%H-%M-%S\"") as text

set pdfName to "MMCL3-" & theDateTime

tell application "System Events"
    tell process "Microsoft PowerPoint"
        keystroke "e" using {command down, shift down}
        delay 1
        set the clipboard to pdfName
        keystroke "v" using command down
        delay 1
        click radio button 2 of radio group 1 of group 2 of sheet 1 of the front window -- press Best for printing
        delay 1
        key code 36  -- corresponds to the Enter key
        delay 3
    end tell
end tell

tell application "Warp" to activate

set commandString to "/path/to/crop_pdf.sh  /path/to/pdf" & pdfName & ".pdf /path/to/google_drive/MMCL3.pdf; rsync -av /path/to/pptx/MMCL32.pptx /path/to/google_drive/; "

tell application "System Events"
    tell process "Warp"
        set the clipboard to commandString
        keystroke "v" using command down
        delay 0.2
        key code 36
        delay 3
    end tell
end tell

tell application "Firefox" to activate