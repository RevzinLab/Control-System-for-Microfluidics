EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Amplifier_Operational:MCP6002-xP U3
U 1 1 60E38475
P 5700 3850
F 0 "U3" H 5700 3483 50  0000 C CNN
F 1 "MCP6002-xP" H 5700 3574 50  0000 C CNN
F 2 "MCP6002:MCP6002" H 5700 3850 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 5700 3850 50  0001 C CNN
	1    5700 3850
	1    0    0    1   
$EndComp
$Comp
L Transistor_Array:ULN2801A U4
U 1 1 60E3EC6E
P 7850 3200
F 0 "U4" H 7850 3767 50  0000 C CNN
F 1 "ULN2801A" H 7850 3676 50  0000 C CNN
F 2 "ULN2803A:ULN2803A" H 7900 2550 50  0001 L CNN
F 3 "http://www.promelec.ru/pdf/1536.pdf" H 7950 3000 50  0001 C CNN
	1    7850 3200
	1    0    0    -1  
$EndComp
$Comp
L Transistor_Array:ULN2801A U5
U 1 1 60E42312
P 7850 4800
F 0 "U5" H 7850 5367 50  0000 C CNN
F 1 "ULN2801A" H 7850 5276 50  0000 C CNN
F 2 "ULN2803A:ULN2803A" H 7900 4150 50  0001 L CNN
F 3 "http://www.promelec.ru/pdf/1536.pdf" H 7950 4600 50  0001 C CNN
	1    7850 4800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x12_Male J3
U 1 1 60E43FDF
P 6600 3950
F 0 "J3" H 6708 4631 50  0000 C CNN
F 1 "Conn_01x12_Male" H 6708 4540 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x06-1MP_P2.54mm_Latch6.5mm_Vertical" H 6600 3950 50  0001 C CNN
F 3 "~" H 6600 3950 50  0001 C CNN
	1    6600 3950
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x12_Male J4
U 1 1 60E41A63
P 9100 4050
F 0 "J4" H 9208 4731 50  0000 C CNN
F 1 "Conn_01x12_Male" H 9208 4640 50  0000 C CNN
F 2 "TerminalBlock_4Ucon:TerminalBlock_4Ucon_1x12_P3.50mm_Vertical" H 9100 4050 50  0001 C CNN
F 3 "~" H 9100 4050 50  0001 C CNN
	1    9100 4050
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 60E4280F
P 4850 4000
F 0 "R2" V 5050 3950 50  0000 L CNN
F 1 "10k" V 4950 3950 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4780 4000 50  0001 C CNN
F 3 "~" H 4850 4000 50  0001 C CNN
	1    4850 4000
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 60E44B73
P 5200 4300
F 0 "R3" H 5270 4346 50  0000 L CNN
F 1 "1M" H 5270 4255 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5130 4300 50  0001 C CNN
F 3 "~" H 5200 4300 50  0001 C CNN
	1    5200 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 60E45074
P 5650 3150
F 0 "R4" V 5443 3150 50  0000 C CNN
F 1 "1M" V 5534 3150 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5580 3150 50  0001 C CNN
F 3 "~" H 5650 3150 50  0001 C CNN
	1    5650 3150
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 60E4546B
P 4550 4700
F 0 "C2" H 4665 4746 50  0000 L CNN
F 1 "C" H 4665 4655 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_Tantal_D4.5mm_P5.00mm" H 4588 4550 50  0001 C CNN
F 3 "~" H 4550 4700 50  0001 C CNN
	1    4550 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 60E4631D
P 3200 4750
F 0 "C1" H 3315 4796 50  0000 L CNN
F 1 "C" H 3315 4705 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_Tantal_D4.5mm_P5.00mm" H 3238 4600 50  0001 C CNN
F 3 "~" H 3200 4750 50  0001 C CNN
	1    3200 4750
	1    0    0    -1  
$EndComp
$Comp
L MPX2200DP:MPX2200DP U1
U 1 1 60E466B5
P 3800 3850
F 0 "U1" H 3800 4125 50  0000 C CNN
F 1 "MPX2200DP" H 3800 4034 50  0000 C CNN
F 2 "MPXSensors:MPX2200DP" H 3800 3900 50  0001 C CNN
F 3 "" H 3800 3900 50  0001 C CNN
	1    3800 3850
	1    0    0    1   
