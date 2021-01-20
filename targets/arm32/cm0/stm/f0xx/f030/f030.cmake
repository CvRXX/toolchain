enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(${toolchain}/targets/arm32/cm0/stm/f0xx/f030/deps)

include_directories(
#        ${toolchain}/targets/arm32/cm3/deps
#        ${toolchain}/targets/arm32/cm3/atmel/sam3x/deps
		${toolchain}/targets/arm32/cm0/stm/f0xx/f030/deps
)

#add_definitions(-D__SAM3X8E__)
#add_definitions(-DDONT_USE_CMSIS_INIT)

set(compile_flags " -mcpu=cortex-m0 -mthumb -g -fomit-frame-pointer -march=armv6s-m ")

set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} ${compile_flags} -fno-exceptions -fno-rtti"
)

set(CMAKE_C_FLAGS
        "${CMAKE_C_FLAGS} ${compile_flags}"
)
set_target_properties(${TARGET_NAME} PROPERTIES LINK_DEPENDS stm32f030-16k.ld)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}  -Wl,--map=${PROJECT_NAME}.map  -Tstm32f030-16k.ld -Wl,--gc-sections")


#SET(CMAKE_C_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m0 -Wall -std=gnu99 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")
#SET(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m0 -Wall -std=c++11 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")
#SET(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m0 -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
#
#SET(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections -mthumb -mcpu=cortex-m0 -mabi=aapcs -Tstm32f030-16k.ld" CACHE INTERNAL "executable linker flags")
#SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m0 -mabi=aapcs" CACHE INTERNAL "module linker flags")
#SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m0 -mabi=aapcs" CACHE INTERNAL "shared linker flags")

add_executable(${PROJECT_NAME}_f030.elf
        ${toolchain}/targets/arm32/cm0/stm/f0xx/f030/deps/startup.c
	    ${sources}
)

add_custom_target(${PROJECT_NAME}_f030.hex DEPENDS ${PROJECT_NAME}_f030.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}_f030.elf ${PROJECT_NAME}_f030.hex)
add_custom_target(${PROJECT_NAME}_f030.bin DEPENDS ${PROJECT_NAME}_f030.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}_f030.elf ${PROJECT_NAME}_f030.bin)
