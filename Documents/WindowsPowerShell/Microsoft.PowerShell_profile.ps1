$env:FZF_DEFAULT_OPTS='--height 80% --layout=reverse'

# Disable default aliases
Remove-Item alias:curl

# Aliases
Set-Alias -Name sed -Value sd
Set-Alias -Name sudo -Value gsudo

function cc ([string]$command){
	if ($arg1) {
		Get-Command | Select-Object Name | Format-Table -HideTableHeaders | fzf -q $command | Invoke-Expression
	} else {
		Get-Command | Select-Object Name | Format-Table -HideTableHeaders | fzf | Invoke-Expression	
	}
}

function zz ([string]$location) {
	if ($location) {
		es /ad -path . | fzf -q $location | Set-Location
	} else {
		es /ad -path . | fzf | Set-Location
	}
}

function ff ([string]$file) {
	if ($file) {
		micro $(fzf -q $file --preview 'bat --style=numbers --color=always --line-range :500 {}')
	}
	else {
		micro $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
	}
}

function hh {
	$Array = Get-Content (Get-PSReadlineOption).HistorySavePath
	$Length = $Array.count
	$Line = 1
	1..$Length | ForEach-Object {$Array[-$Line]; $Line++} | fzf | Invoke-Expression
}
