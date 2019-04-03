From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 3 Apr 2019 09:35:20 -0500
Subject: [PATCH 2/5] media: platform: Aspeed: Make reserved memory optional
In-Reply-To: <7effb2de-cc91-47af-88a2-a0075262e9c4@www.fastmail.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-3-git-send-email-eajames@linux.ibm.com>
 <7effb2de-cc91-47af-88a2-a0075262e9c4@www.fastmail.com>
Message-ID: <dd017f44-5d1d-d657-b159-c9dbaadd795f@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/3/19 1:01 AM, Andrew Jeffery wrote:
>
> On Wed, 3 Apr 2019, at 04:55, Eddie James wrote:
>> Reserved memory doesn't need to be required; system memory would work
>> fine.
> I had to do a bit of legwork to understand what you were doing here. My
> understanding is that we allocate out of the default CMA region if the
> memory-region property isn't specified. Is that what you're expecting?
> Could be helpful to be a little less terse in the commit message.


Correct.


>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c
>> b/drivers/media/platform/aspeed-video.c
>> index 55c55a6..8144fe3 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1608,11 +1608,7 @@ static int aspeed_video_init(struct aspeed_video
>> *video)
>>   		return PTR_ERR(video->vclk);
>>   	}
>>   
>> -	rc = of_reserved_mem_device_init(dev);
>> -	if (rc) {
>> -		dev_err(dev, "Unable to reserve memory\n");
>> -		return rc;
>> -	}
>> +	of_reserved_mem_device_init(dev);
> You're ignoring *all* errors here with the expectation that the cause is the
> missing memory-region property. However, other errors can propagate
> out of of_reserved_mem_device_init() - e.g. ENOMEM. Rather than remove
> error checking, I think you should explicitly test for ENODEV, which is what is
> returned if the memory-region property is absent.


But it doesn't matter if it fails for any reason, any DMA allocation 
should fall back to default CMA memory. In the case of ENOMEM or other 
errors, then the later calls to allocate DMA may fail and we can deal 
with it then.


Thanks,

Eddie


>
> Cheers,
>
> Andrew
>
>>   
>>   	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>   	if (rc) {
>> -- 
>> 1.8.3.1
>>
>>

