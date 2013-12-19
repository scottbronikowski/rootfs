/*
 * Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2005 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2005 High Performance Computing Center Stuttgart, 
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2005 The Regents of the University of California.
 *                         All rights reserved.
 * $COPYRIGHT$
 * 
 * Additional copyrights may follow
 * 
 * $HEADER$
 */

#ifndef OMPI_SYS_ARCH_ATOMIC_H
#define OMPI_SYS_ARCH_ATOMIC_H 1

/*
 * On armv7, everything is load-locked, store-conditional...
 */

#if OMPI_WANT_SMP_LOCKS
#define MB()  __sync_synchronize();
#define RMB() MB()
#define WMB() MB();

#else

#define MB()
#define RMB()
#define WMB()

#endif


/**********************************************************************
 *
 * Define constants for ARM
 *
 *********************************************************************/
#define OPAL_HAVE_ATOMIC_MEM_BARRIER 1

#define OPAL_HAVE_ATOMIC_CMPSET_32 1
#define OPAL_HAVE_ATOMIC_MATH_32 1
#define OPAL_HAVE_ATOMIC_ADD_32 1
#define OPAL_HAVE_ATOMIC_SUB_32 1

#define OPAL_HAVE_ATOMIC_CMPSET_64 0
#define OPAL_HAVE_ATOMIC_MATH_64 0
#define OPAL_HAVE_ATOMIC_ADD_64 0
#define OPAL_HAVE_ATOMIC_SUB_64 0

/**********************************************************************
 *
 * Memory Barriers
 *
 *********************************************************************/

static inline void opal_atomic_mb(void)
{
    MB();
}


static inline void opal_atomic_rmb(void)
{
    RMB();
}


static inline void opal_atomic_wmb(void)
{
    WMB();
}


/**********************************************************************
 *
 * Atomic math operations
 *
 *********************************************************************/

static inline int opal_atomic_cmpset_32( volatile int32_t *addr,
                                         int32_t oldval, int32_t newval)
{
    return __sync_bool_compare_and_swap(addr, oldval, newval);
}

static inline int opal_atomic_cmpset_acq_32(volatile int32_t *addr,
                                           int32_t oldval,
                                           int32_t newval)
{
    int rc;

    rc = opal_atomic_cmpset_32(addr, oldval, newval);
    opal_atomic_rmb();

    return rc;
}


static inline int opal_atomic_cmpset_rel_32(volatile int32_t *addr,
                                           int32_t oldval,
                                           int32_t newval)
{
    opal_atomic_wmb();
    return opal_atomic_cmpset_32(addr, oldval, newval);
}


static inline int opal_atomic_cmpset_64( volatile int64_t *addr,
                                         int64_t oldval, int64_t newval)
{
    return __sync_bool_compare_and_swap(addr, oldval, newval);
}


static inline int opal_atomic_cmpset_acq_64(volatile int64_t *addr,
                                           int64_t oldval,
                                           int64_t newval)
{
    int rc;

    rc = opal_atomic_cmpset_64(addr, oldval, newval);
    opal_atomic_rmb();

    return rc;
}


static inline int opal_atomic_cmpset_rel_64(volatile int64_t *addr,
                                           int64_t oldval,
                                           int64_t newval)
{
    opal_atomic_wmb();
    return opal_atomic_cmpset_64(addr, oldval, newval);
}

static inline int32_t opal_atomic_add_32(volatile int32_t* v, int inc)
{
   return __sync_add_and_fetch(v, inc);
}

static inline int64_t opal_atomic_sub_64(volatile int64_t* v, int64_t dec)
{
   return __sync_sub_and_fetch(v, dec);
}

static inline int64_t opal_atomic_add_64(volatile int64_t* v, int64_t inc)
{
   return __sync_add_and_fetch(v, inc);
}


static inline int32_t opal_atomic_sub_32(volatile int32_t* v, int dec)
{
   return __sync_sub_and_fetch(v, dec);
}
#endif /* ! OMPI_SYS_ARCH_ATOMIC_H */
