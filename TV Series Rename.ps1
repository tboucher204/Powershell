﻿$srcFolder = "Y:\Videos\Kids TV Series\Tom and Jerry\Season 1960"
$myfile = ""
$count = 1

$files = Get-ChildItem -Path $srcFolder -Recurse -Filter *.mp4

Function Extract-String {
    Param(
        [Parameter(Mandatory=$true)][string]$string
        , [Parameter(Mandatory=$true)][char]$character
        , [Parameter(Mandatory=$false)][ValidateSet("Right","Left")][string]$range
        , [Parameter(Mandatory=$false)][int]$afternumber
        , [Parameter(Mandatory=$false)][int]$tonumber
    )
    Process
    {
        [string]$return = ""

        if ($range -eq "Right")
        {
            $return = $string.Split("$character")[($string.Length - $string.Replace("$character","").Length)]
        }
        elseif ($range -eq "Left")
        {
            $return = $string.Split("$character")[0]
        }
        elseif ($tonumber -ne 0)
        {
            for ($i = $afternumber; $i -le ($afternumber + $tonumber); $i++)
            {
                $return += $string.Split("$character")[$i]
            }
        }
        else
        {
            $return = $string.Split("$character")[$afternumber]
        }

        return $return
    }
}

foreach ($f in $files) {
    $myfullpath = $f.FullName
    $myfile = $f.Name
    # Just Prepend
    #$mytempfile = $myfile
    # Everything left of the - (dash)
    #$mytempfile = Extract-String -string $myfile -character "-" -range Left
    # Everything right of the - (dash)
    $mytempfile = Extract-String -string $myfile -character "-" -range Right
    $episode = $count.tostring("00")
    $mynewfile = "S1960E$episode - $mytempfile"
    #$mynewfile = "$myfile"
    #$currentFolder = $f.DirectoryName
    "File $myfile will be renamed to $mynewfile"
    Rename-Item -LiteralPath $myfullpath $mynewfile
 
    $count++
    
}