#ifndef __MEM_H__
#define __MEM_H__
#include "arm_tags.h"
#include "core.h"

#define PAGE_SZ 4096

typedef struct {
    uint8_t allocated: 1;   // allocated pages
    uint8_t kernel_pg: 1;   // kernel pages
    uint32_t reserved: 30;  // reserved pages
} page_flags_t;

typedef struct page {
    uint32_t mapped_vaddr;  // virtual addresses mapped
    page_flags_t flags;     // page flags
    DEFINE_LINK(page);
} page_t;


void mem_init(atag_t *atags);

/** 
 * Page Allocate
 */
void *palloc(void);

/**
 * Page Free
 */
void pfree(void *page_ptr);

/**
 * Get memory size
 */
uint32_t get_mem_size(atag_t *atags);

#endif
