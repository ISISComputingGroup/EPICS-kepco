#!../../bin/windows-x64/kepco100

## You may have to change kepco100 to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/../../kepcoApp/protocol"
epicsEnvSet "TTY" "$(TTY=\\\\\\\\.\\\\COM17)"

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/kepco100.dbd"
kepco100_registerRecordDeviceDriver pdbbase

< $(IOCSTARTUP)/init.cmd

drvAsynSerialPortConfigure("L0", "$(TTY)", 0, 0, 0, 0)
asynSetOption("L0", -1, "baud", "9600")
asynSetOption("L0", -1, "bits", "8")
asynSetOption("L0", -1, "parity", "none")
asynSetOption("L0", -1, "stop", "1")

< $(IOCSTARTUP)/dbload.cmd

## Load record instances
dbLoadRecords("$(TOP)/../../db/kepco.db","P=$(MYPVPREFIX)KEPCO100:, PORT=L0")

< $(IOCSTARTUP)/preiocinit.cmd

cd ${TOP}/iocBoot/${IOC}
iocInit

< $(IOCSTARTUP)/postiocinit.cmd

