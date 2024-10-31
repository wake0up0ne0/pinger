# Continuous ping with a beep if response time is larger than 100ms

$Target = "8.8.8.8"      # Ping target
$Threshold = 100          # Response time threshold in milliseconds

# Infinite loop to run continuous ping
while ($true) {
    try {
        # Ping the target address and capture the response time
        $PingResult = Test-Connection -ComputerName $Target -Count 1 -ErrorAction Stop

        # Extract the round trip time from the result
        $ResponseTime = $PingResult.ResponseTime

        # Output ping result to the console
        Write-Host "Response from ${Target}: ${ResponseTime} ms"

        # Check if the response time exceeds threshold
        if ($ResponseTime -gt $Threshold) {
            # If response time is larger than threshold, make a beep sound
            [console]::beep()
        }

        # Wait for 1 second before next ping attempt
        Start-Sleep -Seconds 1

    } catch {
        # If there is an error in communication (e.g., timeout), log it and retry
        Write-Host "Ping failed. Retrying..."
        Start-Sleep -Seconds 1
    }
}
