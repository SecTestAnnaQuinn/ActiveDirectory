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