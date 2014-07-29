TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = kepco50
# kepco50.dbd will be created and installed
DBD += kepco50.dbd

# kepco50.dbd will be made up from these files:
kepco50_DBD += base.dbd

kepco50_DBD += stream.dbd
kepco50_DBD += asyn.dbd
kepco50_DBD += drvAsynSerialPort.dbd
kepco50_DBD += drvAsynIPPort.dbd
kepco50_DBD += devIocStats.dbd
kepco50_DBD += pvdump.dbd 

kepco50_LIBS += stream
kepco50_LIBS += asyn devIocStats pvdump easySQLite sqlite utilities icpconfig

# kepco50_registerRecordDeviceDriver.cpp derives from kepco50.dbd
kepco50_SRCS += kepco50_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
kepco50_SRCS_DEFAULT += kepco50Main.cpp
kepco50_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#kepco50_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
kepco50_LIBS += pcre $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

