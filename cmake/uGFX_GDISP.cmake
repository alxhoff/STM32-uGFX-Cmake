SET(uGFX_GDISP_MODULES gdisp_fonts gdisp_image gdisp_pixmap)

SET(uGFX_gdisp_SEARCH_PATH ${uGFX_DIR}/src/gdisp)
SET(uGFX_gdisp_HEADERS gdisp_colors.h gdisp_options.h gdisp_rules.h)
SET(uGFX_gdisp_SOURCES gdisp.c)

SET(uGFX_gdisp_fonts_SEARCH_PATH
    ${uGFX_DIR}/src/gdisp/fonts
    )

SET(uGFX_gdisp_fonts_HEADERS
    fonts.h
    )
SET(uGFX_gdisp_fonts_SOURCES
    DejaVuSans16_aa.c DejaVuSans24_aa.c DejaVuSansBold12_aa.c fixed_10x20.c
    fixed_7x14.c UI2.c DejaVuSans10.c DejaVuSans16.c DejaVuSans24.c DejaVuSansBold12.c
    DejaVuSans12_aa.c  DejaVuSans20_aa.c  DejaVuSans32_aa.c  fixed_5x8.c
    LargeNumbers.c DejaVuSans12.c DejaVuSans20.c DejaVuSans32.c UI1.c
    )

SET(uGFX_gdisp_mcufont_SEARCH_PATH
    ${uGFX_DIR}/src/gdisp
    ${uGFX_DIR}/src/gdisp/mcufont
    )
SET(uGFX_gdisp_mcufont_HEADERS
    mcufont.h mf_bwfont.h mf_config.h mf_encoding.h mf_font.h mf_justify.h
    mf_kerning.h mf_rlefont.h mf_scaledfont.h mf_wordwrap.h)
SET(uGFX_gdisp_mcufont_SOURCES
    mf_bwfont.c mf_encoding.c mf_font.c mf_justify.c mf_kerning.c mf_rlefont.c
    mf_scaledfont.c mf_wordwrap.c gdisp_fonts.c)

SET(uGFX_gdisp_image_SEARCH_PATH ${uGFX_DIR}/src/gdisp)
SET(uGFX_gdisp_image_HEADERS gdisp_image.h)
SET(uGFX_gdisp_image_SOURCES
    gdisp_image_bmp.c gdisp_image_gif.c gdisp_image_gif.c gdisp_image_jpg.c
    gdisp_image_native.c gdisp_image_png.c gdisp_image.c)

SET(uGFX_gdisp_pixmap_SEARCH_PATH ${uGFX_DIR}/src/gdisp)
SET(uGFX_gdisp_pixmap_HEADERS gdisp_pixmap.h)
SET(uGFX_gdisp_pixmap_SOURCES gdisp_pixmap.c)

FOREACH(driver ${uGFX_GDISP_DRIVERS})
    LIST(FIND uGFX_FIND_COMPONENTS ${driver} DRIVER_INDEX)
    IF(NOT ${DRIVER_INDEX} LESS 0)
        SET(uGFX_${driver}_SEARCH_PATH ${uGFX_DIR}/drivers/gdisp/${driver})
        SET(uGFX_${driver}_SOURCES gdisp_lld_${driver}.c)
        SET(uGFX_${driver}_HEADERS gdisp_lld_config.h)
        LIST(APPEND uGFX_GDISP_MODULES ${driver})
    ENDIF()
ENDFOREACH()
