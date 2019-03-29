From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 29 Mar 2019 13:47:04 -0700
Subject: [PATCH] media: platform: Fix a kernel warning on clk control
In-Reply-To: <db524edd-0c6c-2bb7-848d-2261286b4b21@linux.ibm.com>
References: <20190328212537.29511-1-jae.hyun.yoo@linux.intel.com>
 <db524edd-0c6c-2bb7-848d-2261286b4b21@linux.ibm.com>
Message-ID: <d91b27ce-ad96-7260-df6d-37a2fe3e89ab@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

On 3/29/2019 1:08 PM, Eddie James wrote:
> On 3/28/19 4:25 PM, Jae Hyun Yoo wrote:
>> To prevent this issue, this commit adds spinlock protection and clock
>> status checking logic into the Aspeed video engine driver.
> 
> Thanks Jae. Do you have a reliable way to reproduce this? Haven't seen 
> it myself.

It could be observed when user space releases a video engine dev entry
handle while video mode is changing. You could reproduce it by repeating
reload of KVM web page just after trigger a host reset. It rarely
happens.

>> +??? bool is_video_on;
> 
> This can probably be a flag, like VIDEO_CLOCKS_ON, not a new boolean.

Okay, I'll add the bit field into video->flags.

>> +??????? aspeed_video_reset(video);
> I'm working on a patch to remove the use of the reset line too.

Right, since clk-aspeed module can trigger a reset while enabling the
vclk or eclk, it could be removed later, but this patch is not for that.
>> +??? spin_lock(&video->lock);
> 
> Is there a reason you're locking extra code? Why not put the lock in the 
> aspeed_video_on/off functions?

aspeed_video_on() and aspeed_video_off() can be called from driver
context and from interrupt context so some video enable/disable
relating code also need to be serialized.

Will submit v2 soon after replacing the boolean variable with 
VIDEO_CLOCKS_ON flag.

Thanks,
Jae
