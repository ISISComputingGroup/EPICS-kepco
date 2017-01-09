#!../../bin/windows-x64/kepco_sim

## You may have to change kepco_sim to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/../../kepcoApp/protocol"

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/kepco_sim.dbd"
kepco_sim_registerRecordDeviceDriver pdbbase

< $(IOCSTARTUP)/init.cmd

drvAsynIPPortConfigure ("PS1", "127.0.0.1:9999")

< $(IOCSTARTUP)/dbload.cmd

## Load record instances
dbLoadRecords("$(TOP)/../../db/kepco.db","P=$(MYPVPREFIX)KEPCOSIM:, PORT=PS1, DISABLE=$(DISABLE=0),RECSIM=$(RECSIM=0)")

< $(IOCSTARTUP)/preiocinit.cmd

cd ${TOP}/iocBoot/${IOC}
iocInit

< $(IOCSTARTUP)/postiocinit.cmd

