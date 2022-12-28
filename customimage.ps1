$response = Invoke-RestMethod -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/' `
                              -Headers @{Metadata="true"}
$access_token = $response.access_token

#echo "The managed identities for Azure resources access token is $access_token"

$headers = New-Object 'System.Collections.Generic.Dictionary[[String],[String]]'
    $headers.Add('Authorization',"Bearer $access_token")
    $headers.Add('x-ms-version', '2019-12-12')
    
Write-Host 'Install FSLogix 2210 Public Preview'
Invoke-RestMethod -Uri 'https://avdmsimages.blob.core.windows.net/aadauthearlyrelease/FSLogix_Apps_2.9.8308.44092.zip' -Headers $headers -OutFile 'c:\BuildArtifacts\fslogix-2210-preview.zip' -Verbose
Start-Sleep -Seconds 10
Expand-Archive -Path 'c:\BuildArtifacts\fslogix-2210-preview.zip' -DestinationPath 'c:\BuildArtifacts\fslogix-2210-preview\'  -Force -Verbose
