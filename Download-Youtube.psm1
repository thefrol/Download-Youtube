function Remove-SpecialCharactersFromFiles {
    Get-ChildItem -file | %{
        $Name = $_.Name
        $NewName = $Name -creplace "(?:\uD83C[\uDF00-\uDFFF])|(?:\uD83D[\uDC00-\uDDFF])" -Replace '\P{IsBasicLatin}' -replace "'",'' 
        Rename-Item -Path $_ -NewName $NewName
    }
    
}

function Get-Youtube {
    param(
        [switch] $RemoveNonAscii
    )
    yt-dlp -f bv[height>=1000][vcodec^=avc][ext=mp4]+ba[ext=m4a]/bv[ext=mp4]+ba[ext=m4a]/b[ext=mp4] --remux mp4 $args
    yt-dlp -f bv+ba/b --recode mp4 $args

    if($RemoveNonAscii){
        Remove-SpecialCharactersFromFiles
    }
    
}
