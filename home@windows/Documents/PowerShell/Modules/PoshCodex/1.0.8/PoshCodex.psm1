### --- PUBLIC FUNCTIONS --- ###
#Region - Enter-CompletionKeybind.ps1
#Requires -Modules PSReadLine

# Asks for user input (reads key combinations), calls internal functions to convert to string and set it as the new keybind
function Enter-CompletionKeybind {
	# Add cmdletBinding to the parameter list
	[CmdletBinding()]
	param()

	Write-Host "Press any key or combination (Ctrl, Alt, Shift + other keys) to set the new keybind for PoshCodex. Press 'Escape' to exit."
	# Read the key press
	$key = [System.Console]::ReadKey($true)
	$new_autocomplete_keybind = Convert-KeyPressToString $key
	if ($null -eq $new_autocomplete_keybind) {
		# exit, no input given (user pressed Escape).
		return
	}

	# get old keybind, call set keybind for new 
	$old_autocomplete_keybind = [Environment]::GetEnvironmentVariable('AUTOCOMPLETE_KEYBIND', 'User')
	Set-CompletionKeybind $old_autocomplete_keybind $new_autocomplete_keybind
	Write-Host "New keybind set: $([Environment]::GetEnvironmentVariable('AUTOCOMPLETE_KEYBIND', 'User'))"
}
Export-ModuleMember -Function Enter-CompletionKeybind
#EndRegion - Enter-CompletionKeybind.ps1
### --- PRIVATE FUNCTIONS --- ###
#Region - Convert-KeyPressToString.ps1
#Requires -Modules PSReadLine

# Function to convert a user input key press into a keybind string
function Convert-KeyPressToString {
	# Add cmdletBinding to the parameter list
	[CmdletBinding()]
	param($key)

	# First, check and append Ctrl if it's pressed
	if ($key.Modifiers -band [ConsoleModifiers]::Control) {
		$keybind += 'Ctrl+'
	}

	# Next, check and append Alt if it's pressed
	if ($key.Modifiers -band [ConsoleModifiers]::Alt) {
		$keybind += 'Alt+'
	}

	# Lastly, check and append Shift if it's pressed
	if ($key.Modifiers -band [ConsoleModifiers]::Shift) {
		$keybind += 'Shift+'
	}

	# Append the actual key that was pressed
	$keybind += $key.Key.ToString()

	# Display the keybind string
	# Write-Host "Keybind entered: $keybind"

	# If the Escape key is pressed, exit the loop
	if ($key.Key -eq 'Escape') {
		Write-Host 'Aborted by user, exiting...'
		return
	}

	$keybind
}
#EndRegion - Convert-KeyPressToString.ps1
#Region - Invoke-OllamaApi.ps1
function Invoke-OllamaApi {
	[CmdletBinding()]
	param (
		$BUFFER
	)

	$ollama_model = [Environment]::GetEnvironmentVariable('OLLAMA_MODEL', 'User')
	$ollama_host = [Environment]::GetEnvironmentVariable('OLLAMA_HOST', 'User')

	$data = @{
		model  = "$ollama_model"
		prompt = $BUFFER
		stream = $false
	}

	$splatRestMethod = @{
		Method      = 'POST'
		Uri         = "$ollama_host/api/generate"
		Body        = ConvertTo-Json -InputObject $data
		ContentType = 'application/json; charset=utf-8'
	}
	Invoke-RestMethod @splatRestMethod
}
#EndRegion - Invoke-OllamaApi.ps1
#Region - Set-CompletionKeybind.ps1
#Requires -Modules PSReadLine

# Function to simply handle the setting and removal of keybinds, without worrying about the user input.
function Set-CompletionKeybind {
	# Add cmdletBinding to the parameter list
	[CmdletBinding()]
	param(
		$old_keybind, $new_keybind
	)

	if ($null -ne $old_keybind) {
		# unset current handler for Write-Completion if it exists
		Remove-PSReadLineKeyHandler -Chord $old_keybind
		Write-Host "Previous keybind removed: $old_keybind"
	}

	$splatKeyHandler = @{
		Chord            = $new_keybind
		BriefDescription = 'Write-Completion'
		Description      = 'Autocomplete the command'
		ScriptBlock      = { Write-Completion }
	}
	Set-PSReadLineKeyHandler @splatKeyHandler

	# Update env var with new keybind
	[Environment]::SetEnvironmentVariable('AUTOCOMPLETE_KEYBIND', $new_keybind, [EnvironmentVariableTarget]::User)
}
#EndRegion - Set-CompletionKeybind.ps1
#Region - Write-Completion.ps1
#Requires -Modules PSReadLine

function Write-Completion {
	# Add cmdletBinding to the parameter list
	[CmdletBinding()]
	param()

	$BUFFER = $null
	$cursor = $null

	# read text from current buffer
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$BUFFER, [ref]$cursor)

	# If the buffer text itself contains double quotes, then we need to escape them.
	$BUFFER = $BUFFER.Replace('"', '""')

	$json_output = Invoke-OllamaApi $BUFFER

	# check if json_output is not equal to null
	if ($null -ne $json_output) {
		$completion = $json_output.response

		# Insert the completion on the next line. This will NOT cause the command to be executed.
		[Microsoft.PowerShell.PSConsoleReadLine]::InsertLineBelow();
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert($completion)
	}
	else {
		Write-Host 'Response returned by API is null! It could be an internal error or the model is not installed properly through Ollama. Please fix and try again.' -ForegroundColor Red
	}
}
#EndRegion - Write-Completion.ps1
## Set necessary environment variables:

[Environment]::SetEnvironmentVariable('OLLAMA_HOST', 'http://localhost:11434', [EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable('OLLAMA_MODEL', 'rishi255/posh_codex_model', [EnvironmentVariableTarget]::User)

$current_keybind = [Environment]::GetEnvironmentVariable('AUTOCOMPLETE_KEYBIND', 'User')

$default_keybind = if ([String]::IsNullOrWhiteSpace($current_keybind)) {
	## Use default keybind, if none is set
	'Ctrl+Shift+O'
}
else {
	## Use existing keybind
	$current_keybind
}
Set-CompletionKeybind $null $default_keybind

## Check if Ollama is installed in the user or system PATH
if (Get-Command -Name 'ollama' -CommandType 'Application' -ErrorAction Ignore) {
	## Check if Ollama is running
	if (-not (Get-Process -Name 'ollama' -ErrorAction Ignore)) {
		## Start Ollama if it's not running
		Start-Process -FilePath 'ollama' -ArgumentList 'serve' -WindowStyle Hidden
	}
} else {
	Write-Warning 'Ollama is not installed or not in the user or system PATH.'
	Write-Warning 'Please follow the instructions at "https://github.com/rishi255/posh_codex#configuration-of-the-ollama-model" and re-import the module.'
}
