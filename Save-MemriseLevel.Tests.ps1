$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Save-MemriseLevel" {
    It "creates a file with correct name" {
        $outDir = 'TestDrive:\spanish'
        mkdir $outDir

        Mock Get-MemriseLevelWords { $true } 
        Mock Pair-StringLines { $true }

        '/course/1098043/spanish-spain-1/1/' | Save-MemriseLevel -OutputDir $outDir
        "$outDir\1.txt" | Should Exist
    }
    It "creates a file for each link" {
        $outDir = 'TestDrive:\spanish2'
        mkdir $outDir

        Mock Get-MemriseLevelWords { $true } 
        Mock Pair-StringLines { $true }

        '/course/1098043/spanish-spain-1/2/', `
        '/course/310896/spanish-things-around-you/1/', `
        '/course/480106/society-11/4/' `
            | Save-MemriseLevel -OutputDir $outDir
        (ls $outDir).Count | Should Be 3
    }
}
