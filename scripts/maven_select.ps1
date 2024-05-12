param ([string]$ver)

$maven_paths = @{
	"3.0.5" = "$Env:USERPROFILE\space\env\maven\3.0.5"
	"3.6.3" = "$Env:USERPROFILE\space\env\maven\3.6.3"
	"3.9.5" = "$Env:USERPROFILE\space\env\maven\3.9.5"
}

if ($ver -eq "") {
	$ver = $maven_paths.Keys | fzf
}

$maven_path = $maven_paths[$ver]

if ($null -ne $maven_path) {
	[System.Environment]::SetEnvironmentVariable("MAVEN_HOME", $maven_path, [System.EnvironmentVariableTarget]::User)
	Write-Output "select maven path: "  $maven_path
}


