# AUTH SNIPPETS
pac auth create --environment https://hlstechreviewdev.crm.dynamics.com/ --name 'Tech Review Dev'
pac auth create --environment https://hlstechreview.crm.dynamics.com/ --name 'Tech Review Prod'
Write-Host "Starting Core Solution Deployment..."
# EXPORT SOLUTIONS
$solutionDir = ".\Solutions\"
$solutionVersion = "2.0.0.15"
$newSolutionVersion = "2.0.0.16"
$solutionName = "HackTrackerCore"
# The following commands execute the export using the variables above
pac auth select --name 'Tech Review Dev'
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}.zip --name $solutionName --managed false
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip --name $solutionName --managed true
pac solution online-version --solution-name ${solutionName} --solution-version ${newSolutionVersion}
# IMPORT MANAGED SOLUTION
# The following commands execute the export using the variables above
pac auth select --name 'Tech Review Prod'
pac solution import --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip
# UNPACK SOLUTIONS
$targetFolder = ".\Source\"
pac solution unpack --zipfile ${solutionDir}${solutionName}-${solutionVersion}.zip --folder ${targetFolder}
############################################################################################################
Write-Host "Starting Flow Solution Deployment..."
# EXPORT SOLUTIONS
$solutionDir = ".\Solutions\"
$solutionVersion = "2.0.0.4"
$newSolutionVersion = "2.0.0.5"
$solutionName = "HackTrackerFlows"
# The following commands execute the export using the variables above
pac auth select --name 'Tech Review Dev'
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}.zip --name $solutionName --managed false
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip --name $solutionName --managed true
pac solution online-version --solution-name ${solutionName} --solution-version ${newSolutionVersion}
# IMPORT MANAGED SOLUTION
# The following commands execute the export using the variables above
pac auth select --name 'Tech Review Prod'
pac solution import --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip
# UNPACK SOLUTIONS
$targetFolder = ".\Source\"
pac solution unpack --zipfile ${solutionDir}${solutionName}-${solutionVersion}.zip --folder ${targetFolder}
