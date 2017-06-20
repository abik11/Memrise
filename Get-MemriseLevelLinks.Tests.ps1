$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-MemriseLevelLinks" {
    $wrongLink = 'aaa'
    $correctLink = 'http://www.memrise.com/course/79389/learn-basic-spanish/'

    Context 'Result' {
        $expectedHref = '/course/1098043/spanish-spain-1/1/'

        class SpoofElement{
            [string] $Class;
            [string] $TagName;
            [string] $Href;

            SpoofElement([string] $Class, [string] $TagName, [string] $Href){
                $this.Class = $Class
                $this.Href = $Href
                $this.TagName = $Tagname
            }
        }

        class SpoofResponse{
            [SpoofElement[]] $AllElements;
        }

        $element = [SpoofElement]::new('level clearfix', 'A', $expectedHref)
        $element2 = [SpoofElement]::new('menu', 'A', '/home')
        $element3 = [SpoofElement]::new('right', 'div', '')
        $resp = [SpoofResponse]::new()
        $resp.AllElements = @($element,$element2,$element3)

        Mock Invoke-WebRequest { $resp } -ParameterFilter { -not [String]::IsNullOrWhiteSpace($Href) } 
        Mock Invoke-WebRequest

        It 'returns links' {
            Get-MemriseLevelLinks '/course/79389/learn-basic-spanish/' | Should Be $expectedHref
        }
    }

    Context 'Web Request' {
        It "throws exception for wrong url" {
            { Get-MemriseLevelLinks $wrongLink } | Should Throw
        }
        It "doesn't throw exception for correct url" {
            { Get-MemriseLevelLinks $correctLink } | Should Not Throw
        }
    }
}
