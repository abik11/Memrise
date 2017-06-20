$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-MemriseCourseNameFromLink" {
    $link = "/course/498649/christmas-and-easter/"
    It "retruns course name from given link" {
        Get-MemriseCourseNameFromLink $link | Should Be "christmas-and-easter"
    }
}
