* File: NAND2.pex.sp
* Created: Tue Oct 29 23:04:04 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "NAND2.pex.sp.pex"
.subckt NAND2  OUT GND! VDD! VA VB
* 
* VB	VB
* VA	VA
* VDD!	VDD!
* GND!	GND!
* OUT	OUT
XD0_noxref N_GND!_D0_noxref_pos N_VDD!_D0_noxref_neg DIODENWX  AREA=7.92762e-12
+ PERIM=1.1316e-05
XMMN0 N_OUT_MMN0_d N_VA_MMN0_g NET12 N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=7.65e-13 AS=6.63e-13 PD=4.3e-06 PS=2.48e-06 NRD=0.131765
+ NRS=0.229412 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=4.5e-07
+ SB=1.293e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN1 NET12 N_VB_MMN1_g N_GND!_MMN1_s N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=6.63e-13 AS=7.667e-13 PD=2.48e-06 PS=4.302e-06 NRD=0.229412
+ NRS=0.132353 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.292e-06
+ SB=4.51e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMP0 N_OUT_MMP0_d N_VA_MMP0_g N_VDD!_MMP0_s N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=7.02e-13 AS=8.1e-13 PD=2.58e-06 PS=4.5e-06 NRD=0.217222 NRS=0.125
+ M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=4.5e-07 SB=1.293e-06 SD=0
+ PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15 PANW7=1.24e-14
+ PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=1.86e-13
XMMP1 N_OUT_MMP0_d N_VB_MMP1_g N_VDD!_MMP1_s N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=7.02e-13 AS=8.118e-13 PD=2.58e-06 PS=4.502e-06 NRD=0.216111
+ NRS=0.125 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.292e-06
+ SB=4.51e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=1.86e-13
c_56 NET12 0 0.00300963f
*
.include "NAND2.pex.sp.NAND2.pxi"
*
.ends
*
*
