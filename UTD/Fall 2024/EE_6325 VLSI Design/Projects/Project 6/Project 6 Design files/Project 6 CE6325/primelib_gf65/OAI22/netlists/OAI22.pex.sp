* File: OAI22.pex.sp
* Created: Mon Dec  2 11:18:51 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "OAI22.pex.sp.pex"
.subckt OAI22  OUT VSS VDD A B D C
* 
* C	C
* D	D
* B	B
* A	A
* VDD	VDD
* VSS	VSS
* OUT	OUT
XD0_noxref N_VSS_D0_noxref_pos N_VDD_D0_noxref_neg DIODENWX  AREA=1.3783e-11
+ PERIM=1.486e-05
XMMN0 N_OUT_MMN0_d N_A_MMN0_g N_NET22_MMN0_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.893e-13 AS=7.684e-13 PD=2.158e-06 PS=4.304e-06 NRD=0.137059
+ NRS=0.133529 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=4.52e-07
+ SB=2.327e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0 PANW7=0
+ PANW8=3.348e-15 PANW9=2.48e-14 PANW10=3.72e-14
XMMN2 N_OUT_MMN0_d N_B_MMN2_g N_NET22_MMN2_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.893e-13 AS=6.596e-13 PD=2.158e-06 PS=2.476e-06 NRD=0.132353
+ NRS=0.338824 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=9.72e-07
+ SB=1.807e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0 PANW7=0
+ PANW8=3.348e-15 PANW9=2.48e-14 PANW10=3.72e-14
XMMN3 N_NET22_MMN2_s N_D_MMN3_g N_VSS_MMN3_s N_VSS_D0_noxref_pos NFET
+ L=6.2e-08 W=1.7e-06 AD=6.596e-13 AS=3.893e-13 PD=2.476e-06 PS=2.158e-06
+ NRD=0.117647 NRS=0.136471 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0
+ SA=1.81e-06 SB=9.69e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=0 PANW8=3.348e-15 PANW9=2.48e-14 PANW10=3.72e-14
XMMN1 N_NET22_MMN1_d N_C_MMN1_g N_VSS_MMN3_s N_VSS_D0_noxref_pos NFET
+ L=6.2e-08 W=1.7e-06 AD=7.633e-13 AS=3.893e-13 PD=4.298e-06 PS=2.158e-06
+ NRD=0.131765 NRS=0.132941 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0
+ SA=2.33e-06 SB=4.49e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=0 PANW8=3.348e-15 PANW9=2.48e-14 PANW10=3.72e-14
XMMP0 NET8 N_A_MMP0_g N_VDD_MMP0_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=4.122e-13 AS=8.136e-13 PD=2.258e-06 PS=4.504e-06 NRD=0.127222
+ NRS=0.126111 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=4.52e-07
+ SB=2.327e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=2.356e-15 PANW8=1.24e-13 PANW9=3.1744e-14 PANW10=7.44e-14
XMMP1 N_OUT_MMP1_d N_B_MMP1_g NET8 N_VDD_D0_noxref_neg PFET L=6.2e-08 W=1.8e-06
+ AD=6.984e-13 AS=4.122e-13 PD=2.576e-06 PS=2.258e-06 NRD=0.213889 NRS=0.127222
+ M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=9.72e-07 SB=1.807e-06 SD=0
+ PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0 PANW7=2.356e-15 PANW8=1.24e-14
+ PANW9=1.39744e-13 PANW10=7.8e-14
XMMP3 N_OUT_MMP1_d N_D_MMP3_g NET024 N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=6.984e-13 AS=4.122e-13 PD=2.576e-06 PS=2.258e-06 NRD=0.217222
+ NRS=0.127222 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.81e-06
+ SB=9.69e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=2.356e-15 PANW8=1.24e-14 PANW9=1.39744e-13 PANW10=7.8e-14
XMMP2 NET024 N_C_MMP2_g N_VDD_MMP2_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=4.122e-13 AS=8.082e-13 PD=2.258e-06 PS=4.498e-06 NRD=0.127222
+ NRS=0.125556 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=2.33e-06
+ SB=4.49e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=0 PANW6=0
+ PANW7=2.356e-15 PANW8=1.24e-13 PANW9=3.1744e-14 PANW10=7.44e-14
*
.include "OAI22.pex.sp.OAI22.pxi"
*
.ends
*
*
