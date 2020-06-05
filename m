From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 5 Jun 2020 16:40:07 +0100
Subject: [PATCH v3 00/43] Convert most CMA-based drivers to GEM object
 functions
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <CACvgo501LS_pcuiM_=BonJTnWEkcjC4m5yueEeJyv_c9Q8MAvQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

On Fri, 5 Jun 2020 at 08:33, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Most of the CMA-based drivers use the default implementation for the
> callbacks in struct drm_driver. With this patch, these interfaces are
> initialized with a common helper macro and GEM object functions replace
> several deprecated interfaces.
>
> To address Laurent's comment on the amount of changes per patch, I re-
> organized the series.
>
>  1) There are now DRIVER_OPS macros for drivers that require a virtual
>     address on imported buffers, and macros for drivers that don't. Therefore,
>     drivers don't switch to drm_gem_cma_prime_import_sg_table_vmap()
>     implicitly when they begin using the DRIVER_OPS macro.
>
>  2) I split each driver's patch into two: the first converts the driver to
>     GEM CMA object functions, the second introduces the DRIVER_OPS macro.
>     Neither patch should result in a functional change. I kept existing R-b
>     and A-b tags on both patches. Existing Tested-by tags are only on the
>     final patch, as that's closest to what has been tested.
>
>  3) I dropped the conversion to drm_gem_prime_mmap() from the patchset. As
>     part of this change, the CMA object functions could provide an mmap
>     function, which is worth it's own series. The patch for aspeed requires
>     drm_gem_prime_mmap(), so I removed it from the series.
>
> Patches 1 to 3 update the existing macro and helper to similar naming as with
> SHMEM, add a new DRIVER_OPS macro, and add helpers for drivers that override
> the default implementation for .dumb_create(). The remaining patches up to
> the final one convert the drivers. The kirin driver also changes to the
> default dumb_create function. The final patch deletes .gem_print_info from
> struct drm_driver.
>
> I don't have much of the hardware, so it's only compile-tested on aarch64,
> arm and x86-64 only. Several patches have Tested-by tags.
>

For the whole updated series:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
