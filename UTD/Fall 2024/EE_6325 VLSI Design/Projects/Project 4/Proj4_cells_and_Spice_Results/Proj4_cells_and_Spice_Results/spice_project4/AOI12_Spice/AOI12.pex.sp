* File: AOI12.pex.sp
* Created: Sat Nov  2 20:29:54 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "AOI12.pex.sp.pex"
.subckt AOI12  GND! OUT VDD! VC VB VA
* 
* VA	VA
* VB	VB
* VC	VC
* VDD!	VDD!
* OUT	OUT
* GND!	GND!
XD0_noxref N_GND!_D0_noxref_pos N_VDD!_D0_noxref_neg DIODENWX  AREA=9.53859e-12
+ PERIM=1.2354e-05
XMMN1 NET16 N_VC_MMN1_g N_GND!_MMN1_s N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.893e-13 AS=7.684e-13 PD=2.158e-06 PS=4.304e-06 NRD=0.134706
+ NRS=0.133529 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=4.52e-07
+ SB=1.81e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN0 N_OUT_MMN0_d N_VB_MMN0_g NET16 N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.9015e-13 AS=3.893e-13 PD=2.159e-06 PS=2.158e-06 NRD=0.137647
+ NRS=0.134706 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=9.72e-07
+ SB=1.29e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN2 N_OUT_MMN0_d N_VA_MMN2_g N_GND!_MMN2_s N_GND!_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.9015e-13 AS=1.3073e-12 PD=2.159e-06 PS=4.938e-06 NRD=0.132353
+ NRS=0.225882 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.493e-06
+ SB=7.69e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMP1 N_NET7_MMP1_d N_VC_MMP1_g N_VDD!_MMP1_s N_VDD!_D0_noxref_neg PFET
+ L=6.2e-08 W=1.8e-06 AD=8.136e-13 AS=4.122e-13 PD=4.504e-06 PS=2.258e-06
+ NRD=0.126111 NRS=0.13 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1
+ SA=4.52e-07 SB=1.81e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=7.44e-14
XMMP0 N_NET7_MMP0_d N_VB_MMP0_g N_VDD!_MMP1_s N_VDD!_D0_noxref_neg PFET
+ L=6.2e-08 W=1.8e-06 AD=4.131e-13 AS=4.122e-13 PD=2.259e-06 PS=2.258e-06
+ NRD=0.13 NRS=0.124444 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1
+ SA=9.72e-07 SB=1.29e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=1.342e-13 PANW10=2.13e-13
XMMP2 N_OUT_MMP2_d N_VA_MMP2_g N_NET7_MMP0_d N_VDD!_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=1.3842e-12 AS=4.131e-13 PD=5.138e-06 PS=2.259e-06 NRD=0.213333
+ NRS=0.125 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.493e-06
+ SB=7.69e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=1.612e-13 PANW10=1.86e-13
*
.include "AOI12.pex.sp.AOI12.pxi"
*
.ends
*
*