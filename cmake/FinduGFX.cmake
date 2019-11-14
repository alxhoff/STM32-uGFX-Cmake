SET(uGFX_COMPONENTS gadc gaudio gdriver gdisp gevent gfile ginput gmisc gos
    gqueue gtimer gtrans gwin)

SET(uGFX_REQUIRED_COMPONENTS gdisp gdriver)

SET(uGFX_PREFIX gfx)

SET(uGFX_HEADERS
    ${uGFX_PREFIX}.h
    ${uGFX_PREFIX}_options.h
    ${uGFX_PREFIX}_types.h
    ${uGFX_PREFIX}_compilers.h
    )

SET(uGFX_SRCS
    ${uGFX_PREFIX}.c
    ${uGFX_PREFIX}_mk.c
    )

# Set defaults if no components given
IF(NOT uGFX_FIND_COMPONENTS)
    SET(uGFX_FIND_COMPONENTS uGFX_COMPONENTS)
    MESSAGE(STATUS "No uGFX components specified, using all: ${uGFX_COMPONENTS}")
ENDIF()

LIST(APPEND uGFX_FIND_COMPONENTS ${uGFX_REQUIRED_COMPONENTS})

# Required components
FOREACH(cmp ${uGFX_REQUIRED_COMPONENTS})
    LIST(FIND uGFX_FIND_COMPONENTS ${cmp} uGFX_FOUND_INDEX)
    IF(${uGFX_FOUND_INDEX} LESS 0)
        LIST(APPEND uGFX_FIND_COMPONENTS ${cmp})
    ENDIF()
ENDFOREACH()

FOREACH(cmp ${uGFX_FIND_COMPONENTS})
    LIST(FIND uGFX_COMPONENTS ${cmp} uGFX_FOUND_INDEX)
    IF(${uGFX_FOUND_INDEX} LESS 0)
        MESSAGE(FATAL_ERROR "Unknown uGFX Module: ${cmp}. Available modules: ${uGFX_COMPONENTS}")
    ELSE()
    ENDIF()
ENDFOREACH()

INCLUDE(uGFX_GDISP)
LIST(APPEND uGFX_COMPONENTS ${uGFX_GDISP_MODULES})

SET(uGFX_gfx_SEARCH_PATH ${uGFX_DIR} ${uGFX_DIR}/src)
SET(uGFX_gfx_HEADERS gfx.h)
SET(uGFX_gfx_SOURCES gfx.c)

SET(uGFX_gadc_SEARCH_PATH ${uGFX_DIR}/src/gadc)
SET(uGFX_gadc_HEADERS gadc_driver.h gadc.h gadc_options.h gadc_rules.h)
SET(uGFX_gadc_SOURCES gadc.c)

SET(uGFX_gaudio_SERCH_PATH ${uGFX_DIR}/src/gaudio)
SET(uGFX_gaudio_HEADERS gadc_driver_record.h gaudio_driver_play.h
    gaudio.h gaudio_options.h gaudio_rules.h)
SET(uGFX_gaudio_SOURCES gaudio.c)

SET(uGFX_gdriver_SEARCH_PATH ${uGFX_DIR}/src/gdriver)
SET(uGFX_gdriver_HEADERS gdriver_options.h gdriver_rules.h gdriver.h)
SET(uGFX_gdriver_SOURCES gdriver.c)

SET(uGFX_gevent_SEARCH_PATH ${uGFX_DIR}/src/gdriver)
SET(uGFX_gevent_HEADERS gevent.h gevent_options.h gevent_rules.h)
SET(uGFX_gevent_SOURCES gevent.c)

SET(uGFX_gfile_SEARCH_PATH ${uGFX_DIR}/src/gfile)
SET(uGFX_gfile_HEADERS gfile_fatfs_wrapper.h gfile_fs.h gfile.h gfile_options.h
    gfile_petitfs_wrapper.h gfile_rules.h)
SET(uGFX_gfile_SOURCES gfile.c gfile_fatfs_diskio_chibios.c gfile_fatfs_wrapper.c
    gfile_fs_chibios.c gfile_fs_fatfs.c gfile_fs_mem.c gfile_fs_native.c
    gfile_fs_petitfs.c gfile_fs_ram.c gfile_fs_rom.c gfile_fs_strings.c
    gfile_petitfs_diskio_chibios.c gfile_petitfs_wrapper.c gfile_printg.c
    gfile_scang.c gfile_stdio.c)

SET(uGFX_ginput_SEARCH_PATH ${uGFX_DIR}/src/ginput)
SET(uGFX_ginput_HEADERS ginput_dial.h ginput_driver.dial.h ginput_driver_keyboard.h
    ginput_driver_mouse.h ginput_driver_toggle.h ginput.h ginput_keyboard.h
    ginput_keyboard_microcode.h ginput_mouse.h ginput_options.h ginput_rules.h
    ginput_toggle.h)
SET(uGFX_ginput_SOURCES ginput.c ginput_dial.c ginput_keyboard.c
    ginput_keyboard_microcode.c ginput_mouse.c ginput_toggle.c)