$EndComp
$Comp
L MPX2200DP:MPX5050DP U2
U 1 1 60E46BDF
P 3850 4850
F 0 "U2" H 3850 5125 50  0000 C CNN
F 1 "MPX5050DP" H 3850 5034 50  0000 C CNN
F 2 "MPXSensors:MPX5050DP" H 3850 4700 50  0001 C CNN
F 3 "" H 3850 4700 50  0001 C CNN
	1    3850 4850
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 60E47896
P 1850 5000
F 0 "J1" H 1958 5281 50  0000 C CNN
F 1 "Conn_01x04_Male" H 1958 5190 50  0000 C CNN
F 2 "TerminalBlock_4Ucon:TerminalBlock_4Ucon_1x04_P3.50mm_Vertical" H 1850 5000 50  0001 C CNN
F 3 "~" H 1850 5000 50  0001 C CNN
	1    1850 5000
	1    0    0    -1  
$EndComp
Text Notes 6250 4750 0    50   ~ 0
Arduino Digital \n(22-33)
Text Notes 9250 3300 2    50   ~ 0
Solenoid
Text Notes 1800 5650 0    50   ~ 0
Arduino Analog \n(0,1)
Text Notes 1800 5450 0    50   ~ 0
Arduino DC\n(1+,2-)
Wire Wire Line
	2500 3100 2500 3900
Wire Wire Line
	2500 3900 3450 3900
Wire Wire Line
	2500 2900 2800 2900
Wire Wire Line
	2800 2900 2800 3800
Wire Wire Line
	2800 3800 3450 3800
$Comp
L Device:R R1
U 1 1 60E4492E
P 4850 3700
F 0 "R1" V 5050 3650 50  0000 L CNN
F 1 "10k" V 4950 3650 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4780 3700 50  0001 C CNN
F 3 "~" H 4850 3700 50  0001 C CNN
	1    4850 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4150 3700 4150 3800
Wire Wire Line
	4150 3700 4700 3700
Wire Wire Line
	5000 3700 5000 3750
Wire Wire Line
	5000 3750 5200 3750
Wire Wire Line
	4150 3900 4150 4000
Wire Wire Line
	4150 4000 4700 4000
Wire Wire Line
	5000 4000 5000 3950
Wire Wire Line
	5000 3950 5200 3950
Wire Wire Line
	5200 4150 5200 3950
Connection ~ 5200 3950
Wire Wire Line
	5200 3950 5400 3950
Wire Wire Line
	5500 3150 5200 3150
Wire Wire Line
	5200 3150 5200 3750
Connection ~ 5200 3750
Wire Wire Line
	5200 3750 5400 3750
Wire Wire Line
	5800 3150 6000 3150
Wire Wire Line
	6000 3150 6000 3850
$Comp
L Connector:Jack-DC J2
U 1 1 60E4D1FA
P 2200 3000
F 0 "J2" H 2257 3325 50  0000 C CNN
F 1 "Jack-DC" H 2257 3234 50  0000 C CNN
F 2 "MI-179PH:MI-179PH" H 2250 2960 50  0001 C CNN
F 3 "~" H 2250 2960 50  0001 C CNN
	1    2200 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 5000 2500 5000
Wire Wire Line
	2500 5000 2500 4550
Connection ~ 2500 3900
Wire Wire Line
	2050 4900 3200 4900
Wire Wire Line
	5200 4450 2500 4450
Connection ~ 2500 4450
Wire Wire Line
	2500 4450 2500 3900
Wire Wire Line
	2800 2900 2800 2550
Wire Wire Line
	8250 2550 8250 2900
Connection ~ 2800 2900
Wire Wire Line
	6800 3450 7050 3450
Wire Wire Line
	7050 3450 7050 3000
Wire Wire Line
	7050 3000 7450 3000
Wire Wire Line
	6800 3550 7100 3550
Wire Wire Line
	7100 3550 7100 3100
Wire Wire Line
	7100 3100 7450 3100
Wire Wire Line
	6800 3650 7150 3650
Wire Wire Line
	7150 3650 7150 3200
Wire Wire Line
	7150 3200 7450 3200
Wire Wire Line
	6800 3750 7200 3750
Wire Wire Line
	7200 3750 7200 3300
Wire Wire Line
	7200 3300 7450 3300
Wire Wire Line
	6800 3850 7250 3850
Wire Wire Line
	7250 3850 7250 3400
Wire Wire Line
	7250 3400 7450 3400
Wire Wire Line
	6800 3950 7300 3950
Wire Wire Line
	7300 3950 7300 3500
Wire Wire Line
	7300 3500 7450 3500
