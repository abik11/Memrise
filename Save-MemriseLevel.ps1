
#####################
# .SYNOPSIS
# The Save-MemriseLevel function saves words in specified level to file.
# .DESCRIPTION
# The Save-MemriseLevel function gets words for given level link, put them 
# into pairs and saves to file. File names start from 1 and are incremented
# for each file. It is a good idea to rather use Save-MemriseCourse to save
# the whole course with levels rather than saving each level separately.
# .EXAMPLE
# '/course/310896/spanish-things-around-you/1/' | Save-MemriseCourse 
#####################
function Save-MemriseLevel{
    Param(
        # Link to level, may be indirect like /course/310896/spanish-things-around-you/1/ or direct with domain name
        [Parameter(mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [string] $Href,
        # Directory where to put file with words
        [Parameter(position = 1)]
        [string] $OutputDir = '.'
    )
    Begin {
        $i = 1
    }
    Process {
        $Href | Get-MemriseLevelWords | Pair-StringLines >> "$OutputDir\$i.txt"
        $i++
    }
}
