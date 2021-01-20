enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(
		${toolchain}/targets/arm32/cm3/stm/f1xx/f103/deps
		${toolchain}/targets/arm32/cm3/stm/f1xx/deps

)

include_directories(
		${toolchain}/targets/arm32/cm3/deps
		${toolchain}/targets/arm32/cm3/stm/f1xx/deps
		${toolchain}/targets/arm32/cm3/stm/f1xx/f103/deps
)

add_definitions(-DSTM32F103xB)
add_definitions(-DDONT_USE_CMSIS_INIT)

set(compile_flags "-mcpu=cortex-m3 -mthumb -fomit-frame-pointer -march=armv7-m -specs=nosys.specs")

set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} ${compile_flags} -fno-exceptions"
)

set(CMAKE_C_FLAGS
        "${CMAKE_C_FLAGS} ${compile_flags}"
)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}  -Wl,--gc-sections -TSTM32F103XB_FLASH.ld")

add_executable(${PROJECT_NAME}_f103.elf
		${toolchain}/targets/arm32/cm3/stm/f1xx/deps/system_stm32f1xx.c
        ${toolchain}/targets/arm32/cm3/stm/f1xx/f103/deps/startup_stm32f103xb.s
	    ${sources})

add_custom_target(${PROJECT_NAME}_f103.hex DEPENDS ${PROJECT_NAME}_f103.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}_f103.elf ${PROJECT_NAME}_f103.hex)
add_custom_target(${PROJECT_NAME}_f103.bin DEPENDS ${PROJECT_NAME}_f103.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}_f103.elf ${PROJECT_NAME}_f103.bin)
