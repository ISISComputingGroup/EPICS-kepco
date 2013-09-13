#!../../bin/windows-x64/kepco_sim

## You may have to change kepco_sim to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet "IOCNAME" "$(P=$(MYPVPREFIX))KEPCOSIM"
epicsEnvSet "IOCSTATS_DB" "$(DEVIOCSTATS)/db/iocAdminSoft.db"
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/../../kepcoApp/protocol"
#epicsEnvSet "TTY" "$(TTY=\\\\\\\\.\\\\COM17)"

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/kepco_sim.dbd"
kepco_sim_registerRecordDeviceDriver pdbbase

drvAsynIPPortConfigure ("PS1", "127.0.0.1:9999")

## Load record instances
dbLoadRecords("$(TOP)/../../db/kepco.db","P=$(IOCNAME):, PORT=PS1")
#dbLoadRecords("$(IOCSTATS_DB)","IOC=$(IOCNAME)")

cd ${TOP}/iocBoot/${IOC}
iocInit

