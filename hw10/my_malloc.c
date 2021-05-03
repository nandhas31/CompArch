/*
 * CS 2110 Homework 10 Spring 2021
 * Author:
 */

/* we need this for uintptr_t */
#include <stdint.h>
/* we need this for memcpy/memset */
#include <string.h>
/* we need this to print out stuff*/
#include <stdio.h>
/* we need this for the metadata_t struct and my_malloc_err enum definitions */
#include "my_malloc.h"

/* Function Headers
 * Here is a place to put all of your function headers
 * Remember to declare them as static
 */

/* Our freelist structure - our freelist is represented as a singly linked list
 * the freelist is sorted by address;
 */
metadata_t *address_list;

/* Set on every invocation of my_malloc()/my_free()/my_realloc()/
 * my_calloc() to indicate success or the type of failure. See
 * the definition of the my_malloc_err enum in my_malloc.h for details.
 * Similar to errno(3).
 */
enum my_malloc_err my_malloc_errno;

// -------------------- PART 1: Helper functions --------------------

/* The following prototypes represent useful helper functions that you may want
 * to use when writing your malloc functions. You do not have to implement them
 * first, but we recommend reading over their documentation and prototypes;
 * having a good idea of the kinds of helpers you can use will make it easier to
 * plan your code.
 *
 * None of these functions will be graded individually. However, implementing
 * and using these will make programming easier. We may provide ungraded test
 * cases for some of these functions after the assignment is released.
 */

/* OPTIONAL HELPER FUNCTION: find_right
 * Given a pointer to a free block, this function searches the freelist for another block to the right of the provided block.
 * If there is a free block that is directly next to the provided block on its right side,
 * then return a pointer to the start of the right-side block.
 * Otherwise, return null.
 * This function may be useful when implementing my_free().
 */
static metadata_t *find_right(metadata_t *freed_block);

/* OPTIONAL HELPER FUNCTION: find_left
 * This function is the same as find_right, but for the other side of the newly freed block.
 * This function will be useful for my_free(), but it is also useful for my_malloc(), since whenever you sbrk a new block,
 * you need to merge it with the block at the back of the freelist if the blocks are next to each other in memory.
 */

static metadata_t *find_left(metadata_t *freed_block);

/* OPTIONAL HELPER FUNCTION: merge
 * This function should take two pointers to blocks and merge them together.
 * The most important step is to increase the total size of the left block to include the size of the right block.
 * You should also copy the right block's next pointer to the left block's next pointer. If both blocks are initially in the freelist, this will remove the right block from the list.
 * This function will be useful for both my_malloc() (when you have to merge sbrk'd blocks) and my_free().
 */
static void merge(metadata_t *left, metadata_t *right);

/* OPTIONAL HELPER FUNCTION: split_block
 * This function should take a pointer to a large block and a requested size, split the block in two, and return a pointer to the new block (the right part of the split).
 * Remember that you must make the right side have the user-requested size when splitting. The left side of the split should have the remaining data.
 * We recommend doing the following steps:
 * 1. Compute the total amount of memory that the new block will take up (both metadata and user data).
 * 2. Using the new block's total size with the address and size of the old block, compute the address of the start of the new block.
 * 3. Shrink the size of the old/left block to account for the lost size. This block should stay in the freelist.
 * 4. Set the size of the new/right block and return it. This block should not go in the freelist.
 * This function will be useful for my_malloc(), particularly when the best-fit block is big enough to be split.
 */
static metadata_t *split_block(metadata_t *block, size_t size);

/* OPTIONAL HELPER FUNCTION: add_to_addr_list
 * This function should add a block to freelist.
 * Remember that the freelist must be sorted by address. You can compare the addresses of blocks by comparing the metadata_t pointers like numbers (do not dereference them).
 * Don't forget about the case where the freelist is empty. Remember what you learned from Homework 9.
 * This function will be useful for my_malloc() (mainly for adding in sbrk blocks) and my_free().
 */
static void add_to_addr_list(metadata_t *block);

/* OPTIONAL HELPER FUNCTION: remove_from_addr_list
 * This function should remove a block from the freelist.
 * Simply search through the freelist, looking for a node whose address matches the provided block's address.
 * This function will be useful for my_malloc(), particularly when the best-fit block is not big enough to be split.
 */
static void remove_from_addr_list(metadata_t *block);

