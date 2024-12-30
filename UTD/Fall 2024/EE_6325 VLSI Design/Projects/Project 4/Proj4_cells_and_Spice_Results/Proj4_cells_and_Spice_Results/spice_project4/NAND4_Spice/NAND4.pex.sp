* File: NAND4.pex.sp
* Created: Fri Nov  8 19:41:57 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "NAND4.pex.sp.pex"
.subckt NAND4  OUT GND! VDD! VA VB VC VD
* 
* VD	VD
* VC	VC
* VB	VB
* VA	VA
* VDD!	VDD!
* GND!	GND!
* OUT	OUT
XD0_noxref N_GND!_D0_noxref_pos N_VDD!_D0_noxref_neg DIODENWX  AREA=1.14289e-11
+ PERIM=1.3572e-05
XMMN0 N_OUT_MMN0_d N_VA_MMN0_g NET16 N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=1.309e-12 AS=3.825e-13 PD=4.94e-06 PS=2.15e-06 NRD=0.226471
+ NRS=0.132353 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=7.7e-07
+ SB=2.101e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN1 NET16 N_VB_MMN1_g NET15 N_GND!_D0_noxref_pos NFET L=6.2e-08 W=1.7e-06
+ AD=3.825e-13 AS=4.6835e-13 PD=2.15e-06 PS=2.251e-06 NRD=0.132353 NRS=0.162059
+ M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.282e-06 SB=1.589e-06 SD=0
+ PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15 PANW7=1.24e-14
+ PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN2 NET15 N_VC_MMN2_g NET14 N_GND!_D0_noxref_pos NFET L=6.2e-08 W=1.7e-06
+ AD=4.6835e-13 AS=3.91e-13 PD=2.251e-06 PS=2.16e-06 NRD=0.162059 NRS=0.135294
+ M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.895e-06 SB=9.76e-07 SD=0
+ PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15 PANW7=1.24e-14
+ PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN3 NET14 N_VD_MMN3_g N_GND!_MMN3_s N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.91e-13 AS=7.718e-13 PD=2.16e-06 PS=4.308e-06 NRD=0.135294
+ NRS=0.134118 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=2.417e-06
+ SB=4.54e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMP0 N_OUT_MMP0_d N_VA_MMP0_g N_VDD!_MMP0_s N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=1.386e-12 AS=4.05e-13 PD=5.14e-06 PS=2.25e-06 NRD=0.213889
+ NRS=0.125 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=7.7e-07
+ SB=2.101e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=1.612e-13 PANW10=7.44e-14
XMMP1 N_OUT_MMP1_d N_VB_MMP1_g N_VDD!_MMP0_s N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=4.959e-13 AS=4.05e-13 PD=2.351e-06 PS=2.25e-06 NRD=0.152778
+ NRS=0.125 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.282e-06
+ SB=1.589e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=4.96e-14 PANW10=2.634e-13
XMMP2 N_OUT_MMP1_d N_VC_MMP2_g N_VDD!_MMP2_s N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=4.959e-13 AS=4.14e-13 PD=2.351e-06 PS=2.26e-06 NRD=0.153333
+ NRS=0.126667 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.895e-06
+ SB=9.76e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=1.504e-13 PANW10=8.52e-14
XMMP3 N_OUT_MMP3_d N_VD_MMP3_g N_VDD!_MMP2_s N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=8.172e-13 AS=4.14e-13 PD=4.508e-06 PS=2.26e-06 NRD=0.153333
+ NRS=0.128889 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=2.417e-06
+ SB=4.54e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=7.44e-14
*
.include "NAND4.pex.sp.NAND4.pxi"
*
.ends
*
*
