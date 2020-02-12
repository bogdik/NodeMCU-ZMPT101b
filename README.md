# VOLTAGE MONITORING WEB SERVER USING NodeMCU + ZMPT101b

NodeMCU on Lua firmware

Installation
Download Firmware NodeMCU-Lua-3.0.0.0 for NodeMcu Lua on Release page and unpack
1. Install firmware
On Linux or Windows you may use Python via esptool.py
- ```python esptool.py --port /dev/ttyUSB0 write_flash -fm qio 0x00000 ./NodeMCU-Lua-3.0.0.0/0x00000.bin``` (or ```--port COM1``` on Windows)

- `python esptool.py --port /dev/ttyUSB0 write_flash -fm qio 0x10000 ./NodeMCU-Lua-3.0.0.0/0x10000.bin` (or ```--port COM1``` on Windows)

On Windows you may use https://github.com/nodemcu/nodemcu-flasher
<img src="https://sun9-57.userapi.com/c205524/v205524303/65db6/l4RdqCIr7_Y.jpg" width="440" alt="">

2. After install firmware download all .lua files on this repository
On Linux or Windows you may use Python and luatool.py
- ```python luatool.py --port /dev/ttyUSB0 --src init.lua --verbose --baud 115200``` (or ```--port COM1``` on Windows)
.... upload all .lua files to NodeMCU

On Windows you may use java tool ESPlorer https://esp8266.ru/esplorer/
<img src="https://sun9-41.userapi.com/c205524/v205524303/65e40/9Au7r4cVBVs.jpg" width="440" alt="">
...upload all .lua files to NodeMCU

3. Connect ZMPT101b to NodeMCU

           ACC      -  3v3
           
           OUT      -  A0
           
           GND      -  GND
           
           
<img src="https://sun9-3.userapi.com/c857736/v857736303/17cddf/Spgf9f1h2sY.jpg" width="440" alt="">

4. After upload and connect on first start NodeMCU create AP with name ```Volt AP``` connect to this AP and open http://192.168.4.1:888/config

5. After config you may get information on http://yourip:888/ in JSON format

If need reset to default just push flash button 10 second
P.S: Thanks for start info and source https://www.esp8266.com/viewtopic.php?t=9848
