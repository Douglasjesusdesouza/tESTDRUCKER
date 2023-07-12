#------------------------------------------------------------------------
# Author: Douglas Jesus de Souza
# Description: This script performs a installation from network Printers.
#------------------------------------------------------------------------


#-----------------------------------
#Variablen
#-----------------------------------

#Zipfile-Name
$File = "Test.zip"

# Source URL
$url = "https://github.com/Douglasjesusdesouza/tESTDRUCKER/raw/main/CNP60MA64.zip"

# Destation file
$dest = "C:\Druckertreiber"

# Treiber Information File 
$inf = "CNP60MA64.INF"

# Treiber Name
$treiber = "Canon Generic Plus PCL6"

# Anschluss Name
$PrinterPort = "172.16.4.6"

# Drucker IP
$PrinterHost = "172.16.4.6"

# Drucker Name
$printname = "Test-Drucker"

#-----------------------------------
# Bereitstellung der Drucker treiber 
#-----------------------------------

# Create the destination folder
New-Item -ItemType Directory -Path $dest

# Download the file
Invoke-WebRequest -Uri $url -OutFile $dest\$File

Expand-Archive -Path $dest\$File -DestinationPath $dest

# Aufräumen: Entfernen der heruntergeladenen ZIP-Datei
Remove-Item "$dest\$File"

#-----------------------------------
# Treiber Installation 
#-----------------------------------

cd $dest

pnputil.exe /a $inf
Add-PrinterDriver -Name $treiber

#-----------------------------------
# Drucker Installation 
#-----------------------------------

Add-PrinterPort -Name $PrinterPort -PrinterHostAddress $PrinterHost
Add-Printer -DriverName $treiber -Name $printname -PortName $PrinterPort

#-----------------------------------
# Installation Dateien löschen
#-----------------------------------
# Aufräumen: Entfernen der heruntergeladenen Dateien

cd /
Remove-Item -Path $dest -Force -Recurse


# Inunte Install:
#powershell.exe -executionpolicy bypass -file .\Install-Printer.ps1 -PortName "Anschluss_Name" -PrinterIP "IP" -PrinterName "Drucker name" -DriverName "Treiber Name" -INFFile "Treiber Information File"

#Uninstall:
#powershell.exe -executionpolicy bypass -file .\DruckerBuHa.ps1 -PrinterName "DruckerBuHa"