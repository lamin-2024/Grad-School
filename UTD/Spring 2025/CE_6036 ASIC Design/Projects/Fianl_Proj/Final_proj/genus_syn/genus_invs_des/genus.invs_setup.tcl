#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 04/27/2025 11:00:12
#
# This file can only be run in Innovus Common UI mode.
#
#####################################################################


# Design Import
###########################################################
## Reading FlowKit settings file
source genus_invs_des/genus.flowkit_settings.tcl

source genus_invs_des/genus.invs_init.tcl

# Reading metrics file
######################
read_metric -id current genus_invs_des/genus.metrics.json 



# Mode Setup
###########################################################
source genus_invs_des/genus.mode
eval_enc { set edi_pe::pegConsiderMacroLayersUnblocked 1 }
eval_enc { set edi_pe::pegPreRouteWireWidthBasedDensityCalModel 1 }
