#pragma once

#include <stdint.h> // uint8_t, uint16_t

int uint8_t_parse (
    char const * const buf,
    const int buf_len,
    uint8_t * result
);

int uint16_t_parse (
    char const * const buf,
    const int buf_len,
    uint16_t * result
);
