From: David Hildenbrand <david@redhat.com>
Date: Thu, 8 Apr 2021 14:00:48 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
 <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
 <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
Message-ID: <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08.04.21 13:44, Arnd Bergmann wrote:
> On Thu, Apr 8, 2021 at 1:00 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> It is a somewhat awkward way to say "prevent this symbol from
>>> being =y if the dependency is =m".
>>
>> What would be the right thing to do in the case here then to achieve the
>> "if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?
>>
>> One approach could be to have for DMA_CMA
>>
>> default y if DRMA_ASPEED_GFX
>>
>> but it feels like the wrong way to tackle this.
> 
> I'm still not sure what you are trying to achieve. Is the idea only to provide
> a useful default for DMA_CMA depending on which drivers are enabled?

"Random drivers should not override a user configuration of core knobs
(e.g., CONFIG_DMA_CMA=n)."

Let's assume I'm a distribution and want to set CONFIG_CMA=n or want to 
set CONFIG_DMA_CMA=n with CONFIG_CMA=y; there is no way to do that with 
e.g., DRMA_ASPEED_GFX=y because it will always override my (user!) 
setting -- even though it doesn't really always need it. Using "select" 
is the problem here.

> 
> This is something you could do using a hidden helper symbol like
> 
> config DRMA_ASPEED_GFX
>         bool "Aspeed display driver"
>         select DRM_WANT_CMA
> 
> config DRM_WANT_CMA
>         bool
>         help
>            Select this from any driver that benefits from CMA being enabled
> 
> config DMA_CMA
>         bool "Use CMA helpers for DRM"
>         default DRM_WANT_CMA
> 
>           Arnd
> 

That's precisely what I had first, with an additional "WANT_CMA" --  but 
looking at the number of such existing options (I was able to spot 1 !) 
I wondered if there is a better approach to achieve the same; "imply" 
sounded like a good candidate.

-- 
Thanks,

David / dhildenb

