# Adding Domain Users to Active Directory

1. 
    - Create ad_schema.json
    - Explore options for creating users within the json file

2. Use the following code to pull json data within Powerpoint as a test

```shell
Get-content .\ad_schema.json |ConvertFrom-Json
```
3. Create a powershell script gen_ad.ps1 to start the automation process, including the code above in an attempt to get user data from json easily.

4. Reverse engineer ps1 script using vulnAD script, setting variables to match our own cases.

5. Many problems were had along the way due to hand typing and misreading, but eventually we come up with the finished script present in gen_ad.ps1

## Running the Script

1. First we have to copy the files over to the AD DC.  We can do this by first setting the `$dc` variable within powershell on the workstation to reach the dc with the following code: `$dc = New-PSSession *ip_address_of_dc* -Credential (Get-Credential)`

2. After doing this we can copy the needed files with the following lines: `cp *path_to_local_file* -ToSession $dc *desired_output_path*`

3. 
    - Once the files are placed appropriately on the machine we remote in to the machine by using `Enter-PSSession *PSSession number*` and navigate to the path containing the ps1 and json files
    - We can then run the script by typing `.\gen_ad.ps1 .\ad_schema.json` Which runs the Powershell script, using the json file as input.
    - The script then runs without any issue, adding the users and groups successfully to AD.

4. From this point on, we add many more users and groups to the domain to successfully imitate a small business.

