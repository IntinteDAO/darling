# Detect the location of compiler-specific header files
# such as stdbool.h or xmmintrin.h
function(GetCompilerInclude OutputVar)
	file(WRITE "${CMAKE_BINARY_DIR}/cinctest.c" "#include <stddef.h>")
	execute_process(COMMAND "${CMAKE_C_COMPILER}" -M "${CMAKE_BINARY_DIR}/cinctest.c"
		RESULT_VARIABLE BuildResult
		OUTPUT_VARIABLE BuildOutput
	)

	if (BuildResult)
		message(FATAL_ERROR "Cannot detect compiler header include path")
	endif (BuildResult)

	separate_arguments(BuildOutput)

	foreach (str ${BuildOutput})
		string(REGEX REPLACE "\n$" "" str "${str}")
		# message(STATUS "Output: ${str}")

		if (str MATCHES "stddef.h$")
			# message(STATUS "Str matched: ${str}")
			string(REGEX REPLACE "stddef\\.h" "" IncPath "${str}")
		endif (str MATCHES "stddef.h$")
	endforeach (str)

	if (NOT IncPath)
		message(FATAL_ERROR "Cannot parse compiler output to detect include path")
	endif (NOT IncPath)

	set(${OutputVar} ${IncPath} PARENT_SCOPE)
endfunction(GetCompilerInclude)

