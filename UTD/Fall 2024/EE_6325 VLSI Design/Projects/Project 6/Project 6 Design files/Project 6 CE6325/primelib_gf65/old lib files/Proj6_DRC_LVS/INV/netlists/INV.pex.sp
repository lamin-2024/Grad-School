* File: INV.pex.sp
* Created: Thu Nov 28 13:26:52 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "INV.pex.sp.pex"
.subckt INV  VSS OUT VDD IN
* 
* IN	IN
* VDD	VDD
* OUT	OUT
* VSS	VSS
XD0_noxref N_VSS_D0_noxref_pos N_VDD_D0_noxref_neg DIODENWX  AREA=6.30422e-12
+ PERIM=1.027e-05
XMMN0 N_OUT_MMN0_d N_IN_MMN0_g N_VSS_MMN0_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=1.3056e-12 AS=7.684e-13 PD=4.936e-06 PS=4.304e-06 NRD=0.244118
+ NRS=0.133529 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=4.52e-07
+ SB=7.68e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMP0 N_OUT_MMP0_d N_IN_MMP0_g N_VDD_MMP0_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=1.3824e-12 AS=8.136e-13 PD=5.136e-06 PS=4.504e-06 NRD=0.230556
+ NRS=0.125556 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=4.52e-07
+ SB=7.68e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=1.612e-13 PANW10=7.44e-14
*
.include "INV.pex.sp.INV.pxi"
*
.ends
*
*
