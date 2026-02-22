<p align="center">
<img src="misc/misa.png" width="200" />
</p>
<h1 align="center">MISA</h1>

<p align="center">
68k SBC somewhat inspired by the lisa and mac
</p>

- MC68HC000P* (at 2/4/8MHz)
- 1MB ROM
- 1MB RAM
- PLD for glue
- UART
- Keyboard
- CF card
- Video
- Audio?

### Docs

[68000 Hardware Manual](https://bitsavers.org/pdf/peripheralTechnology/68000_Hardware_Manual.pdf)

[M68000 User's Manual](https://www.nxp.com/docs/en/reference-manual/MC68000UM.pdf)

### BOM

| Ref | Part | Qty | Package | Mouser | Digikey | Datasheet |
|---|---|---|---|---|---|---|
||MC68HC000|1|64DIP|||[Datasheet](https://igspgm.com/repairs/MC68HC000.pdf)|
||AS6C4008-55PCN|2|32DIP|[Link](https://www.mouser.fi/ProductDetail/Alliance-Memory/AS6C4008-55PCN?qs=E5c5%252Bmu3i3%252BMOyro1Tlhzg%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/alliance-memory-inc/AS6C4008-55PCN/4234586)|[Datasheet](https://eu.mouser.com/datasheet/3/893/1/AS6C4008.pdf)|
||SST39SF040|2|32DIP|[Link](https://www.mouser.fi/ProductDetail/Microchip-Technology/SST39SF040-70-4C-PHE?qs=YClUa%252B2dcx1pgizrqJ6nyQ%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/microchip-technology/SST39SF040-70-4C-PHE/2297835)|[Datasheet](https://ww1.microchip.com/downloads/aemDocuments/documents/MPD/ProductDocuments/DataSheets/SST39SF010A-SST39SF020A-SST39SF040-Data-Sheet-DS20005022.pdf)|
||ATF1508AS|1|100TQFP|[Link](https://www.mouser.fi/ProductDetail/Microchip-Technology/ATF1508AS-7AX100?qs=fH4tvdCgwtMKHDTA5tqoNQ%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/microchip-technology/ATF1508AS-10AU100/1008404)|[Datasheet](https://ww1.microchip.com/downloads/en/DeviceDoc/doc0784.pdf)|
||TL16C550DPTR|1|48LQFP|[Link](https://www.mouser.fi/ProductDetail/Texas-Instruments/TL16C550DPTR?qs=odmYgEirbwzSWeapb8dmmw%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/texas-instruments/TL16C550DPTR/1674664)|[Datasheet](https://www.ti.com/lit/ds/symlink/tl16c550d.pdf)|
||NE555P|1|8DIP|[Link](https://www.mouser.fi/ProductDetail/Texas-Instruments/NE555P?qs=rkhjVJ6%2F3EIf4CWgjIKuKQ%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/texas-instruments/NE555P/277057)|[Datasheet](https://www.ti.com/lit/ds/symlink/se555.pdf?HQS=dis-dk-null-digikeymode-dsf-pf-null-wwe&ts=1771745013638&ref_url=https%253A%252F%252Fwww.ti.com%252Fgeneral%252Fdocs%252Fsuppproductinfo.tsp%253FdistId%253D10%2526gotoUrl%253Dhttps%253A%252F%252Fwww.ti.com%252Flit%252Fgpn%252Fse555)|
||SN74HC05N|1|14DIP|[Link](https://www.mouser.fi/ProductDetail/Texas-Instruments/SN74HC05N?qs=sGAEpiMZZMutXGli8Ay4kImb8xrn%2FL%252BvBszT6sVCOTE%3D)|[Link](https://www.digikey.fi/en/products/detail/texas-instruments/SN74HC05N/277214)|[Datasheet](https://www.ti.com/lit/ds/symlink/sn74hc05.pdf?HQS=dis-dk-null-digikeymode-dsf-pf-null-wwe&ts=1771768334330&ref_url=https%253A%252F%252Fwww.ti.com%252Fgeneral%252Fdocs%252Fsuppproductinfo.tsp%253FdistId%253D10%2526gotoUrl%253Dhttps%253A%252F%252Fwww.ti.com%252Flit%252Fgpn%252Fsn74hc05)|
||SN74HCT74N|1|14DIP|[Link](https://www.mouser.fi/ProductDetail/Texas-Instruments/SN74HCT74N?qs=VuX40u8tcuDJWxEji9hndw%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/texas-instruments/SN74HCT74N/277271)|[Datasheet](https://www.ti.com/lit/ds/symlink/sn74hct74.pdf?HQS=dis-dk-null-digikeymode-dsf-pf-null-wwe&ts=1771757308194&ref_url=https%253A%252F%252Fwww.ti.com%252Fgeneral%252Fdocs%252Fsuppproductinfo.tsp%253FdistId%253D10%2526gotoUrl%253Dhttps%253A%252F%252Fwww.ti.com%252Flit%252Fgpn%252Fsn74hct74)|
||8MHz oscillator|1|8DIP|[Link](https://www.mouser.fi/ProductDetail/ECS/ECS-2100AX-8.0MHZ?qs=A9ALx0kupCL3HHwFXlJ9sQ%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/cts-frequency-controls/MXO45HS-3C-8M000000/1801858)|[Datasheet](https://www.ctscorp.com/Files/DataSheets/Passives/FCP/Clock-Oscillators/clock-ocillators-MXO45_MXO45HS-datasheet.pdf)|
||1.8432MHz oscillator|1|8DIP|[Link](https://www.mouser.fi/ProductDetail/ECS/ECS-2100AX-1.8432MHZ?qs=7cQpS2oZOEMv8URpRm%2FrTg%3D%3D)|[Link](https://www.digikey.fi/en/products/detail/cts-frequency-controls/MXO45HS-3C-1M843200/1801859)|[Datasheet](https://www.ctscorp.com/Files/DataSheets/Passives/FCP/Clock-Oscillators/clock-ocillators-MXO45_MXO45HS-datasheet.pdf)|

### Memory map

| Region | Start | End | Size | Notes |
|---|---|---|---|---|
| ROM | 0x00000000 | 0x000FFFFF | 1 MiB | 2x SST39SF040 in parallel |
| RAM | 0x00100000 | 0x001FFFFF | 1 MiB | 2x AS6C4008 in parallel |
| I/O | 0x00E00000 | 0x00E0FFFF | 64 KiB | UART, IDE/CF, keyboard, video, spare |
| Reserved | Everything else | - | - | For expansion |

### I/O submap

| Device | CS | Start | End | Size | Notes |
|---|---|---|---|---|---|
| UART | UART_CS | 0x00E00000 | 0x00E00FFF | 4 KiB | A0-A2, D0-D7 |
| IDE / CF | IDE_CS0 / IDE_CS1 | 0x00R01000 | 0x00E01FFF | 4 KiB | CF/IDE command + control block |
| Keyboard | KBD_CS | 0x00E02000 | 0x00E0_2FFF | 4 KiB | DATA/STATUS/CONTROL keyboard interface |
| Video | VID_CS | 0x00E03000 | - | - | Framebuffer window or video controller registers |
| Spare | - | - | - | - | - |
