From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Apr 2021 12:20:50 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <20210408092011.52763-3-david@redhat.com>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
Message-ID: <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 8, 2021 at 11:22 AM David Hildenbrand <david@redhat.com> wrote:
>
> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
> dependencies and manual overrides.
>
> "This is similar to "select" as it enforces a lower limit on another
>  symbol except that the "implied" symbol's value may still be set to n
>  from a direct dependency or with a visible prompt."
>
> Implying DRM_CMA should be sufficient, as that depends on CMA.
>
> Note: If this is a real dependency, we should use "depends on DMA_CMA"
> instead -  but I assume the driver can work without CMA just fine --
> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.

'imply' is almost never the right solution, and it tends to cause more
problems than it solves.

In particular, it does not prevent a configuration with 'DRM_CMA=m'
and 'DRMA_ASPEED_GFX=y', or any build failures from such
a configuration.

If you want this kind of soft dependency, you need
'depends on DRM_CMA || !DRM_CMA'.

         Arnd
