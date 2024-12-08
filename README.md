# ADC_model
### VHDL Project - Development of a simplified model for the ADC AD7475
<br/>

For this project, the developed entity of the treated ADC is defined below:
- SCLK : Clock employed for data transactions. If maintained to 1, means no data transactions in the moment. For a data transaction in progress, the CLK generates X pulses depending on the data width.
- CSN : CHIP-SELECT bit. When the transactions are being performed, this bit is set to 0. If not, it is set to 1.
- SDATA : Logic bit employed for the data transactions. Can vary between 0 or 1 for the X bits of the data width in each CLK period, and when there are no transactions, is set to Z (low-impedance).

<br/>
The graphical way or transactions performed is given below (AD7475 Datasheet):
<br/>
<br/>

![Captura de pantalla 2024-12-08 142919](https://github.com/user-attachments/assets/e3570d4a-a9c0-43fc-8500-991b81bcbdfe)

<br/>
The data width bits are specified through the 'data_w' constant in the MODEL PACKAGE. This model automatically performs all the required operations needed for the ADC to be employed. The message width is always set to _4bits + data_w_, as to set the given requirements for the ADC model employed, for which the nominal data length is of 12 bits. The CLK period employed for this program was of 20ns, although it can be changed if desired.
<br/>

The instructions used for the ADC are also given through a VHDL pseudo-code file, where there are only 4 CHARACTERS per line read, representing the voltage value (analogic varying between 0.00V to 2.50V) to be converted to digital. An example of pseudo-code file would be the following:
<br/>
<br/>

"
     <br/>
2.33 <br/>
1.59 <br/>
1.15 <br/>
2.50 <br/>
ENDF <br/>
"

The final result for the project is then showed in the next figure:
<br/>
<br/>

![Captura de pantalla 2024-12-08 143848](https://github.com/user-attachments/assets/2ddbb3dc-656b-4787-a0b8-f0f272c0c497)

