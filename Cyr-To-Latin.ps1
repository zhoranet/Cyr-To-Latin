param (

    [string]$Directory = "c:\temp"
)

$cv = @{
    " "="_";
    ";"="";
    "а"="a";
    "б"="b";
    "в"="v";
    "г"="g";
    "д"="d";
    "е"="e";
    "ё"="yo";
    "ж"="zh";
    "з"="z";
    "и"="i";
    "й"="y";
    "к"="k";
    "л"="l";
    "м"="m";
    "н"="n";
    "о"="o";
    "п"="p";
    "р"="r";
    "с"="s";
    "т"="t";
    "у"="u";
    "ф"="f";
    "х"="h";
    "ц"="c";
    "ч"="ch";
    "ш"="sh";
    "щ"="shch";
    "ъ"="y";
    "ы"="y";
    "ь"="_";
    "э"="e";
    "ю"="yu";
    "я"="ya";
    

}


function Rename() {

    param(
        [Parameter(Position=0, ValueFromPipeline=$true)]
        [object]$item
    )

    begin {
        Write-Host "Starting..."
    }

    process {
        $newName = $null
        foreach ($char in $item.Name.ToCharArray()) {            
            if($cv.ContainsKey([string]$char)) {
                $newChar = $cv[[string]$char]
            }
            else {
                $newChar = $char
            }

            $newName += $newChar
        }

        $folderPath = Split-Path $item.FullName

        $newName = $folderPath + "\" + $newName

        Rename-Item $item.FullName $newName

        Write-Host $newName

    }

    end {
        Write-Host "Finished..."
    }    
}

function GetItems([string]$dir) {
    $names = Get-ChildItem -path $dir -Recurse | Select 
    $firstCode = [int][char]"а"
    foreach($name in $names) {
        $textName = $name.Name.ToLower()
        foreach ($char in $textName.ToCharArray()) {            
            $code = [int][char]$char
            if($code -ge $firstCode) {
                Write-Output $name
                break
            }
        }        
    }
}

function Main() {
    
    GetItems -dir $Directory | Rename
}

Main

exit 1