function FileToHex($path, $varName) {
    if (-not (Test-Path $path)) { return "" }
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $hex = $bytes | ForEach-Object { "0x{0:x2}" -f $_ }
    $csv = $hex -join ","
    return "const static uint8_t $varName[] PROGMEM = {$csv};"
}

$header = @"
#ifndef data_h
#define data_h

static uint8_t data_macBuffer;
static char data_vendorBuffer;
static String data_vendorStrBuffer = "";

static char data_websiteBuffer[6000];

/*
I used the program memory (https://www.arduino.cc/en/Reference/PROGMEM) so I don't need an external SD card reader to hold the HTML files and the very ling vendor list.
Alternatively you could use the SPIFFS memory on the ESP8266: https://github.com/esp8266/Arduino/blob/master/doc/filesystem.md#file-system-object-spiffs

The HTML files are minified and converted into bytes.
For files larger then 6000 bytes change the size of data_websiteBuffer.
The vendor list contains 11 bytes per row. The first 3 bytes are the beginning mac adress and the other 8 are the vendorname.
*/

const static char data_error404[] PROGMEM = "<html><head><meta charset='utf-8'></head><body><h1>ERROR 404</h1><p>¯\\_(ツ)_/¯ </p></body></html>";
"@

$css = FileToHex "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\style.css" "data_styleCSS"
$js = FileToHex "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\functions.js" "data_functionsJS"
$index = FileToHex "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\index.html" "data_indexHTML"
$clients = FileToHex "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\clients.html" "data_clientsHTML"
$attack = FileToHex "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\attack.html" "data_attackHTML"
$favicon = FileToHex "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\htmlfiles\favicon.png" "data_favicon"

$functions = @"

String data_getVendor(uint8_t first,uint8_t second,uint8_t third){
  data_vendorStrBuffer = "";
  
  for(int i=0;i<sizeof(data_vendors)/11;i++){

    data_macBuffer = pgm_read_byte_near(data_vendors + i*11 + 0);
    if(data_macBuffer == first){
      data_macBuffer = pgm_read_byte_near(data_vendors + i*11 + 1);
      if(data_macBuffer == second){
        data_macBuffer = pgm_read_byte_near(data_vendors + i*11 + 2);
        if(data_macBuffer == third){

          for(int h=0;h<8;h++){
            data_vendorBuffer = (char)pgm_read_byte_near(data_vendors + i*11 + 3 + h);
            if(data_vendorBuffer != 0x00) data_vendorStrBuffer += data_vendorBuffer;
          }
          return data_vendorStrBuffer;
        }

      }
    }

  }

  return data_vendorStrBuffer;
}

char* data_getIndexHTML(){
  int _size = sizeof(data_indexHTML);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_indexHTML + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

char* data_get404(){
  int _size = sizeof(data_error404);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_error404 + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

char* data_getStyle(){
  int _size = sizeof(data_styleCSS);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_styleCSS + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

char* data_getFunctionsJS(){
  int _size = sizeof(data_functionsJS);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_functionsJS + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

char* data_getClientsHTML(){
  int _size = sizeof(data_clientsHTML);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_clientsHTML + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

char* data_getAttackHTML(){
  int _size = sizeof(data_attackHTML);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_attackHTML + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

char* data_getFavicon(){
  int _size = sizeof(data_favicon);
  for(int i=0;i<sizeof(data_websiteBuffer);i++){
    if(i<_size) data_websiteBuffer[i] = pgm_read_byte_near(data_favicon + i);
    else data_websiteBuffer[i] = 0x00;
  }
  return data_websiteBuffer;
}

int data_getFaviconSize(){
  return sizeof(data_favicon);
}

//source: https://forum.arduino.cc/index.php?topic=38107.0
void PrintHex8(uint8_t *data, uint8_t length){
  Serial.print("0x");
  for (int i=0; i<length; i++) {
    if (data[i]<0x10) {Serial.print("0");}
    Serial.print(data[i],HEX);
    Serial.print(" ");
  }
}

void getRandomVendorMac(uint8_t *buf){
  int _macRandom = random(sizeof(data_vendors)/11);
  for(int h=0;h<3;h++) buf[h] = pgm_read_byte_near(data_vendors + _macRandom*11 + h);
  for(int h=0;h<3;h++) buf[h+3] = random(255);
}
"@

$originalData = Get-Content "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\esp8266_deauther\data.h"
$vendorStart = 0
for ($i = 0; $i -lt $originalData.Count; $i++) {
    if ($originalData[$i] -match "const static uint8_t data_vendors\[\] PROGMEM") {
        $vendorStart = $i
        break
    }
}

if ($vendorStart -gt 0) {
    # Extract only the data_vendors array part.
    # We look for the ending '};' which marks the end of the array.
    # The functions usually come after.
    
    $vendorLines = $originalData[$vendorStart..($originalData.Count - 1)]
    $endOfArray = 0
    for ($k = 0; $k -lt $vendorLines.Count; $k++) {
        if ($vendorLines[$k].Trim() -eq "};") {
            $endOfArray = $k
            break
        }
    }
    
    if ($endOfArray -gt 0) {
        $vendorsArrayOnly = $vendorLines[0..$endOfArray] -join "`n"
        $fullContent = $newContent + "`n" + $vendorsArrayOnly + "`n" + $functions + "`n#endif`n"
        $fullContent | Out-File -Encoding utf8 "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\esp8266_deauther\data.h"
        Write-Host "data.h updated successfully with functions."
    }
    else {
        # Fallback: if we can't find clear end, but we know functions start with 'String data_getVendor'
        # Try to find that
        $funcStart = 0
        for ($k = 0; $k -lt $vendorLines.Count; $k++) {
            if ($vendorLines[$k] -match "^String data_getVendor") {
                $funcStart = $k
                break
            }
        }
        
        if ($funcStart -gt 0) {
            $vendorsArrayOnly = $vendorLines[0..($funcStart - 1)] -join "`n"
            $fullContent = $newContent + "`n" + $vendorsArrayOnly + "`n" + $functions + "`n#endif`n"
            $fullContent | Out-File -Encoding utf8 "c:\Users\bbbvl\OneDrive\Desktop\Wifi-Jammer-NodeMCU\esp8266_deauther\data.h"
            Write-Host "data.h updated successfully (split by function start)."
        }
        else {
            Write-Host "Could not find end of array or start of functions. Current data.h might be corrupted or in unexpected format."
        }
    }
}
else {
    Write-Host "Could not find vendor list in data.h!"
}
