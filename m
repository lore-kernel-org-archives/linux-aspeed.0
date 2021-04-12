From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 12 Apr 2021 14:12:20 +0100
Subject: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
In-Reply-To: <53ec94ac-ffe3-d0bc-d081-3489fa03daa1@redhat.com>
References: <20210409112035.27221-1-david@redhat.com>
 <CAK8P3a31uKNcim0n99=yt3zjZ+LQSw4V4+8PS8daLsBdS0iSYg@mail.gmail.com>
 <53ec94ac-ffe3-d0bc-d081-3489fa03daa1@redhat.com>
Message-ID: <34350446-0e0e-6947-40bd-fabdccdc835f@arm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021-04-09 14:39, David Hildenbrand wrote:
> On 09.04.21 15:35, Arnd Bergmann wrote:
>> On Fri, Apr 9, 2021 at 1:21 PM David Hildenbrand <david@redhat.com> 
>> wrote:
>>>
>>> Random drivers should not override a user configuration of core knobs
>>> (e.g., CONFIG_DMA_CMA=n). Applicable drivers would like to use DMA_CMA,
>>> which depends on CMA, if possible; however, these drivers also have to
>>> tolerate if DMA_CMA is not available/functioning, for example, if no CMA
>>> area for DMA_CMA use has been setup via "cma=X". In the worst case, the
>>> driver cannot do it's job properly in some configurations.
>>>
>>> For example, commit 63f5677544b3 ("drm/etnaviv: select CMA and 
>>> DMA_CMA if
>>> available") documents
>>> ???????? While this is no build dependency, etnaviv will only work 
>>> correctly
>>> ???????? on most systems if CMA and DMA_CMA are enabled. Select both 
>>> options
>>> ???????? if available to avoid users ending up with a non-working GPU 
>>> due to
>>> ???????? a lacking kernel config.
>>> So etnaviv really wants to have DMA_CMA, however, can deal with some 
>>> cases
>>> where it is not available.
>>>
>>> Let's introduce WANT_DMA_CMA and use it in most cases where drivers
>>> select CMA/DMA_CMA, or depend on DMA_CMA (in a wrong way via CMA because
>>> of recursive dependency issues).
>>>
>>> We'll assume that any driver that selects DRM_GEM_CMA_HELPER or
>>> DRM_KMS_CMA_HELPER would like to use DMA_CMA if possible.
>>>
>>> With this change, distributions can disable CONFIG_CMA or
>>> CONFIG_DMA_CMA, without it silently getting enabled again by random
>>> drivers. Also, we'll now automatically try to enabled both, CONFIG_CMA
>>> and CONFIG_DMA_CMA if they are unspecified and any driver is around that
>>> selects WANT_DMA_CMA -- also implicitly via DRM_GEM_CMA_HELPER or
>>> DRM_KMS_CMA_HELPER.
>>>
>>> For example, if any driver selects WANT_DMA_CMA and we do a
>>> "make olddefconfig":
>>>
>>> 1. With "# CONFIG_CMA is not set" and no specification of
>>> ??? "CONFIG_DMA_CMA"
>>>
>>> -> CONFIG_DMA_CMA won't be part of .config
>>>
>>> 2. With no specification of CONFIG_CMA or CONFIG_DMA_CMA
>>>
>>> Contiguous Memory Allocator (CMA) [Y/n/?] (NEW)
>>> DMA Contiguous Memory Allocator (DMA_CMA) [Y/n/?] (NEW)
>>>
>>> 3. With "# CONFIG_CMA is not set" and "# CONFIG_DMA_CMA is not set"
>>>
>>> -> CONFIG_DMA_CMA will be removed from .config
>>>
>>> Note: drivers/remoteproc seems to be special; commit c51e882cd711
>>> ("remoteproc/davinci: Update Kconfig to depend on DMA_CMA") explains 
>>> that
>>> there is a real dependency to DMA_CMA for it to work; leave that 
>>> dependency
>>> in place and don't convert it to a soft dependency.
>>
>> I don't think this dependency is fundamentally different from the others,
>> though davinci machines tend to have less memory than a lot of the
>> other machines, so it's more likely to fail without CMA.
>>
> 
> I was also unsure - and Lucas had similar thoughts. If you want, I can 
> send a v4 also taking care of this.

TBH I think it should all just be removed. DMA_CMA is effectively an 
internal feature of the DMA API, and drivers which simply use the DMA 
API shouldn't really be trying to assume *how* things might be allocated 
at runtime - CMA is hardly the only way. Platform-level assumptions 
about the presence or not of IOMMUs, memory carveouts, etc., and whether 
it even matters - e.g. a device with a tiny LCD may only need display 
buffers which still fit in a regular MAX_ORDER allocation - could go in 
platform-specific configs, but I really don't think they belong at the 
generic subsystem level.

We already have various examples like I2S drivers that won't even probe 
without a dmaengine provider being present, or host controller drivers 
which are useless without their corresponding phy driver (and I'm 
guessing you can probably also do higher-level things like include the 
block layer but omit all filesystem drivers). I don't believe it's 
Kconfig's job to try to guess whether a given configuration is *useful*, 
only to enforce that's it's valid to build.

Robin.
