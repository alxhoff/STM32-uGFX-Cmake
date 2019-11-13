IF(STM32_FAMILY STREQUAL "F4")
    SET(STD_COMPONENTS adc can cec crc cryp dac dbgmcu dcmi dfsdm dma2d dma dsi
        exti flash flash_ramfunc fmc fmpi2c fsmc gpio hash i2c iwdg lptim ltdc pwr qspi rcc
        rng rtc sai sdio spdifrx spi syscfg tim usart wwdg)

    SET(STD_REQUIRED_COMPONENTS dma dma2d fmc i2c ltdc gpio rcc spi usart adc tim exti syscfg)

    SET(STD_EX_COMPONENTS cryp_aes cryp_des cryp_tdes hash_md5 hash_shal)

    SET(STD_PREFIX stm32f4xx_)
ENDIF()

SET(STD_HEADERS
    misc.h
    )

SET(STD_SOURCES
    misc.c
    )

IF(NOT STM32STD_FIND_COMPONENTS)
    SET(STM32STD_FIND_COMPONENTS ${STD_COMPONENTS})
    MESSAGE(STATUS "No STM32STD components selected, using all: ${$STM32STD_FIND_COMPONENTS}")
ENDIF()

FOREACH(cmp ${STD_REQUIRED_COMPONENTS})
    LIST(FIND STM32STD_FIND_COMPONENTS ${cmp} STM32STD_FOUND_INDEX)
    IF(${STM32STD_FOUND_INDEX} LESS 0)
        LIST(APPEND STM32STD_FIND_COMPONENTS ${cmp})
    ENDIF()
ENDFOREACH()

FOREACH(cmp ${STM32STD_FIND_COMPONENTS})
    LIST(FIND STD_COMPONENTS ${cmp} STM32STD_FOUND_INDEX)
    IF($STM32STD_FOUND_INDEX LESS 0)
        MESSAGE(FATAL_ERROR "Unknown STM32STD Peripheral component: ${cmp}. Available components: ${STD_COMPONENTS}")
    ELSE()
        LIST(APPEND STD_HEADERS ${STD_PREFIX}${cmp}.h)
        LIST(APPEND STD_SOURCES ${STD_PREFIX}${cmp}.c)
    ENDIF()
    LIST(FIND HAL_EX_COMPONENTS ${cmp} STM32STD_FOUND_INDEX)
    if(NOT (${STM32STD_FOUND_INDEX} LESS 0))
        LIST(APPEND STD_SOURCES ${STD_PREFIX}${cmp}.c)
    ENDIF()
ENDFOREACH()

LIST(REMOVE_DUPLICATES STD_HEADERS)
LIST(REMOVE_DUPLICATES STD_SOURCES)

MESSAGE("HEADERS: ${STD_HEADERS}")
MESSAGE("SOURCES: ${STD_SOURCES}")
