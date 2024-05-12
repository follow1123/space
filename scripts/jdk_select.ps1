param ([string]$ver)

$jdk_paths = @{
	"1.5" = "$Env:USERPROFILE\space\env\jdk\1.5"
	"1.6" = "$Env:USERPROFILE\space\env\jdk\1.6"
	"1.7" = "$Env:USERPROFILE\space\env\jdk\1.7"
	"8" = "$Env:USERPROFILE\space\env\jdk\8"
	"11" = "$Env:USERPROFILE\space\env\jdk\11"
	"17" = "$Env:USERPROFILE\space\env\jdk\17"
	"21" = "$Env:USERPROFILE\space\env\jdk\21"
}

if ($ver -eq "") {
	$ver = $jdk_paths.Keys | fzf
}

$jdk_path = $jdk_paths[$ver]

if ($null -ne $jdk_path) {
	[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $jdk_path, [System.EnvironmentVariableTarget]::User)
	Write-Output "select jdk path: "  $jdk_path
}


