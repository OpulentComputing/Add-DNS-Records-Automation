<#
Daily Virtual Machine & Network Report
Created by Nick Conder Opulent Computing
Add DNS A Records. This PowerShell script is to be used in combination with a CSV file produced by other scripts in an automation environment. 
Change Log:
v1.0
#>
$DNSServer = "dns.server.com"
$DNSServer2 = "dns.server2.com"
$Zone1 = "your.zone.local"
$Zone2 = "your.2ndzone.local"
$CSVFile = "\\path\to\your\CSVfile.csv"
#$dailyreport = "d:\scripts\dns\VMBNInfo.csv"
#insert dns record vars
$HostName = "$($_.HostName)" 
$addr = $_.IPAddress -split "\." 
#$rzone = "$($addr[2]).$($addr[1]).$($addr[0]).in-addr.arpa"

If (Test-Connection -ComputerName $DNSServer -Quiet) {
    Import-Csv $CSVFile | ForEach-Object {
    #Create DNS A entries 
    $dnsinsert = dnscmd $DNSServer /recordadd $Zone1 "$($_.HostName)-BN" /createptr A "$($_.RecordData)" 
    write-output $dnsinsert

    }
}

ElseIf (Test-Connection -ComputerName $DNSServer2 -Quiet) {
    Import-Csv $CSVFile | ForEach-Object { 
    #Create DNS A entries 
    $dnsinsert2 = dnscmd $DNSServer2 /recordadd $Zone1 "$($_.HostName)-BN" /createptr A "$($_.RecordData)" 

    }
}
