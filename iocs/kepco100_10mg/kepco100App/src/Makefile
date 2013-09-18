TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = kepco100
# kepco100.dbd will be created and installed
DBD += kepco100.dbd

# kepco100.dbd will be made up from these files:
kepco100_DBD += base.dbd

kepco100_DBD += stream.dbd
kepco100_DBD += asyn.dbd
kepco100_DBD += drvAsynSerialPort.dbd
kepco100_DBD += drvAsynIPPort.dbd
kepco100_DBD += devIocStats.dbd

kepco100_LIBS += stream
kepco100_LIBS += asyn devIocStats  

# kepco100_registerRecordDeviceDriver.cpp derives from kepco100.dbd
kepco100_SRCS += kepco100_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
kepco100_SRCS_DEFAULT += kepco100Main.cpp
kepco100_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#kepco100_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
kepco100_LIBS += pcre $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

