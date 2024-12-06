#BLOCKING PORTS WITH FIREWALL RULES
function Block-Port {
    param (
        [int]$Port
    )

    # Define rule names
    $ruleNameInbound = "Block Port $Port - Inbound"
    $ruleNameOutbound = "Block Port $Port - Outbound"

    # Create Inbound Rule
    New-NetFirewallRule -DisplayName $ruleNameInbound 
                         -Direction Inbound 
                         -Action Block 
                         -Protocol TCP 
                         -LocalPort $Port 
                         -Profile Any 
                         -Description "Blocks TCP traffic on port $Port for inbound connections" 
                         -ErrorAction Stop

    # Create Outbound Rule
    New-NetFirewallRule -DisplayName $ruleNameOutbound 
                         -Direction Outbound 
                         -Action Block 
                         -Protocol TCP 
                         -LocalPort $Port 
                         -Profile Any 
                         -Description "Blocks TCP traffic on port $Port for outbound connections" 
                         -ErrorAction Stop

    Write-Output "Successfully blocked port $Port for inbound and outbound traffic."
}

Script starts here
try {
    Write-Host "Enter the port number you want to block:" -ForegroundColor Yellow
    $portToBlock = Read-Host "Port Number"

    if ([int]::TryParse($portToBlock, [ref]$null) -and $portToBlock -gt 0 -and $portToBlock -lt 65536) {
        Block-Port -Port [int]$portToBlock
    } else {
        Write-Host "Invalid port number. Please enter a valid port between 1 and 65535." -ForegroundColor Red
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}