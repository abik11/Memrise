$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-MemriseLevelWords" {
    $directLink = 'http://www.memrise.com/course/498649/christmas-and-easter/3/'
    $indirectLink = '/course/498649/christmas-and-easter/3/'
    $wrongBase = "memrisecom"

    Context 'Result' {
        class SpoofElement{
            [string] $Class;
            [string] $innerText;

            SpoofElement($Class, $innerText){
                $this.Class = $Class
                $this.innerText = $innerText
            }
        }

        class SpoofResponse{
            [SpoofElement[]] $AllElements;
        }

        $element = [SpoofElement]::new('text', 'word1')
        $element2 = [SpoofElement]::new('other', 'word2')
        $resp = [SpoofResponse]::new()
        $resp.AllElements = @($element,$element2)

        Mock Invoke-WebRequest { $resp } -ParameterFilter { -not [String]::IsNullOrWhiteSpace($Href) } 
        Mock Invoke-WebRequest

        It "returns words for indirect link" {
            Get-MemriseLevelWords $indirectLink | Should Be 'word1'
        }
        It "returns words for direct link" {
            Get-MemriseLevelWords $directLink | Should Be 'word1'
        }
    }

    Context 'Web Request' {
        It "throws exception for wrong url" {
            { Get-MemriseLevelWords $indirectLink -BaseHref $wrongBase } | Should Throw
        }
        It "doesn't throw exception for correct indirect url" {
            { Get-MemriseLevelWords $indirectLink } | Should Not Throw
        }
        It "doesn't throw exception for correct direct url" {
            { Get-MemriseLevelWords $directLink } | Should Not Throw
        }
    }
}
