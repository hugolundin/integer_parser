#ifdef DEBUG
#warning Building in DEBUG mode.
#endif
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

%%{
    machine uint16_t_parser;

    action copy {
        *result *= 10;
        *result += *p - '0';
    }

    action error {
        #ifdef DEBUG
            fprintf(stderr,
                "uint16_t_parse failed here: "
                "p='%.16s', *p='%02x', state='%d', "
                "buf='%.*s', buf_len='%ld', index='%d'\n",
                p, *p, fcurs, buf_len, buf, p - buf, buf_len
            );
        #endif
    }

    uint16_t = 
    ( '0' 
    | [1-5][0-9]{0,4}
    | '6'
        ( [0-4][0-9]{0,3}
        | '5'
            ( [0-4][0-9]{0,2}
            | '5'
                ( [0-2][0-9]?
                | '3' [0-5]?
                | [4-9]
                )?
            | [6-9][0-9]{0,1}
            )?
        | [6-9][0-9]{0,2}
        )?
    | [7-9][0-9]{0,3}
    );

    main := uint16_t $copy $err(error);

    write data;
}%%

int uint16_t_parse (
    char const * const buf,
    const int buf_len,
    uint8_t * result
)
{      
    int cs;
    *result = 0;

    %% write init;
    
    const char * p = buf;
    const char * pe = buf + buf_len;
    const char * eof = 0;

    %% write exec;

    if (cs == %%{ write error; }%%) {
        return -1;
    }
    if (cs < %%{ write first_final; }%%) {
        return -1;
    }

    return 0;
}
