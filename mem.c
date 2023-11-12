#include "lib/mem.h"
#include "lib/arm_tags.h"
#include <stdint.h>
#include <stddef.h>

extern uint8_t __end__;
static uint32_t __num_pages__;

DEFINE_LIST(page);
IMPLEMENT_LIST(page);

static page_t *pages;
page_list_t free_pages;

uint32_t get_mem_size(atag_t *tag) {
    while (tag->tag != NONE) {
        if (tag->tag == MEM) {
            return tag->mem.size;
        }
        tag = ((uint32_t *)tag) + tag->tag_size;
    }
    return 0;
}