Wire Wire Line
	6800 4050 7350 4050
Wire Wire Line
	7350 4050 7350 3600
Wire Wire Line
	7350 3600 7450 3600
Wire Wire Line
	6800 4150 7350 4150
Wire Wire Line
	7350 4150 7350 4600
Wire Wire Line
	7350 4600 7450 4600
Wire Wire Line
	6800 4250 7300 4250
Wire Wire Line
	7300 4250 7300 4700
Wire Wire Line
	7300 4700 7450 4700
Wire Wire Line
	6800 4350 7250 4350
Wire Wire Line
	7250 4350 7250 4800
Wire Wire Line
	7250 4800 7450 4800
Wire Wire Line
	6800 4450 7200 4450
Wire Wire Line
	7200 4450 7200 4900
Wire Wire Line
	7200 4900 7450 4900
Wire Wire Line
	6800 4550 7150 4550
Wire Wire Line
	7150 4550 7150 5000
Wire Wire Line
	7150 5000 7450 5000
Wire Wire Line
	2500 4550 3200 4550
Wire Wire Line
	6200 3900 7850 3900
Connection ~ 2500 4550
Wire Wire Line
	2500 4550 2500 4450
Wire Wire Line
	6200 5500 7850 5500
Wire Wire Line
	8650 3000 8250 3000
Wire Wire Line
	8600 3100 8250 3100
Wire Wire Line
	8350 3600 8250 3600
Wire Wire Line
	8350 4050 8350 3600
Wire Wire Line
	8900 4050 8350 4050
Wire Wire Line
	8400 3500 8250 3500
Wire Wire Line
	8400 3950 8400 3500
Wire Wire Line
	8900 3950 8400 3950
Wire Wire Line
	8450 3400 8250 3400
Wire Wire Line
	8450 3850 8450 3400
Wire Wire Line
	8900 3850 8450 3850
Wire Wire Line
	8500 3300 8250 3300
Wire Wire Line
	8500 3750 8500 3300
Wire Wire Line
	8900 3750 8500 3750
Wire Wire Line
	8600 3550 8600 3100
Wire Wire Line
	8900 3550 8600 3550
Wire Wire Line
	8650 3450 8650 3000
Wire Wire Line
	8900 3450 8650 3450
Wire Wire Line
	8550 3200 8550 3650
Wire Wire Line
	8550 3650 8900 3650
Wire Wire Line
	8250 3200 8550 3200
Wire Wire Line
	8900 4150 8350 4150
Wire Wire Line
	8350 4150 8350 4600
Wire Wire Line
	8350 4600 8250 4600
Wire Wire Line
	8900 4250 8400 4250
Wire Wire Line
	8400 4250 8400 4700
Wire Wire Line
	8400 4700 8250 4700
Wire Wire Line
	8900 4350 8450 4350
Wire Wire Line
	8450 4350 8450 4800
Wire Wire Line
	8450 4800 8250 4800
Wire Wire Line
	8900 4450 8500 4450
Wire Wire Line
	8500 4450 8500 4900
Wire Wire Line
	8500 4900 8250 4900
Wire Wire Line
	8900 4550 8550 4550
Wire Wire Line
	8550 4550 8550 5000
Wire Wire Line
	8550 5000 8250 5000
Wire Wire Line
	8250 4500 8300 4500
Wire Wire Line
	8300 2550 8250 2550
Connection ~ 3200 4900
Wire Wire Line
	3200 4900 3500 4900
Wire Wire Line
	3200 4600 3200 4550
Connection ~ 3200 4550
Wire Wire Line
	3200 4550 3500 4550
Wire Wire Line
	3500 4800 3500 4550
Connection ~ 3500 4550
Wire Wire Line
	4200 4850 4550 4850
Wire Wire Line
	3500 4550 4550 4550
Wire Wire Line
	6200 3900 6200 4550
Wire Wire Line
	4550 4550 6200 4550
Connection ~ 4550 4550
Connection ~ 6200 4550
Wire Wire Line
	6200 4550 6200 5500
Wire Wire Line
	2800 2550 8250 2550
Connection ~ 8250 2550
Wire Wire Line
	8300 2550 8300 4500
Wire Wire Line
	4550 4850 4550 5200
Wire Wire Line
	4550 5200 2050 5200
Connection ~ 4550 4850
Wire Wire Line
	6000 3850 6000 5100
Wire Wire Line
	6000 5100 2050 5100
Connection ~ 6000 3850
$EndSCHEMATC
