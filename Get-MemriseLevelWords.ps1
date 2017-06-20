
#####################
# .SYNOPSIS
# Get all words in given level of memrise course.
# .DESCRIPTION
# The Get-MemriseLevelWords function returns all words from given level of memrise 
# course. It looks for all elements with specified CSS class. It is recommended to 
# use default class name. Level links can be direct or indirect (without domain). 
# All indirect links are converted to direct with given domain. It is recommended to 
# use default domain.
# .EXAMPLE
# "/course/498649/christmas-and-easter/3/" | Get-MemriseLevelWords
#####################
function Get-MemriseLevelWords {
    Param(
        # Direct or indirect link to memrise course level
        [Parameter(mandatory=$true, ValueFromPipeline=$true, position=0)]
        [string] $Href, 
        # CSS class that will be used to look for words in a level, it is recommended to leave the deafault value
        [string] $WordClass = 'text',
        # Domain name of memrise, it is recommended to leave the deafault value
        [string] $BaseHref = 'http://www.memrise.com'    
    )
    Process{
        if($Href.StartsWith('/course')){
            $Href = $BaseHref + $Href
        }
        $response = Invoke-WebRequest $Href
        $response.AllElements | Where-Object { $_.Class -eq $WordClass } `
            | Select-Object innerText | ForEach-Object { $_.innerText } 
    }
}
