TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = kepco_sim
# kepco_sim.dbd will be created and installed
DBD += kepco_sim.dbd

# kepco_sim.dbd will be made up from these files:
kepco_sim_DBD += base.dbd

kepco_sim_DBD += stream.dbd
kepco_sim_DBD += asyn.dbd
kepco_sim_DBD += drvAsynSerialPort.dbd
kepco_sim_DBD += drvAsynIPPort.dbd
kepco_sim_DBD += devIocStats.dbd

kepco_sim_LIBS += stream
kepco_sim_LIBS += asyn devIocStats  

# kepco_sim_registerRecordDeviceDriver.cpp derives from kepco_sim.dbd
kepco_sim_SRCS += kepco_sim_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
kepco_sim_SRCS_DEFAULT += kepco_simMain.cpp
kepco_sim_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#kepco_sim_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
kepco_sim_LIBS += pcre $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

