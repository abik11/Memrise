
#####################
# .SYNOPSIS
# The Get-MemriseCourseNameFromLink function retrives course name from given link.
# .DESCRIPTION
# The Get-MemriseCourseNameFromLink retrives course name from given link. It splits 
# given link by "/" sign and takes last element. Link doesn't have to contain domain
# base name.
# .EXAMPLE
# "/course/498649/christmas-and-easter/" | Get-MemriseCourseNameFromLink
#####################
function Get-MemriseCourseNameFromLink {
    Param(
        # Memrise course link
        [Parameter(mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [string] $Href  
    )
    Process {
        $Href -split '/' | Where-Object { ![String]::IsNullOrWhiteSpace($_) } | Select-Object -Last 1
    } 
}
