From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 6 Sep 2021 10:10:10 +0000
Subject: [PATCH v3] media: aspeed-video: ignore interrupts that aren't
 enabled
In-Reply-To: <46edf81d60a38747f7d2511f840253a1c6867652.camel@linux.ibm.com>
References: <20210617220229.7352-1-zev@bewilderbeest.net>
 <46edf81d60a38747f7d2511f840253a1c6867652.camel@linux.ibm.com>
Message-ID: <HK0PR06MB338081E134AA6F43ECBCBA4DF2D29@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Eddie James <eajames@linux.ibm.com>
> Sent: Wednesday, September 1, 2021 11:07 PM
> To: Zev Weiss <zev@bewilderbeest.net>
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>; Ryan Chen
> <ryan_chen@aspeedtech.com>; linux-aspeed at lists.ozlabs.org; Andrew Jeffery
> <andrew@aj.id.au>; openbmc at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> Mauro Carvalho Chehab <mchehab@kernel.org>;
> linux-arm-kernel at lists.infradead.org; linux-media at vger.kernel.org
> Subject: Re: [PATCH v3] media: aspeed-video: ignore interrupts that aren't
> enabled
> 
> On Thu, 2021-06-17 at 17:02 -0500, Zev Weiss wrote:
> > As partially addressed in commit 65d270acb2d6 ("media: aspeed: clear
> > garbage interrupts"), the ASpeed video engine sometimes asserts
> > interrupts that the driver hasn't enabled.  In addition to the
> > CAPTURE_COMPLETE and FRAME_COMPLETE interrupts dealt with in that
> > patch, COMP_READY has also been observed.  Instead of playing
> > whack-a-mole with each one individually, we can instead just blanket
> > ignore everything we haven't explicitly enabled.
> 
> Suspect this will fix an intermittent problem on AST2500 with screensaver.
> Change looks good, thanks!
> 
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
> 
Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > ---
> >
> > Changes since v2 [1]:
> >  - minor commit message improvements
> >
> > Changes since v1 [0]:
> >  - dropped error message
> >  - switched to a blanket-ignore approach as suggested by Ryan
> >
> > [0]
> > https://lore.kernel.org/linux-arm-kernel/20201215024542.18888-1-zev at be
> > wilderbeest.net/
> > [1]
> >
> https://lore.kernel.org/openbmc/20210506234048.3214-1-zev at bewilderbees
> > t.net/
> >
> >  drivers/media/platform/aspeed-video.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/media/platform/aspeed-video.c
> > b/drivers/media/platform/aspeed-video.c
> > index 7bb6babdcade..77611c296a25 100644
> > --- a/drivers/media/platform/aspeed-video.c
> > +++ b/drivers/media/platform/aspeed-video.c
> > @@ -563,6 +563,12 @@ static irqreturn_t aspeed_video_irq(int irq, void
> > *arg)
> >  	struct aspeed_video *video = arg;
> >  	u32 sts = aspeed_video_read(video, VE_INTERRUPT_STATUS);
> >
> > +	/*
> > +	 * Hardware sometimes asserts interrupts that we haven't
> > actually
> > +	 * enabled; ignore them if so.
> > +	 */
> > +	sts &= aspeed_video_read(video, VE_INTERRUPT_CTRL);
> > +
> >  	/*
> >  	 * Resolution changed or signal was lost; reset the engine and
> >  	 * re-initialize
> > @@ -629,16 +635,6 @@ static irqreturn_t aspeed_video_irq(int irq, void
> > *arg)
> >  			aspeed_video_start_frame(video);
> >  	}
> >
> > -	/*
> > -	 * CAPTURE_COMPLETE and FRAME_COMPLETE interrupts come even
> > when these
> > -	 * are disabled in the VE_INTERRUPT_CTRL register so clear them
> > to
> > -	 * prevent unnecessary interrupt calls.
> > -	 */
> > -	if (sts & VE_INTERRUPT_CAPTURE_COMPLETE)
> > -		sts &= ~VE_INTERRUPT_CAPTURE_COMPLETE;
> > -	if (sts & VE_INTERRUPT_FRAME_COMPLETE)
> > -		sts &= ~VE_INTERRUPT_FRAME_COMPLETE;
> > -
> >  	return sts ? IRQ_NONE : IRQ_HANDLED;  }
> >

