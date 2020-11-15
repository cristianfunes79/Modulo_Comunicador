##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.10.0-B14] date: [Mon Nov 09 00:50:10 ART 2020]
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

######################################
# target
######################################
RTOS_TARGET = freertos


######################################
# building variables
######################################
# debug build?
RTOS_DEBUG = 0
# optimization
RTOS_OPT = -Og


#######################################
# paths
#######################################
# Build path
RTOS_BUILD_DIR = freertos_build
RTOS_PATH = /home/cfunes/Downloads/FreeRTOSv10.4.1/FreeRTOS
RTOS_CONFIG = /home/cfunes/Downloads/FreeRTOSv10.4.1/FreeRTOS

######################################
# source
######################################
# C sources
RTOS_C_SOURCES = 	$(wildcard $(RTOS_PATH)/Source/*.c) \
					$(RTOS_PATH)/Source/portable/Common/mpu_wrappers.c \
					$(RTOS_PATH)/Source/portable/GCC/ARM_CM4F/port.c \
					$(RTOS_PATH)/Source/portable/MemMang/heap_1.c

# C defines
RTOS_C_DEFS =  \
-DUSE_HAL_DRIVER \
-DSTM32F401xE

# C includes
RTOS_C_INCLUDES = -I$(RTOS_PATH)/Source/include \
				  -I$(RTOS_CONFIG) \
				  -I$(RTOS_PATH)/Source/portable/GCC/ARM_CM4F


RTOS_CFLAGS = $(MCU) $(RTOS_C_DEFS) $(RTOS_C_INCLUDES) $(RTOS_OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(RTOS_DEBUG), 1)
RTOS_CFLAGS += -g -gdwarf-2
endif

# Generate dependency information
RTOS_CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################

# libraries
RTOS_LIBS = -lc -lm -lnosys 
RTOS_LIBDIR = 
RTOS_LDFLAGS = $(MCU) -specs=nano.specs  $(RTOS_LIBDIR) $(RTOS_LIBS) -Wl,-Map=$(RTOS_BUILD_DIR)/$(RTOS_TARGET).map,--cref -Wl,--gc-sections



#######################################
# build the application
#######################################
# list of objects
RTOS_OBJECTS = $(addprefix $(RTOS_BUILD_DIR)/,$(notdir $(RTOS_C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(RTOS_C_SOURCES)))

$(RTOS_BUILD_DIR)/%.o: %.c Makefile | $(RTOS_BUILD_DIR) 
	$(CC) -c $(RTOS_CFLAGS) -Wa,-a,-ad,-alms=$(RTOS_BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(RTOS_BUILD_DIR)/$(RTOS_TARGET).a: $(RTOS_BUILD_DIR) $(RTOS_OBJECTS) Makefile
	$(AR) crs $@ $(RTOS_OBJECTS) 
	$(SZ) $@

$(RTOS_BUILD_DIR):
	mkdir $@		

  
#######################################
# dependencies
#######################################
-include $(wildcard $(RTOS_BUILD_DIR)/*.d)

# *** EOF ***
