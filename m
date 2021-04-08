From: David Hildenbrand <david@redhat.com>
Date: Thu, 8 Apr 2021 13:00:47 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
 <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
Message-ID: <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>>> In particular, it does not prevent a configuration with 'DRM_CMA=m'
>>
>> I assume you meant "DRM_CMA=n" ? DRM_CMA cannot be built as a module.
> 
> Ok, at least that makes it easier.
> 
>>> and 'DRMA_ASPEED_GFX=y', or any build failures from such
>>> a configuration.
>>
>> I don't follow. "DRM_CMA=n" and 'DRMA_ASPEED_GFX=y' is supposed to work
>> just fine (e.g., without HAVE_DMA_CONTIGUOUS) or what am I missing?
> 
> I thought you were trying to solve the problem where DRMA_ASPEED_GFX
> can optionally link against CMA but would fail to build when the CMA code
> is in a loadable module.

Yes. I was trying to say: it works with this patch just fine. The issue 
you described does not seem to apply (DRM_CMA=m).

> 
>> Your example looks more like a NOP - no?
>> Or will it have the same effect?
> 
> The example I gave is only meaningful if both are tristate, which is
> not the case here as you explain.

Okay, thanks.

> 
> It is a somewhat awkward way to say "prevent this symbol from
> being =y if the dependency is =m".

What would be the right thing to do in the case here then to achieve the 
"if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?

One approach could be to have for DMA_CMA

default y if DRMA_ASPEED_GFX

but it feels like the wrong way to tackle this.

Thanks!

-- 
Thanks,

David / dhildenb

