PROJECT(STM32F4_UGFX)

set(CMAKE_BUILD_TYPE Debug)
set( CMAKE_EXPORT_COMPILE_COMMANDS ON )
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
ENABLE_LANGUAGE(ASM)

# Remove -rdynamic option from linking that is not supported by arm-none-eabi
# Also remove "undefined reference to `_sbrk'" error
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-specs=nano.specs -specs=nosys.specs")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

set(STM32_CHIP STM32F429ZIT)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_MODULE_PATH}/gcc_stm32.cmake)
include(${CMAKE_TOOLCHAIN_FILE})

FIND_PACKAGE(Git REQUIRED)
set(CUBE_SOURCE "${CMAKE_BINARY_DIR}/STM32F4-Cube-Firmware")
if(EXISTS ${CUBE_SOURCE})
    message("Cube FW directory exists")
else()
    message("Getting Cube Firmware")
    set(GIT_REPOSITORY "https://github.com/alxhoff/STM32F4-Cube-Firmware.git")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} )
endif()

set(STM32Cube_DIR ${CUBE_SOURCE})

set(uGFX_SOURCE "${CMAKE_BINARY_DIR}/uGFX")
if(EXISTS ${uGFX_SOURCE})
    message("uGFX directroy exists")
else()
    message("Getting uGFX Source")
    set(GIT_REPOSITORY "https://git.ugfx.io/uGFX/uGFX.git")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} )
endif()

set(uGFX_DIR ${uGFX_SOURCE})

set(STM32_STD_SOURCE "${CMAKE_BINARY_DIR}/STM32F4xx-standard-peripherals-library")
if(EXISTS ${STM32_STD_SOURCE})
    message("STM32 STD directroy exists")
else()
    message("Getting STM32 STD Source")
    set(GIT_REPOSITORY "https://github.com/alxhoff/STM32F4xx-standard-peripherals-library")
    execute_process(COMMAND ${GIT_EXECUTABLE} clone ${GIT_REPOSITORY} )
endif()

set(STM32STD_DIR ${STM32_STD_SOURCE})

SET(FREERTOS_HEAP_IMPL 4)

FIND_PACKAGE(FreeRTOS)
FIND_PACKAGE(STDPERIPH COMPONENTS dma dma2d fmc i2c ltdc gpio rcc spi usart adc tim exti syscfg)
FIND_PACKAGE(CMSIS REQUIRED)
FIND_PACKAGE(STM32HAL COMPONENTS adc cortex dma eth flash flash_ramfunc gpio i2c pcd rcc tim uart REQUIRED)
FIND_PACKAGE(STM32LL COMPONENTS usb REQUIRED)
FIND_PACKAGE(uGFX COMPONENTS gfx gdriver gdisp gos REQUIRED)

MESSAGE("STD SRC: ${STM32STD_SOURCES}")
MESSAGE("STD INC: ${STM32STD_INCLUDE_DIR}")

INCLUDE_DIRECTORIES(
    ${CMAKE_CURRENT_SOURCE_DIR}
    "${PROJECT_SOURCE_DIR}/Inc"
    ${CMSIS_INCLUDE_DIRS}
    ${STM32HAL_INCLUDE_DIR}
    ${STM32LL_INCLUDE_DIR}
    ${FreeRTOS_INCLUDE_DIRS}
    ${uGFX_INCLUDE_DIRS}
    )

file(GLOB PROJECT_SOURCES "Src/*.c")

SET(STM32_LINKER_SCRIPT ${CMSIS_LINKER_SCRIPT})

ADD_EXECUTABLE(${CMAKE_PROJECT_NAME} ${PROJECT_SOURCES} ${STM32HAL_SOURCES} ${STM32LL_SOURCES} ${FreeRTOS_SOURCES} ${CMSIS_SOURCES} ${uGFX_SOURCES})

STM32_SET_TARGET_PROPERTIES(${CMAKE_PROJECT_NAME})
STM32_ADD_HEX_BIN_TARGETS(${CMAKE_PROJECT_NAME})
STM32_PRINT_SIZE_OF_TARGETS(${CMAKE_PROJECT_NAME})
