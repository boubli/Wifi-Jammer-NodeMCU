$path = "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\favicon.png"
$bytes = [System.IO.File]::ReadAllBytes($path)
$hex = $bytes | ForEach-Object { "0x{0:x2}" -f $_ }
$csv = $hex -join ","
"const static uint8_t data_favicon[] PROGMEM = {$csv};" | Out-File -Encoding ascii "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\favicon_hex.txt"
