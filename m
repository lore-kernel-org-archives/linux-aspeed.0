From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Apr 2021 12:44:46 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
Message-ID: <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 8, 2021 at 12:29 PM David Hildenbrand <david@redhat.com> wrote:
> On 08.04.21 12:20, Arnd Bergmann wrote:
> > On Thu, Apr 8, 2021 at 11:22 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> Random drivers should not override a user configuration of core knobs
> >> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
> >> dependencies and manual overrides.
> >>
> >> "This is similar to "select" as it enforces a lower limit on another
> >>   symbol except that the "implied" symbol's value may still be set to n
> >>   from a direct dependency or with a visible prompt."
> >>
> >> Implying DRM_CMA should be sufficient, as that depends on CMA.
> >>
> >> Note: If this is a real dependency, we should use "depends on DMA_CMA"
> >> instead -  but I assume the driver can work without CMA just fine --
> >> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.
> >
> > 'imply' is almost never the right solution, and it tends to cause more
> > problems than it solves.
>
> I thought that was the case with "select" :)

Yes, but that's a different set of problems

> >
> > In particular, it does not prevent a configuration with 'DRM_CMA=m'
>
> I assume you meant "DRM_CMA=n" ? DRM_CMA cannot be built as a module.

Ok, at least that makes it easier.

> > and 'DRMA_ASPEED_GFX=y', or any build failures from such
> > a configuration.
>
> I don't follow. "DRM_CMA=n" and 'DRMA_ASPEED_GFX=y' is supposed to work
> just fine (e.g., without HAVE_DMA_CONTIGUOUS) or what am I missing?

I thought you were trying to solve the problem where DRMA_ASPEED_GFX
can optionally link against CMA but would fail to build when the CMA code
is in a loadable module.

If the problem you are trying to solve is a different one, you need a different
solution, not what I posted above.

> > If you want this kind of soft dependency, you need
> > 'depends on DRM_CMA || !DRM_CMA'.
>
> Seriously? I think the point of imply is "please enable if possible and
> not prevented by someone else".

That used to be the meaning, but it changed a few years ago. Now
it means "when a used manually turns on this symbol, turn on the
implied one as well, but let them turn it off again if they choose".

This is pretty much a NOP.

> Your example looks more like a NOP - no?
> Or will it have the same effect?

The example I gave is only meaningful if both are tristate, which is
not the case here as you explain.

It is a somewhat awkward way to say "prevent this symbol from
being =y if the dependency is =m".

      Arnd
