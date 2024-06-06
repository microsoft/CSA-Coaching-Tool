# AUTH SNIPPETS
pac auth create --environment https://hlstechreviewdev.crm.dynamics.com/
pac auth create --environment https://hlstechreview.crm.dynamics.com/

pac auth list
pac auth who
pac auth select --index 4
# Environment variable values for saving
# MOCK channel ID: 19:9b3390f9b3ff4eb0821164774eeaae35@thread.tacv2
# general channel ID: 19:VZvuSWaqpI8YfBoCJ9wg5dMDhdIHaybmn6BgS7dzaZ41@thread.tacv2
# Curbside Consult channel: 19:d99148c5b25a47618ef63bdeed924468@thread.tacv2


# EXPORT SOLUTIONS
# Set these before running the script

$solutionDir = ".\Solutions\"
$solutionVersion = "2.0.0.10"
$newSolutionVersion = "2.0.0.11"
# $solutionName = "HackTrackerCore"
# $solutionName = "HackTrackerAdminApp"
# $solutionName = "HackTrackerSecurityRoles"
# $solutionName = "HackTrackerFlows"
$solutionName = "HackTrackerGuidedApps"

# The following commands execute the export using the variables above
pac auth select --index 2
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}.zip --name $solutionName --managed false
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip --name $solutionName --managed true
pac solution online-version --solution-name ${solutionName} --solution-version ${newSolutionVersion}

# Generate Settings File for environment variables
pac solution create-settings -z ${solutionDir}${solutionName}-${solutionVersion}.zip -s ${solutionDir}EnvSettings_1_1_0_16.json

# IMPORT MANAGED SOLUTION
# Set these before running the script

$solutionDir = ".\Solutions\"
$solutionVersion = "2.0.0.10"
# $solutionName = "HackTrackerCore"
# $solutionName = "HackTrackerAdminApp"
# $solutionName = "HackTrackerSecurityRoles"
# $solutionName = "HackTrackerFlows"
$solutionName = "HackTrackerGuidedApps"

# $settingsName = "EnvSettings.json"

# The following commands execute the export using the variables above
pac auth select --index 3
pac solution import --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip
# OR import with settings file
# pac solution import --path ${solutionDir}${solutionName}-${solutionVersion}_managed.zip --settings-file ${solutionDir}${settingsName}

# UNPACK SOLUTIONS
# Set these before running script

$solutionDir = ".\Solutions\"
$solutionVersion = "2.0.0.10"
# $solutionName = "HackTrackerCore"
# $solutionName = "HackTrackerAdminApp"
# $solutionName = "HackTrackerSecurityRoles"
# $solutionName = "HackTrackerFlows"
$solutionName = "HackTrackerGuidedApps"
$targetFolder = ".\Source\"

pac solution unpack --zipfile ${solutionDir}${solutionName}-${solutionVersion}.zip --folder ${targetFolder}

# SYNC DEV ENVIRONMENTS

# Import from Primary Dev to external sandbox
# Set these before running the script
pac auth create --url https://org3f9e0cf9.crm.dynamics.com/ --name ManagedAzureHackDev
$solutionDir = ".\Solutions\"
$solutionVersion = "1.0.0.6"
$solutionName = "HackTracker"
# The following commands execute the export using the variables above
pac solution import --path ${solutionDir}${solutionName}-${solutionVersion}.zip
pac solution publish --name $solutionName

# Export external dev sandbox
# Set these before running the script
pac auth create --url https://org3f9e0cf9.crm.dynamics.com/ --name ManagedAzureHackDev
$solutionDir = ".\Solutions\"
$solutionVersion = "1.0.0.0"
$solutionName = "Updatetoprimarydev"
# The following commands execute the export using the variables above
pac solution export --path ${solutionDir}${solutionName}-${solutionVersion}.zip --name $solutionName --managed false

# Import From Primary Dev to external sandbox
# Set these before running the script
pac auth create --url https://hlstechreviewdev.crm.dynamics.com/ --name TLCRevewBoardDev
$solutionDir = ".\Solutions\"
$solutionVersion = "1.0.0.0"
$solutionName = "Updatetoprimarydev"
# The following commands execute the export using the variables above
pac solution import --path ${solutionDir}${solutionName}-${solutionVersion}.zip
pac solution publish --name $solutionName