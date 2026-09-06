project(bsdln)

add_executable(bsdln
	ln.c
)
if (NOT (ANDROID OR CMAKE_SYSTEM_NAME MATCHES "Android"))
	target_link_libraries(bsdln bsd)
endif()
