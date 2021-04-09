From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Apr 2021 15:35:03 +0200
Subject: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
In-Reply-To: <20210409112035.27221-1-david@redhat.com>
References: <20210409112035.27221-1-david@redhat.com>
Message-ID: <CAK8P3a31uKNcim0n99=yt3zjZ+LQSw4V4+8PS8daLsBdS0iSYg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 9, 2021 at 1:21 PM David Hildenbrand <david@redhat.com> wrote:
>
> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Applicable drivers would like to use DMA_CMA,
> which depends on CMA, if possible; however, these drivers also have to
> tolerate if DMA_CMA is not available/functioning, for example, if no CMA
> area for DMA_CMA use has been setup via "cma=X". In the worst case, the
> driver cannot do it's job properly in some configurations.
>
> For example, commit 63f5677544b3 ("drm/etnaviv: select CMA and DMA_CMA if
> available") documents
>         While this is no build dependency, etnaviv will only work correctly
>         on most systems if CMA and DMA_CMA are enabled. Select both options
>         if available to avoid users ending up with a non-working GPU due to
>         a lacking kernel config.
> So etnaviv really wants to have DMA_CMA, however, can deal with some cases
> where it is not available.
>
> Let's introduce WANT_DMA_CMA and use it in most cases where drivers
> select CMA/DMA_CMA, or depend on DMA_CMA (in a wrong way via CMA because
> of recursive dependency issues).
>
> We'll assume that any driver that selects DRM_GEM_CMA_HELPER or
> DRM_KMS_CMA_HELPER would like to use DMA_CMA if possible.
>
> With this change, distributions can disable CONFIG_CMA or
> CONFIG_DMA_CMA, without it silently getting enabled again by random
> drivers. Also, we'll now automatically try to enabled both, CONFIG_CMA
> and CONFIG_DMA_CMA if they are unspecified and any driver is around that
> selects WANT_DMA_CMA -- also implicitly via DRM_GEM_CMA_HELPER or
> DRM_KMS_CMA_HELPER.
>
> For example, if any driver selects WANT_DMA_CMA and we do a
> "make olddefconfig":
>
> 1. With "# CONFIG_CMA is not set" and no specification of
>    "CONFIG_DMA_CMA"
>
> -> CONFIG_DMA_CMA won't be part of .config
>
> 2. With no specification of CONFIG_CMA or CONFIG_DMA_CMA
>
> Contiguous Memory Allocator (CMA) [Y/n/?] (NEW)
> DMA Contiguous Memory Allocator (DMA_CMA) [Y/n/?] (NEW)
>
> 3. With "# CONFIG_CMA is not set" and "# CONFIG_DMA_CMA is not set"
>
> -> CONFIG_DMA_CMA will be removed from .config
>
> Note: drivers/remoteproc seems to be special; commit c51e882cd711
> ("remoteproc/davinci: Update Kconfig to depend on DMA_CMA") explains that
> there is a real dependency to DMA_CMA for it to work; leave that dependency
> in place and don't convert it to a soft dependency.

I don't think this dependency is fundamentally different from the others,
though davinci machines tend to have less memory than a lot of the
other machines, so it's more likely to fail without CMA.

Regardless of this,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
