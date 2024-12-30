* File: AOI22.pex.sp
* Created: Wed Oct 30 22:20:54 2024
* Program "Calibre xRC"
* Version "v2013.2_18.13"
* 
.include "AOI22.pex.sp.pex"
.subckt AOI22  VSS OUT VDD VB VA VC VD
* 
* VD	VD
* VC	VC
* VA	VA
* VB	VB
* VDD	VDD
* OUT	OUT
* VSS	VSS
XD0_noxref N_VSS_D0_noxref_pos N_VDD_D0_noxref_neg DIODENWX  AREA=1.11496e-11
+ PERIM=1.3392e-05
XMMN1 NET23 N_VB_MMN1_g N_VSS_MMN1_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.893e-13 AS=7.684e-13 PD=2.158e-06 PS=4.304e-06 NRD=0.134706
+ NRS=0.133529 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=4.52e-07
+ SB=2.329e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN0 N_OUT_MMN0_d N_VA_MMN0_g NET23 N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.9015e-13 AS=3.893e-13 PD=2.159e-06 PS=2.158e-06 NRD=0.137647
+ NRS=0.134706 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=9.72e-07
+ SB=1.809e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN2 N_OUT_MMN0_d N_VC_MMN2_g NET22 N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=3.9015e-13 AS=6.5875e-13 PD=2.159e-06 PS=2.475e-06 NRD=0.132353
+ NRS=0.227941 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=1.493e-06
+ SB=1.288e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMN3 NET22 N_VD_MMN3_g N_VSS_MMN3_s N_VSS_D0_noxref_pos NFET L=6.2e-08
+ W=1.7e-06 AD=6.5875e-13 AS=7.667e-13 PD=2.475e-06 PS=4.302e-06 NRD=0.227941
+ NRS=0.132353 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=0 SA=2.33e-06
+ SB=4.51e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=6.2e-17 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.24e-14 PANW9=2.48e-14 PANW10=3.72e-14
XMMP2 N_NET8_MMP2_d N_VB_MMP2_g N_VDD_MMP2_s N_VDD_D0_noxref_neg PFET
+ L=6.2e-08 W=1.8e-06 AD=8.136e-13 AS=4.122e-13 PD=4.504e-06 PS=2.258e-06
+ NRD=0.126111 NRS=0.13 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1
+ SA=4.52e-07 SB=2.329e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=7.44e-14
XMMP0 N_NET8_MMP0_d N_VA_MMP0_g N_VDD_MMP2_s N_VDD_D0_noxref_neg PFET
+ L=6.2e-08 W=1.8e-06 AD=4.131e-13 AS=4.122e-13 PD=2.259e-06 PS=2.258e-06
+ NRD=0.129444 NRS=0.124444 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1
+ SA=9.72e-07 SB=1.809e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=1.342e-13 PANW10=1.014e-13
XMMP1 N_OUT_MMP1_d N_VC_MMP1_g N_NET8_MMP0_d N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=6.975e-13 AS=4.131e-13 PD=2.575e-06 PS=2.259e-06 NRD=0.213333
+ NRS=0.125556 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=1.493e-06
+ SB=1.288e-06 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15
+ PANW6=6.2e-15 PANW7=1.24e-14 PANW8=2.2878e-14 PANW9=4.96e-14 PANW10=2.976e-13
XMMP3 N_OUT_MMP1_d N_VD_MMP3_g N_NET8_MMP3_s N_VDD_D0_noxref_neg PFET L=6.2e-08
+ W=1.8e-06 AD=6.975e-13 AS=8.118e-13 PD=2.575e-06 PS=4.502e-06 NRD=0.217222
+ NRS=0.125556 M=1 NF=1 CNR_SWITCH=0 PCCRIT=0 PAR=1 PTWELL=1 SA=2.33e-06
+ SB=4.51e-07 SD=0 PANW1=0 PANW2=0 PANW3=0 PANW4=0 PANW5=1.674e-15 PANW6=6.2e-15
+ PANW7=1.24e-14 PANW8=1.34478e-13 PANW9=4.96e-14 PANW10=7.44e-14
c_111 NET22 0 0.00300963f
*
.include "AOI22.pex.sp.AOI22.pxi"
*
.ends
*
*
