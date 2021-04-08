From: David Hildenbrand <david@redhat.com>
Date: Thu, 8 Apr 2021 11:57:31 +0200
Subject: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
In-Reply-To: <YG7TZa8VP458QS5y@kernel.org>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com> <YG7TZa8VP458QS5y@kernel.org>
Message-ID: <9826d7ef-7f7e-987e-c305-7ae3c533d591@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08.04.21 11:56, Mike Rapoport wrote:
> On Thu, Apr 08, 2021 at 11:20:11AM +0200, David Hildenbrand wrote:
>> Random drivers should not override a user configuration of core knobs
>> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
>> dependencies and manual overrides.
>>
>> "This is similar to "select" as it enforces a lower limit on another
>>   symbol except that the "implied" symbol's value may still be set to n
>>   from a direct dependency or with a visible prompt."
>>
>> Implying DRM_CMA should be sufficient, as that depends on CMA.
> 
>            ^ DMA_CMA
>>
>> Note: If this is a real dependency, we should use "depends on DMA_CMA"
>> instead -  but I assume the driver can work without CMA just fine --
>> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/gpu/drm/aspeed/Kconfig  | 3 +--
>>   drivers/gpu/drm/etnaviv/Kconfig | 3 +--
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
>> index 5e95bcea43e9..a055f763d230 100644
>> --- a/drivers/gpu/drm/aspeed/Kconfig
>> +++ b/drivers/gpu/drm/aspeed/Kconfig
>> @@ -6,9 +6,8 @@ config DRM_ASPEED_GFX
>>   	depends on MMU
>>   	select DRM_KMS_HELPER
>>   	select DRM_KMS_CMA_HELPER
>> -	select DMA_CMA if HAVE_DMA_CONTIGUOUS
>> -	select CMA if HAVE_DMA_CONTIGUOUS
>>   	select MFD_SYSCON
>> +	imply DRM_CMA
> 
> Ditto

Gah, thanks!


-- 
Thanks,

David / dhildenb

