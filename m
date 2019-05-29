From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 29 May 2019 11:55:13 +0200
Subject: [PATCH v2 00/11] Improve stability and add bug fixes of Aspeed
 video engine driver
In-Reply-To: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <c841359a-96fe-eb74-e14c-29e304c6ba16@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Eddie,

Can you review the last 4 new patches? If all is OK, then I can make a pull
request for this series.

Regards,

	Hans

On 5/25/19 1:17 AM, Jae Hyun Yoo wrote:
> This patch series improves stability of Aspeed video engine driver by fixing
> clock control and irq handling logic in the driver. Also, it adds a couple of
> bug fixes and a workaroud for a silicon bug.
> 
> Changes since v1:
> - Removed spinlock handling code from 0001 patch.
> - Added 4 more patches.
> 
> Jae Hyun Yoo (11):
>   media: aspeed: fix a kernel warning on clk control
>   media: aspeed: refine clock control logic
>   media: aspeed: change irq to threaded irq
>   media: aspeed: remove IRQF_SHARED flag
>   media: aspeed: reduce noisy log printing outs
>   media: aspeed: remove checking of VE_INTERRUPT_CAPTURE_COMPLETE
>   media: aspeed: refine interrupt handling logic
>   media: aspeed: remove source buffer allocation before mode detection
>   media: aspeed: use different delays for triggering VE H/W reset
>   media: aspeed: fix an incorrect timeout checking in mode detection
>   media: aspeed: add a workaround to fix a silicon bug
> 
>  drivers/media/platform/aspeed-video.c | 140 +++++++++++++++-----------
>  1 file changed, 80 insertions(+), 60 deletions(-)
> 

