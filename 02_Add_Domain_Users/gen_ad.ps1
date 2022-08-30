param( [Parameter(Mandatory=$true)] $JSONFile)

function CreateADGroup(){
    param( [Parameter(Mandatory=$true)] $groupObject )
        
        $name = $groupObject.name 
        New-ADGroup -name $name -GroupScope Global
    }


function CreateADUser (){
    param( [Parameter(Mandatory=$true)] $userObject)
    #Pull name from userobject
    $name = $userObject.name
    $password = $userObject.password

    #Generate a "first initial, last name1" structure
    $firstname, $lastname = $name.Split(" ")
    $username = ($name[0] + $name.Split(" ")[1]).ToLower()
    $samAccountName = $username
    $principalname = $username

    #Create AD User Object
     New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $samAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -force) -PassThru | Enable-ADAccount 
    
     #add user to appropriate groups
     foreach($group_name in $userObject.groups) {

            try {
                Get-ADGroup -Identity "$group_name"
                Add-ADGroupMember -Identity $group_name -Members $username
            }
            catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
                {
                    Write-Warning "User $name NOT added to $group_name. Group object not found"
                }
     }

    echo $userObject
}
 

$json = ( Get-Content $JSONFile | ConvertFrom-Json )

$Global:Domain = $json.domain

foreach ($group in $json.groups ){
    CreateADGroup $group
}
foreach ( $user in $json.users ){
    CreateADUser $user
}