/* OPTIONAL HELPER FUNCTION: find_best_fit
 * This function should find and return a pointer to the best-fit block. See the PDF for the best-fit criteria.
 * Remember that if you find the perfectly sized block, you should return it immediately.
 * You should not return an imperfectly sized block until you have searched the entire list for a potential perfect block.
 */
static metadata_t *find_best_fit(size_t size);

void *my_malloc(size_t size)
{
    my_malloc_errno = NO_ERROR;
    metadata_t *p, *p1;
    size_t total_size = size + TOTAL_METADATA_SIZE;

    if (total_size > SBRK_SIZE)
    {
        my_malloc_errno = SINGLE_REQUEST_TOO_LARGE;
        return NULL;
    }
    if (size == 0)
        return NULL;

    metadata_t *current = address_list;

    metadata_t *lowest = NULL;
    while (current != NULL && current->size != size)
    {
        p = current;
        p1 = p;
        if (current->size == size)
        {
            lowest = current;
            break;
        }
        if (current->size > size)
        {
            if (!lowest)
            {
                lowest = current;
            }
            else
            {
                if (current->size < lowest->size)
                    lowest = current;
            }
        }
        current = current->next;
    }

    if (current == NULL && lowest == NULL)
    {
        current = (metadata_t *)my_sbrk(SBRK_SIZE);
        if (current == NULL)
        {
            my_malloc_errno = OUT_OF_MEMORY;
            return NULL;
        }
        current->size = SBRK_SIZE - TOTAL_METADATA_SIZE;
        if (!address_list)
        {
            address_list = current;
        }
        else if ((uintptr_t)p + p->size + TOTAL_METADATA_SIZE == (uintptr_t)current)
        {
            p->size += current->size + TOTAL_METADATA_SIZE;
            p->next = NULL;
            current = p;
            p = p1;
        }
        else
        {
            p->next = current;
        }
    }
    if (!current)
    {
        current = lowest;
    }
    if (current->size - size < MIN_BLOCK_SIZE)
    {
        if (!p)
        {
            address_list = current->next;
        }
        else
        {
            p->next = current->next;
        }
        current->next = NULL;
        return (metadata_t *)((uint8_t *)current + TOTAL_METADATA_SIZE);
    }
    size_t old = current->size;
    current->size -= total_size;
    current->next = NULL;
    metadata_t *next = (metadata_t *)((uint8_t *)current + old - size);
    next->size = size;
    next->next = NULL;

    return (metadata_t *)((uint8_t *)next + TOTAL_METADATA_SIZE);
}

/* REALLOC
 * See PDF for documentation
 */
void *my_realloc(void *ptr, size_t size)
{
    if (ptr == NULL) {
        return my_malloc(size);
    }
    if (size == 0) {
        my_free(ptr);
        return NULL;
    } 

    metadata_t* actual_size = (metadata_t *) ((uint8_t *) ptr - TOTAL_METADATA_SIZE);

    if (size - actual_size->size == 0){
        return ptr;
    }
    void *realloc_pointer = malloc(size);
    if (realloc_pointer == NULL){
        return NULL;
    }
    void *new_ptr = my_malloc(size);
    if (!new_ptr) return NULL;

    if (size > actual_size->size) {
        memcpy(ptr, realloc_pointer, actual_size->size);
    } else {
        memcpy(ptr, realloc_pointer, size);
    }

    my_free(ptr);
    return realloc_pointer;
}

/* CALLOC
 * See PDF for documentation
 */
void *my_calloc(size_t nmemb, size_t size)
{
    my_malloc_errno = NO_ERROR;
    if (!nmemb || !size)
    {
        return NULL;
    }
    size_t total_size = nmemb * size;
    void *p = my_malloc(total_size);
    memset(p, 0, nmemb * size);
    return p;
}

/* FREE
 * See PDF for documentation
 */
void my_free(void *ptr)
{
    my_malloc_errno = NO_ERROR;
    if (!ptr)
        return;

    // Reminder for how to do free:
    // 1. Since ptr points to the start of the user block, obtain a pointer to the metadata for the freed block.
    // 2. Look for blocks in the freelist that are positioned immediately before or after the freed block.
    // 2.a. If a block is found before or after the freed block, then merge the blocks.
    // 3. Once the freed block has been merged (if needed), add the freed block back to the freelist.
    // 4. Alternatively, you can do step 3 before step 2. Add the freed block back to the freelist,
    // then search through the freelist for consecutive blocks that need to be merged.

    // A lot of these steps can be simplified by implementing helper functions. We highly recommend doing this!
}
