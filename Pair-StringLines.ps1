
#####################
# .SYNOPSIS
# Pair even and odd lines of given string
# .DESCRIPTION
# The Pair-StringLines function returns paired strings based on 
# the given list. It is using System.Text.StringBuilder class to 
# build final result. It accepts string array as well as separate 
# strings from pipeline.
# .EXAMPLE
# Pair-StringLines -Lines $stringLines
#####################
function Pair-StringLines{
    Param(
        # An array of strings to be paired
        [Parameter(mandatory=$true, ValueFromPipeline = $true, position = 0)] 
        [string[]]$Lines
    )
    Begin{
        $tmpLines = @()
    }
    Process{
        $tmpLines += $Lines
    }
    End {
        if($tmpLines.Count -eq 0){
            $tmpLines = $Lines
        }
        [System.Text.StringBuilder] $strBuilder = New-Object -TypeName System.Text.StringBuilder
        for($i = 0; $i -lt $tmpLines.Count; $i++)  { 
            if($i % 2 -eq 0){ 
                [void]$strBuilder.Append($tmpLines[$i]);
                [void]$strBuilder.Append(" - ");
                [void]$strBuilder.Append($tmpLines[$i+1]);
                [void]$strBuilder.AppendLine();
            } 
        }
        return $strBuilder.ToString()
    }
}
