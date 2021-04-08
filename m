From: David Hildenbrand <david@redhat.com>
Date: Thu, 8 Apr 2021 18:44:23 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
 <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
 <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
 <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
Message-ID: <2ef3b65c-c0ef-7bbe-0e05-39ee8f2bae48@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08.04.21 14:49, Linus Walleij wrote:
> On Thu, Apr 8, 2021 at 2:01 PM David Hildenbrand <david@redhat.com> wrote:
> 
>>> This is something you could do using a hidden helper symbol like
>>>
>>> config DRMA_ASPEED_GFX
>>>          bool "Aspeed display driver"
>>>          select DRM_WANT_CMA
>>>
>>> config DRM_WANT_CMA
>>>          bool
>>>          help
>>>             Select this from any driver that benefits from CMA being enabled
>>>
>>> config DMA_CMA
>>>          bool "Use CMA helpers for DRM"
>>>          default DRM_WANT_CMA
>>>
>>>            Arnd
>>>
>>
>> That's precisely what I had first, with an additional "WANT_CMA" --  but
>> looking at the number of such existing options (I was able to spot 1 !)
> 
> If you do this it probably makes sense to fix a few other drivers
> Kconfig in the process. It's not just a problem with your driver.
> "my" drivers:
> 

:) I actually wanted to convert them to "depends on DMA_CMA" but ran 
into recursive dependencies ...

> drivers/gpu/drm/mcde/Kconfig
> drivers/gpu/drm/pl111/Kconfig
> drivers/gpu/drm/tve200/Kconfig

I was assuming these are "real" dependencies. Will it also work without 
DMA_CMA?

> 
> certainly needs this as well, and pretty much anything that is
> selecting DRM_KMS_CMA_HELPER or
> DRM_GEM_CMA_HELPER "wants" DMA_CMA.

"wants" as in "desires to use but can life without" or "wants" as in 
"really needs it". ?

-- 
Thanks,

David / dhildenb

