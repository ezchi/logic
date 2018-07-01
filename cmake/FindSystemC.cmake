# Copyright 2018 Tymoteusz Blazejczyk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#.rst:
# FindSystemC
# --------
#
# Find SystemC
#
# Find the native SystemC headers and libraries.
#
# ::
#
#   SYSTEMC_INCLUDE_DIRS   - where to find SystemC header files, etc.
#   SYSTEMC_LIBRARIES      - list of libraries when using SystemC
#   SYSTEMC_FOUND          - true if SystemC found

if (COMMAND _find_systemc)
    return()
endif()

option(SYSTEMC_HOME "SystemC home directory" $ENV{SYSTEMC_HOME})
option(SCV_HOME "SCV home directory" $ENV{SCV_HOME})
option(UVM_SYSTEMC_HOME "SystemC home directory" $ENV{UVM_SYSTEMC_HOME})

function(_find_systemc)
    set(CMAKE_PREFIX_PATH ${SYSTEMC_HOME})
    find_package(SystemCLanguage CONFIG REQUIRED)

    set (CMAKE_CXX_STANDARD ${SystemC_CXX_STANDARD} CACHE STRING
        "C++ standard to build all targets. Supported values are 98, 11, and 14.")
    set (CMAKE_CXX_STANDARD_REQUIRED ${SystemC_CXX_STANDARD_REQUIRED} CACHE BOOL
        "The with CMAKE_CXX_STANDARD selected C++ standard is a requirement.")

    set(CMAKE_PREFIX_PATH ${SCV_HOME})
    find_package(scv CONFIG REQUIRED)

    set(CMAKE_PREFIX_PATH ${UVM_SYSTEMC_HOME})
    find_package(UVMSystemC CONFIG REQUIRED)
endfunction()

_find_systemc()

get_target_property(SYSTEMC_INCLUDE SystemC::systemc INTERFACE_INCLUDE_DIRECTORIES)
get_target_property(UVM_SYSTEMC_INCLUDE UVMSystemC::uvm-systemc INTERFACE_INCLUDE_DIRECTORIES)
get_target_property(SCV_INCLUDE scv::scv INTERFACE_INCLUDE_DIRECTORIES)
