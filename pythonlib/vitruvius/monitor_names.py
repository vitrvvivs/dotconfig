#!/usr/bin/env python
# parse edid to find monitor name
from pathlib import Path
from typing import Iterator, Tuple

def find_name(edid: bytes) -> str:
    # https://en.wikipedia.org/wiki/Extended_Display_Identification_Data#Display_Descriptors
    offsets = (54, 72, 90, 108)
    text_codes = (0xFC, 0xFE, 0xFF)  # display name, unspecified text, or serial number

    for offset in offsets:
        if edid[offset] == 0 and edid[offset + 3] in text_codes:
            text = edid[offset + 5:offset + 18]
            return format_text(text)
    return "unknown"

def format_text(text: bytes) -> str:
    string = text.decode('cp437').strip()
    # I don't know why SHARP used 0x80 to separate model with submodel, but I don't like it
    string = string.replace('Ç', '-')
    return string

def all_names() -> Iterator[Tuple[str, str]]: # ("LG Ultra HD", "DP1")
    sysdir = Path("/sys/class/drm/")
    for port in sysdir.iterdir():
        if not port.is_dir() or not (port / "edid").is_file(): continue
        edid = (port / "edid").read_bytes()
        interface = port.name.split('-', 1)[1].replace('-', '')
        if edid:
            yield (find_name(edid), interface)
            continue

if __name__ == '__main__':
    print(','.join(':'.join(pair) for pair in all_names()))
