From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Apr 2021 13:44:22 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
 <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
Message-ID: <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 8, 2021 at 1:00 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > It is a somewhat awkward way to say "prevent this symbol from
> > being =y if the dependency is =m".
>
> What would be the right thing to do in the case here then to achieve the
> "if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?
>
> One approach could be to have for DMA_CMA
>
> default y if DRMA_ASPEED_GFX
>
> but it feels like the wrong way to tackle this.

I'm still not sure what you are trying to achieve. Is the idea only to provide
a useful default for DMA_CMA depending on which drivers are enabled?

This is something you could do using a hidden helper symbol like

config DRMA_ASPEED_GFX
       bool "Aspeed display driver"
       select DRM_WANT_CMA

config DRM_WANT_CMA
       bool
       help
          Select this from any driver that benefits from CMA being enabled

config DMA_CMA
       bool "Use CMA helpers for DRM"
       default DRM_WANT_CMA

         Arnd
