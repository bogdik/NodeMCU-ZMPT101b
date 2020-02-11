# NodeMCU + ZMPT101b

NodeMCU on Lua firmware

Installation
Download Firmware NodeMCU-Lua-3.0.0.0 for NodeMcu Lua on Release page and unpack
1. Install firmware
On Linux or Windows you may use Python via esptool.py
- ```python esptool.py --port /dev/ttyUSB0 write_flash -fm qio 0x00000 ./NodeMCU-Lua-3.0.0.0/0x00000.bin``` (or ```--port COM1``` on Windows)

- `python esptool.py --port /dev/ttyUSB0 write_flash -fm qio 0x10000 ./NodeMCU-Lua-3.0.0.0/0x10000.bin` (or ```--port COM1``` on Windows)

On Windows you may use https://github.com/nodemcu/nodemcu-flasher
<img src="https://sun9-57.userapi.com/c205524/v205524303/65db6/l4RdqCIr7_Y.jpg" width="440" alt="">

