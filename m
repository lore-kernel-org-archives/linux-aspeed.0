From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 7 Jan 2020 09:58:02 -0800
Subject: [PATCH 3/3] media: aspeed: add AST2600 support
In-Reply-To: <CACPK8XejA6emrboLzfwEpmn=dn1JcyHKJVud_cBXVNRiZixgTA@mail.gmail.com>
References: <20200107011503.17435-1-jae.hyun.yoo@linux.intel.com>
 <20200107011503.17435-4-jae.hyun.yoo@linux.intel.com>
 <CACPK8XejA6emrboLzfwEpmn=dn1JcyHKJVud_cBXVNRiZixgTA@mail.gmail.com>
Message-ID: <86f3dc92-07b0-c993-6c3e-39db6c58214e@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 1/6/2020 7:15 PM, Joel Stanley wrote:
> On Tue, 7 Jan 2020 at 01:14, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> Video engine in AST2600 has the exactly same register set with
>> AST2500 except VR084 register which provides more precise JPEG
>> size read back. This commit adds support for the difference and
>> adds 'aspeed,ast2600-video-engine' compatible OF string.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index d8593cb2ae84..0dbe72672338 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -72,10 +72,10 @@
>>   #define  VE_SEQ_CTRL_CAP_BUSY          BIT(16)
>>   #define  VE_SEQ_CTRL_COMP_BUSY         BIT(18)
>>
>> -#ifdef CONFIG_MACH_ASPEED_G5
>> -#define  VE_SEQ_CTRL_JPEG_MODE         BIT(13) /* AST2500 */
>> -#else
>> +#ifdef CONFIG_MACH_ASPEED_G4
>>   #define  VE_SEQ_CTRL_JPEG_MODE         BIT(8)  /* AST2400 */
>> +#else
>> +#define  VE_SEQ_CTRL_JPEG_MODE         BIT(13) /* AST2500/2600 */
>>   #endif /* CONFIG_MACH_ASPEED_G5 */
> 
> Yeah, nah. This should have never been done this way. I will send some
> patches to fix it up, and you can add ast2600 support on top of them,
> if that works for you.

Yeah, the runtime configuration in your patch set is right way for it.
I'll rebase this patch set on top of your patch.

Thanks,

Jae

> Cheers,
> 
> Joel
> 
>>
>>   #define VE_CTRL                                0x008
>> @@ -135,6 +135,12 @@
>>
>>   #define VE_OFFSET_COMP_STREAM          0x078
>>
>> +#ifdef CONFIG_MACH_ASPEED_G6
>> +#define VE_JPEG_COMP_SIZE_READ_BACK    0x084   /* AST2600 */
>> +#else
>> +#define VE_JPEG_COMP_SIZE_READ_BACK    VE_OFFSET_COMP_STREAM
>> +#endif
>> +
>>   #define VE_SRC_LR_EDGE_DET             0x090
>>   #define  VE_SRC_LR_EDGE_DET_LEFT       GENMASK(11, 0)
>>   #define  VE_SRC_LR_EDGE_DET_NO_V       BIT(12)
>> @@ -572,7 +578,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>>          if (sts & VE_INTERRUPT_COMP_COMPLETE) {
>>                  struct aspeed_video_buffer *buf;
>>                  u32 frame_size = aspeed_video_read(video,
>> -                                                  VE_OFFSET_COMP_STREAM);
>> +                                                  VE_JPEG_COMP_SIZE_READ_BACK);
>>
>>                  spin_lock(&video->lock);
>>                  clear_bit(VIDEO_FRAME_INPRG, &video->flags);
>> @@ -1719,6 +1725,7 @@ static int aspeed_video_remove(struct platform_device *pdev)
>>   static const struct of_device_id aspeed_video_of_match[] = {
>>          { .compatible = "aspeed,ast2400-video-engine" },
>>          { .compatible = "aspeed,ast2500-video-engine" },
>> +       { .compatible = "aspeed,ast2600-video-engine" },
>>          {}
>>   };
>>   MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
>> --
>> 2.17.1
>>
