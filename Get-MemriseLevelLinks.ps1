
#####################
# .SYNOPSIS
# Get all level links for given memrise course.
# .DESCRIPTION
# The Get-MemriseLevelsLinks function returns all level links for given memrise course. 
# It looks for HTML <a> tags with specified CSS class. It is recommended to use default 
# class name. It returns indirect links, ex. /course/12345/course-name/1/, so you need 
# to add base to such link to make it useful.
# .EXAMPLE
# "http://www.memrise.com/course/79389/learn-basic-spanish/" | Get-MemriseLevelLinks
#####################
function Get-MemriseLevelLinks {
    Param(
        # Direct link to memrise course
        [Parameter(mandatory=$true, ValueFromPipeline=$true, position = 0)]
        [string] $Href, 
        # CSS class that will be used to look for level links, it is recommended to leave the deafault value 
        [string] $LinkClass = 'level clearfix'
    )
    Process{
        $response = Invoke-WebRequest $Href
        $links = $response.AllElements | Where-Object { $_.tagName -eq 'A' -and $_.class -match $LinkClass }
        $links.href     
    } 
}
