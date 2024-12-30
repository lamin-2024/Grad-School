* File: NOR3.pex.sp
* Created: Thu Nov 28 14:17:24 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "NOR3.pex.sp.pex"
.subckt NOR3  OUT VSS VDD A B C
* 
* C	C
* B	B
* A	A
* VDD	VDD
* VSS	VSS
* OUT	OUT
XD0_noxref N_VSS_D0_noxref_pos N_VDD_D0_noxref_neg DIODENWX  AREA=9.55722e-12
+ PERIM=1.2366e-05
XMMN0 N_OUT_MMN0_d N_A_MMN0_g N_VSS_MMN0_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=7.65e-13 AS=3.9185e-13 PD=4.3e-06 PS=2.161e-06 NRD=0.127059
+ NRS=0.138824 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=4.5e-07
+ SB=1.818e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN1 N_OUT_MMN1_d N_B_MMN1_g N_VSS_MMN0_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.9185e-13 AS=3.9185e-13 PD=2.161e-06 PS=2.161e-06 NRD=0.133529
+ NRS=0.132353 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=9.73e-07
+ SB=1.295e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN2 N_OUT_MMN1_d N_C_MMN2_g N_VSS_MMN2_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.9185e-13 AS=1.3124e-12 PD=2.161e-06 PS=4.944e-06 NRD=0.137647
+ NRS=0.244706 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.496e-06
+ SB=7.72e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMP4 NET012 N_A_MMP4_g N_VDD_MMP4_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=4.149e-13 AS=8.1e-13 PD=2.261e-06 PS=4.5e-06 NRD=0.128056
+ NRS=0.125 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=4.5e-07
+ SB=1.818e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=7.44e-14
XMMP0 NET09 N_B_MMP0_g NET012 N_VDD_D0_noxref_neg PFET L=6.2e-08 W=1.8e-06
+ AD=4.149e-13 AS=4.149e-13 PD=2.261e-06 PS=2.261e-06 NRD=0.128056 NRS=0.128056
+ M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=9.73e-07 SB=1.295e-06 SD=0
+ PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15 PANW7=1.24e-14
+ PANW8=2.2878e-14 PANW9=1.324e-13 PANW10=2.148e-13
XMMP1 N_OUT_MMP1_d N_C_MMP1_g NET09 N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=1.3896e-12 AS=4.149e-13 PD=5.144e-06 PS=2.261e-06 NRD=0.215556
+ NRS=0.128056 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.496e-06
+ SB=7.72e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=1.612e-13 PANW10=1.86e-13
*
.include "NOR3.pex.sp.NOR3.pxi"
*
.ends
*
*
