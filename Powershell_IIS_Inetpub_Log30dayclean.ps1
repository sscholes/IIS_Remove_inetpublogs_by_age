# S.SCHOLES 
# Date 22/11/2022
# 
# Script to remove IIS log files older than 30 days 
# Example folder 
# $Folder = "W3SVC1"
# $Folder = "W3SVC2"


$IISLogDir = 'W:\inetpub\logs\LogFiles\W3SVC2'

[int] $DaysOfHistoryToKeep = 30
$PastDate = (Get-Date).AddDays((-1 * $DaysOfHistoryToKeep)) # 30 days ago, cached
Get-ChildItem -Path "$IISLogDir\*.log" | # originally I had -LiteralPath $IISLogDir -Include "*.log"
    # Where-Object { $_.Name -match '^u_ex\d+\.log$' } |
    Where-Object { -not $_.PSIsContainer } | # target only files in a PSv2-compatible way
    Sort-Object -Property LastWriteTime |
    #Select-Object -Skip 5 | # "Comment in" to keep the five oldest logs...
    Where-Object { $_.LastWriteTime -lt $PastDate } |
    Remove-Item #-WhatIf