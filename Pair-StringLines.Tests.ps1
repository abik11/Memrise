$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Pair-StringLines" {
    [string[]] $lines = @("a", "b")
    [System.Text.StringBuilder] $strBuilder = New-Object -TypeName System.Text.StringBuilder
    $strBuilder.Append("a")
    $strBuilder.Append(" - ")
    $strBuilder.AppendLine("b")

    It "returns paired string" {
        Pair-StringLines $lines | Should Be $strBuilder.ToString()
    }
}