SET(uGFX_gmisc_SEARCH_PATH ${uGFX_DIR}/src/gmisc)
SET(uGFX_gmisc_HEADERS gmisc.h gmisc_options.h gmisc_rules.h)
SET(uGFX_gmisc_SOURCES gmisc_arrayops.c gmisc.c gmisc_hittest.c gmisc_matrix2d.c
    gmisc_trig.c)

SET(uGFX_gos_SEARCH_PATH ${uGFX_DIR}/src/gos)
SET(uGFX_HEADERS gos_arduino.h god_chibios.h gos_cmsis2.h gos_cmsis.h gos_ecos.h
    gos_freertos.h gos.h gos_keil.h gos_linux.h gos_nios.h gos_options.h
    gos_osx.h gos_qt.h gos_raw32.h gos_rawrtos.h gos_rtx5.h gos_rules.h
    gos_win32.h gos_x_heap.h gos_x_threads_cortexm01.h gos_x_threads_cortexm347.h
    gos_x_threads_cortexm47fp.h gos_x_threads gos_zephyr.h)
SET(uGFX_gos_SOURCES gos_arduino.c gos_chibios.c gos_cmsis2.c gos_cmsis.c
    gos_ecos.c gos_freertos.c gos_linux.c gos_nios.c gos_osx.c gos_raw32.c
    gos_rawrtos.c gos_win32.c gos_x_heap.c gos_x_threads.c gos_zephr.c)

SET(uGFX_gqueue_SEARCH_PATH ${uGFX}/src/gqueue)
SET(uGFX_gqueue_HEADERS gqueue.h gqueue_options.h gqueue_rules.h)
SET(uGFX_gqueue_SOURCES gqueue.c)

SET(uGFX_gtimer_SEARCH_PATH ${uGFX}/src/gtimer)
SET(uGFX_gtimer_HEADERS gtimer.h gtimer_options.h gtimer_rules.h)
SET(uGFX_gtimer_SOURCES gtimer.c)

SET(uGFX_gtrans_SEARCH_PATH ${uGFX}/src/gtrans)
SET(uGFX_gtrans_HEADERS gtrans.h gtrans_options.h gtrans_rules.h)
SET(uGFX_gtrans_SOURCES gtrans.c)

SET(uGFX_gwin_SEARCH_PATH ${uGFX_DIR}/src/gwin)
SET(uGFX_gwin_HEADERS gwin_button.h gwin_container.h gwin.h gwin_label.h gwin_radio.h
    gwin_textedit.h gwin_checkbox.h gwin_frame.h gwin_image.h gwin_list.h
    gwin_rules.h gwin_widget.h gwin_class.h gwin_gl3d.h gwin_keyboard.h gwin_options.h
    gwin_slider.h gwin_console.h gwin_graph.h gwin_keyboard_layout.h
    gwin_progressbar.h gwin_tabset.h
    )
SET(uGFX_gwin_SOURCES gwin_button.c gwin_container.c gwin_image.c gwin_list.c
    gwin_slider.c gwin_wm.c gwin.c gwin_frame.c gwin_keyboard.c gwin_tabset.c
    gwin_checkbox.c gwin_gl3d.c gwin_keyboard_layout.c gwin_progressbar.c gwin_textedit.c
    gwin_console.c gwin_graph.c gwin_label.c gwin_radio.c gwin_widget.c)

#here
FOREACH(comp ${uGFX_FIND_COMPONENTS})
    LIST(FIND uGFX_COMPONENTS ${comp} INDEX)
    IF(INDEX EQUAL -1)
        MESSAGE(FATAL_ERROR "Unknown uGFX component: ${comp}\nSupported uGFX components: ${uGFX_COMPONENTS}")
    ENDIF()
    IF(uGFX_${comp}_SOURCES)
        FOREACH(source ${uGFX_${comp}_SOURCES})
            FIND_FILE(uGFX_${comp}_${source} NAMES ${source} PATHS ${uGFX_${comp}_SEARCH_PATH} NO_DEFAULT_PATH CMAKE_FIND_ROOT_PATH_BOTH)
            LIST(APPEND uGFX_SOURCES ${uGFX_${comp}_${source}})
        ENDFOREACH()
    ENDIF()
    IF(uGFX_${comp}_HEADERS)
        FOREACH(header ${uGFX_${comp}_HEADERS})
            FIND_PATH(uGFX_${comp}_${header}_INCLUDE_DIR NAMES ${header} PATHS ${uGFX_${comp}_SEARCH_PATH} NO_DEFAULT_PATH CMAKE_FIND_ROOT_PATH_BOTH)
            LIST(APPEND uGFX_INCLUDE_DIRS ${uGFX_${comp}_${header}_INCLUDE_DIR})
        ENDFOREACH()
    ENDIF()
ENDFOREACH()

LIST(REMOVE_DUPLICATES uGFX_INCLUDE_DIRS)
LIST(REMOVE_DUPLICATES uGFX_SOURCES)
