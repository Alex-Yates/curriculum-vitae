param (
    $path = "C:/deleteme/CV_GitTree"
)

$ErrorActionPreference = "Stop" 

Write-Output "A little prep work..."

Write-Output "  Importing log from git-log.json"
$gitLog = Get-Content git-log.json | ConvertFrom-Json


if (Test-Path $path){
    Write-Output "  Deleting old working directory: $path"
    Remove-Item $path -Recurse -Force | Out-Null
}

Write-Output "  Creating new working directory: $path"
New-Item -ItemType Directory -Path $path | Out-Null

Write-Output "  Setting context to: $path"
Set-Location $path

Write-Output "  Verifying git is installed. (Prerequisite.)"
$gitVersion = & git version
if ($gitVersion -notlike "git version *"){
    Write-Error "ERROR: Git is either not installed, or not added to PATH."
}

Write-Output "  Initializing git repo"
& git init | Out-Null

Write-Output "Creating git log..."

foreach ($logItem in $gitLog.log) {

    # Creating new string variables helps when passing values to other commands 
    $branchName = $logItem.branch
    $commitMessage = $logItem.message
    $commitDescription = $logItem.description
    $commitDate = $logItem.date
    
    # If this is a new branch, create it.
    if ($logItem.action -like "branch"){
        Write-Output "    Creating new branch: $branchName"
        & git branch $branchName
    }
    
    # Switch branch if necessary
    $currentBranch = & git branch --show-current
    if (($currentBranch -notlike $branchName) -and ($logItem.action -notlike "merge")){
        Write-Output "    Checking out branch: $branchName"
        try {
            & (git checkout $branchName) -ErrorAction 'SilentlyContinue' # Required because git sends output to stderr :-(
        }
        catch {
            # The try block erroneously fails every time because git sends output to stderr.
            # This try/catch and the use of "-ErrorAction 'SilentlyContinue'" (above) is a hack around an annoying limitation in git.
        }
    }

    # Merge branch into main if necessary
    if ($logItem.action -like "merge") {
        Write-Output = "    Checking out main and merging from $branchName"
        try {
            & (git checkout main)  -ErrorAction 'SilentlyContinue' # Required because git sends output to stderr :-(
        }
        catch {
            # The try block erroneously fails every time because git sends output to stderr.
            # This try/catch and the use of "-ErrorAction 'SilentlyContinue'" (above) is a hack around an annoying limitation in git.
        }
        & git merge $branchName
        & git commit --amend -m "$commitMessage" -m "Description $commitDescription" | out-null
    }
    else {
        # Create some content
        Write-Output "  Adding content and committing with message: $commitMessage"
        $file = "$branchName" + ".md"
        if (!(Test-Path $file)){
            New-Item -ItemType File -Name $file | out-null
            Add-Content -Path $file -Value "`# $branchName"
        }
        Add-Content -Path $file -Value "`#`# $commitMessage"
        Add-Content -Path $file -Value "$commitDate"
        Add-Content -Path $file -Value "$commitDescription"
        Add-Content -Path $file -Value ""

        # Brief pause. Otherwise IO can't keep up, commits get out of sequence, and branch diagram gets messed up.
        Start-Sleep 1 # On my machine I can get away with 0.7, but any faster and it gets unreliable. 

        # Commit to git
        & git add . | out-null
        & git commit -m "$commitMessage" -m "Description $commitDescription" | out-null
    }
    & git commit --amend --date="$commitDate" --no-edit | out-null
}

Write-Output "FINISHED!"

