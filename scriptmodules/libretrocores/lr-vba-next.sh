#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vba-next"
rp_module_desc="GBA emulator - VBA-M (optimised) port for libretro"
rp_module_menus="2+"
rp_module_flags="!rpi1"

function sources_lr-vba-next() {
    gitPullOrClone "$md_build" https://github.com/libretro/vba-next.git
}

function build_lr-vba-next() {
    make -f Makefile.libretro clean
    case "$__platform" in
        rpi2)
            make -f Makefile.libretro platform=armvhardfloatunix TILED_RENDERING=1 HAVE_NEON=1
            ;;
        *)
            make -f Makefile.libretro
            ;;
    esac
    md_ret_require="$md_build/vba_next_libretro.so"
}

function install_lr-vba-next() {
    md_ret_files=(
        'vba_next_libretro.so'
    )
}

function configure_lr-vba-next() {
    # remove old install folder
    rm -rf "$rootdir/$md_type/vba-next"

    mkRomDir "gba"
    ensureSystemretroconfig "gba"

    delSystem "$md_id" "gba-vba-next"
    addSystem 0 "$md_id" "gba" "$md_inst/vba_next_libretro.so"
}
