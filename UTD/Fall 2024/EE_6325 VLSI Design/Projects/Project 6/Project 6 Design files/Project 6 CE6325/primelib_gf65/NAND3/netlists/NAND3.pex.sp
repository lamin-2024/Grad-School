* File: NAND3.pex.sp
* Created: Mon Dec  2 09:37:38 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "NAND3.pex.sp.pex"
.subckt NAND3  OUT VSS VDD A B C
* 
* C	C
* B	B
* A	A
* VDD	VDD
* VSS	VSS
* OUT	OUT
XD0_noxref N_VSS_D0_noxref_pos N_VDD_D0_noxref_neg DIODENWX  AREA=1.2782e-11
+ PERIM=1.434e-05
XMMN0 N_OUT_MMN0_d N_A_MMN0_g NET12 N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=1.326e-12 AS=3.893e-13 PD=4.96e-06 PS=2.158e-06 NRD=0.23
+ NRS=0.134706 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=7.8e-07
+ SB=1.754e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0 PANW7=0
+ PANW8=3.348e-15 PANW9=2.48e-14 PANW10=3.72e-14
XMMN1 NET12 N_B_MMN1_g NET015 N_VSS_D0_noxref_pos NFET L=6.2e-08 W=1.7e-06
+ AD=3.893e-13 AS=6.103e-13 PD=2.158e-06 PS=2.418e-06 NRD=0.134706 NRS=0.211176
+ M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.3e-06 SB=1.234e-06 SD=0
+ PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0 PANW7=0 PANW8=3.348e-15
+ PANW9=2.48e-14 PANW10=3.72e-14
XMMN2 NET015 N_C_MMN2_g N_VSS_MMN2_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=6.103e-13 AS=7.718e-13 PD=2.418e-06 PS=4.308e-06 NRD=0.211176
+ NRS=0.134118 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=2.08e-06
+ SB=4.54e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0 PANW7=0
+ PANW8=3.348e-15 PANW9=2.48e-14 PANW10=3.72e-14
XMMP0 N_OUT_MMP0_d N_A_MMP0_g N_VDD_MMP0_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=1.404e-12 AS=4.122e-13 PD=5.16e-06 PS=2.258e-06 NRD=0.217222
+ NRS=0.119444 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=7.8e-07
+ SB=1.754e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=2.356e-15 PANW8=1.24e-14 PANW9=1.43344e-13 PANW10=7.44e-14
XMMP1 N_OUT_MMP1_d N_B_MMP1_g N_VDD_MMP0_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=6.462e-13 AS=4.122e-13 PD=2.518e-06 PS=2.258e-06 NRD=0.202778
+ NRS=0.135 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.3e-06
+ SB=1.234e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=2.356e-15 PANW8=1.24e-14 PANW9=3.1744e-14 PANW10=2.976e-13
XMMP4 N_OUT_MMP1_d N_C_MMP4_g N_VDD_MMP4_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=6.462e-13 AS=8.172e-13 PD=2.518e-06 PS=4.508e-06 NRD=0.196111
+ NRS=0.126667 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=2.08e-06
+ SB=4.54e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=2.356e-15 PANW8=1.24e-13 PANW9=3.1744e-14 PANW10=7.44e-14
*
.include "NAND3.pex.sp.NAND3.pxi"
*
.ends
*
*
