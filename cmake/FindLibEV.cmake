# This file is from the lighttpd2 project
# http://github.com/lighttpd/lighttpd2

# The MIT License
# Copyright (c) 2004-2008 Jan Kneschke
# Copyright (c) 2008-2010 Stefan Bühler
# Copyright (c) 2008-2010 Thomas Porzelt
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

SET(LIBEV_PATH "" CACHE PATH "Base path for include/ev.h and lib/libev*")
SET(LIBEV_INCLUDE_PATH "" CACHE PATH "Include path for ev.h")
SET(LIBEV_LIBDIR "" CACHE PATH "Path containing libev")

IF(LIBEV_PATH)
	SET(LIBEV_INCLUDE_PATH "${LIBEV_PATH}/include" CACHE PATH "Include path for ev.h" FORCE)
	SET(LIBEV_LIBDIR "${LIBEV_PATH}/lib" CACHE PATH "Path containing libev" FORCE)
ENDIF(LIBEV_PATH)

IF(LIBEV_INCLUDE_PATH)
	INCLUDE_DIRECTORIES(${LIBEV_INCLUDE_PATH})
ENDIF(LIBEV_INCLUDE_PATH)

# Use cached result
IF(NOT LIBEV_FOUND)
	UNSET(HAVE_EV_H)
	UNSET(HAVE_LIBEV)
	UNSET(HAVE_EV_H CACHE)
	UNSET(HAVE_LIBEV CACHE)
	UNSET(LIBEV_CFLAGS)
	UNSET(LIBEV_LDFLAGS)

	IF(LIBEV_INCLUDE_PATH OR LIBEV_LIBDIR)
		SET(CMAKE_REQUIRED_INCLUDES ${LIBEV_INCLUDE_PATH})
# 		MESSAGE(STATUS "Looking for ev.h in ${CMAKE_REQUIRED_INCLUDES}")
		CHECK_INCLUDE_FILES(ev.h HAVE_EV_H)
		IF(HAVE_EV_H)
# 			MESSAGE(STATUS "Looking for lib ev in ${LIBEV_LIBDIR}")
			CHECK_LIBRARY_EXISTS(ev ev_time "${LIBEV_LIBDIR}" HAVE_LIBEV)
			IF(HAVE_LIBEV)
				SET(LIBEV_LIBRARIES ev CACHE INTERNAL "")
				SET(LIBEV_CFLAGS "" CACHE INTERNAL "")
				SET(LIBEV_LDFLAGS "-L${LIBEV_LIBDIR} -lev" CACHE INTERNAL "")
				SET(LIBEV_FOUND TRUE CACHE INTERNAL "Found libev" FORCE)
			ELSE(HAVE_LIBEV)
				MESSAGE(STATUS "Couldn't find lib ev in ${LIBEV_LIBDIR}")
			ENDIF(HAVE_LIBEV)
		ELSE(HAVE_EV_H)
			MESSAGE(STATUS "Couldn't find <ev.h> in ${LIBEV_INCLUDE_PATH}")
		ENDIF(HAVE_EV_H)
	ELSE(LIBEV_INCLUDE_PATH OR LIBEV_LIBDIR)
		pkg_check_modules(LIBEV libev)
		IF(NOT LIBEV_FOUND)
# 			MESSAGE(STATUS "Looking for ev.h in ${CMAKE_REQUIRED_INCLUDES}")
			CHECK_INCLUDE_FILES(ev.h HAVE_EV_H)
			IF(HAVE_EV_H)
# 				MESSAGE(STATUS "Looking for lib ev")
				CHECK_LIBRARY_EXISTS(ev ev_time "" HAVE_LIBEV)
				IF(HAVE_LIBEV)
					SET(LIBEV_CFLAGS "" CACHE INTERNAL "")
					SET(LIBEV_LDFLAGS "-lev" CACHE INTERNAL "")
					SET(LIBEV_FOUND TRUE CACHE INTERNAL "Found libev" FORCE)
				ELSE(HAVE_LIBEV)
					MESSAGE(STATUS "Couldn't find lib ev")
				ENDIF(HAVE_LIBEV)
			ELSE(HAVE_EV_H)
				MESSAGE(STATUS "Couldn't find <ev.h>")
			ENDIF(HAVE_EV_H)
		ENDIF(NOT LIBEV_FOUND)
	ENDIF(LIBEV_INCLUDE_PATH OR LIBEV_LIBDIR)

ENDIF(NOT LIBEV_FOUND)

IF(NOT LIBEV_FOUND)
	IF(LibEV_FIND_REQUIRED)
		MESSAGE(FATAL_ERROR "Could not find libev")
	ENDIF(LibEV_FIND_REQUIRED)
ENDIF(NOT LIBEV_FOUND)

MARK_AS_ADVANCED(LIBEV_PATH LIBEV_INCLUDE_PATH LIBEV_LIBDIR)
