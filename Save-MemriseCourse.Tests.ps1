$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Save-MemriseCourse" {
    It "creates directory for each course" {
        $level = '/course/1098043/spanish-spain-1/1/'
        $outDir = 'TestDrive:\courses'
        mkdir $outDir

        Mock Get-MemriseLevelLinks { @($level) }
        Mock Save-MemriseLevel { $true }

        'http://memrise.com/course/1098043/spanish-spain-1/', `
        'http://memrise.com/course/310896/spanish-things-around-you/', `
        'http://memrise.com/course/480106/society-11/' `
            | Save-MemriseCourse -OutputDir $outDir

        (ls $outDir).Count | Should Be 3
    }
}
