
#####################
# .SYNOPSIS
# The Save-MemriseCourse function saves all the levels in specified course to files.
# .DESCRIPTION
# The Save-MemriseCourse function takes title of the given course from the given url.
# It creates a directory for this course if it doesn't exist. It calls Save-MemriseLevel
# function for every level link found for the course.
# .EXAMPLE
# 'http://www.memrise.com/course/310896/spanish-things-around-you/' | Save-MemriseCourse -OutputDir 'courses'
#####################
function Save-MemriseCourse{
    Param(
        # Direct link to memrise course
        [Parameter(mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [string] $Href,
        # Directory where to put all levels with words, ex. C:\courses, MyFiles\Courses etc.
        [Parameter(position = 1)]
        [Alias('Out', 'O')]
        [string] $OutputDir = '.'
    )
    Process {
        $title = $Href | Get-MemriseCourseNameFromLink
        if(-not (Test-Path "$OutputDir\$title")){
            New-Item "$OutputDir\$title" -ItemType Directory 
        }
        $Href | Get-MemriseLevelLinks | Save-MemriseLevel -OutputDir "$OutputDir\$title"    
    }
}
