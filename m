From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 9 Nov 2021 09:05:59 +0800
Subject: [PATCH] media: aspeed: use reset to replace clk off/on
In-Reply-To: <398d37a5-509f-b78b-360b-990d256bde63@xs4all.nl>
References: <20211103054316.25272-1-jammy_huang@aspeedtech.com>
 <883dd517-7996-8c44-8cea-1c8838b367b6@linux.intel.com>
 <HK0PR06MB272258A4BA760E70CF609888F18E9@HK0PR06MB2722.apcprd06.prod.outlook.com>
 <398d37a5-509f-b78b-360b-990d256bde63@xs4all.nl>
Message-ID: <acff05a4-38a5-4765-c6ff-011a58caf260@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Hans,

On 2021/11/8 ?? 04:53, Hans Verkuil wrote:
> Hi Jammy,
>
> On 05/11/2021 02:27, Jammy Huang wrote:
>> Hi Jae,
>>
>> OK, I found it.
>> Thanks for your help.
> So just so I understand this correctly: this patch can be dropped, right?
>
> Regards,
>
> 	Hans

Yes, aspeed clk driver will reset the related engine at clk-enabled.

Thus, this modification isn't necessary.

>> Regards,
>> Jammy Huang
>>
>> Tel: 886-3-575-1185? ext.8630
>>
>> ************* Email Confidentiality Notice ********************
>> DISCLAIMER:
>> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
>>
>> -----Original Message-----
>> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Sent: Thursday, November 4, 2021 11:54 PM
>> To: Jammy Huang <jammy_huang@aspeedtech.com>; eajames at linux.ibm.com; mchehab at kernel.org; joel at jms.id.au; andrew at aj.id.au; linux-media at vger.kernel.org; openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
>> Subject: Re: [PATCH] media: aspeed: use reset to replace clk off/on
>>
>> Hi Jammy,
>>
>> On 11/2/2021 10:43 PM, Jammy Huang wrote:
>>> reset should be more proper than clk off/on to bring HW back to good
>>> state.
>>>
>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>> ---
>>>    drivers/media/platform/aspeed-video.c | 22 +++++++++++++++++++---
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/aspeed-video.c
>>> b/drivers/media/platform/aspeed-video.c
>>> index fea5e4d0927e..10d182139809 100644
>>> --- a/drivers/media/platform/aspeed-video.c
>>> +++ b/drivers/media/platform/aspeed-video.c
>>> @@ -23,6 +23,7 @@
>>>    #include <linux/workqueue.h>
>>>    #include <linux/debugfs.h>
>>>    #include <linux/ktime.h>
>>> +#include <linux/reset.h>
>>>    #include <media/v4l2-ctrls.h>
>>>    #include <media/v4l2-dev.h>
>>>    #include <media/v4l2-device.h>
>>> @@ -220,6 +221,7 @@ struct aspeed_video {
>>>    	void __iomem *base;
>>>    	struct clk *eclk;
>>>    	struct clk *vclk;
>>> +	struct reset_control *reset;
>>>    
>>>    	struct device *dev;
>>>    	struct v4l2_ctrl_handler ctrl_handler; @@ -554,6 +556,13 @@ static
>>> void aspeed_video_on(struct aspeed_video *video)
>>>    	set_bit(VIDEO_CLOCKS_ON, &video->flags);
>>>    }
>>>    
>>> +static void aspeed_video_reset(struct aspeed_video *v) {
>>> +	reset_control_assert(v->reset);
>>> +	udelay(100);
>>> +	reset_control_deassert(v->reset);
>>> +}
>>> +
>>>    static void aspeed_video_bufs_done(struct aspeed_video *video,
>>>    				   enum vb2_buffer_state state)
>>>    {
>>> @@ -574,7 +583,9 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
>>>    	set_bit(VIDEO_RES_CHANGE, &video->flags);
>>>    	clear_bit(VIDEO_FRAME_INPRG, &video->flags);
>>>    
>>> -	aspeed_video_off(video);
>>> +	aspeed_video_write(video, VE_INTERRUPT_CTRL, 0);
>>> +	aspeed_video_write(video, VE_INTERRUPT_STATUS, 0xffffffff);
>>> +	aspeed_video_reset(video);
>>>    	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
>>>    
>>>    	schedule_delayed_work(&video->res_work, delay); @@ -1507,8 +1518,7
>>> @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
>>>    		 * Need to force stop any DMA and try and get HW into a good
>>>    		 * state for future calls to start streaming again.
>>>    		 */
>>> -		aspeed_video_off(video);
>>> -		aspeed_video_on(video);
>>> +		aspeed_video_reset(video);
>> You can find the ECLK configuration in 'clk-aspeed.c' or in 'clk-ast2600.c' that it's coupled with the video engine reset (SCU04[6] for AST2500 / SCU040[6] for AST2600). It means that if we call
>> clk_disable() and clk_enable() through aspeed_video_off() and aspeed_video_on(), the video engine reset will be implicitly asserted and de-asserted by the clock driver so the reset mechanism is already in the existing code.
>>
>> Thanks,
>> Jae
>>
>>>    		aspeed_video_init_regs(video);
>>>    
>>> @@ -1715,6 +1725,12 @@ static int aspeed_video_init(struct aspeed_video *video)
>>>    		return rc;
>>>    	}
>>>    
>>> +	video->reset = devm_reset_control_get(dev, NULL);
>>> +	if (IS_ERR(video->reset)) {
>>> +		dev_err(dev, "Unable to get reset\n");
>>> +		return PTR_ERR(video->reset);
>>> +	}
>>> +
>>>    	video->eclk = devm_clk_get(dev, "eclk");
>>>    	if (IS_ERR(video->eclk)) {
>>>    		dev_err(dev, "Unable to get ECLK\n");
>>>
-- 
Best Regards
Jammy

