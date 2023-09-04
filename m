From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Mon, 4 Sep 2023 00:14:31 +0000
Subject: [PATCH] drivers:i2c:add controller reset when the timeout
 occurred
In-Reply-To: <20230903141519.ha6aakgkrq6ohy5s@zenone.zhora.eu>
References: <20230814111534.2771900-1-tommy_huang@aspeedtech.com>
 <20230903141519.ha6aakgkrq6ohy5s@zenone.zhora.eu>
Message-ID: <KL1PR0601MB5614646277B7E656535799B2E1E9A@KL1PR0601MB5614.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andi,

	Thanks for your review.
	I will fix the patch with your comment and resend it.

	BR,

	by Tommy

> -----Original Message-----
> From: Andi Shyti <andi.shyti@kernel.org>
> Sent: Sunday, September 3, 2023 10:15 PM
> To: Tommy Huang <tommy_huang@aspeedtech.com>
> Cc: brendan.higgins at linux.dev; p.zabel at pengutronix.de;
> linux-i2c at vger.kernel.org; openbmc at lists.ozlabs.org;
> benh at kernel.crashing.org; joel at jms.id.au; andrew at aj.id.au;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; Jae
> Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Subject: Re: [PATCH] drivers:i2c:add controller reset when the timeout
> occurred
> 
> Hi Tommy,
> 
> Please fix the title of the patch from:
> 
>    drivers:i2c:add controller reset when the timeout occurred
> 
> to something like:
> 
>    i2c: aspeed: Reset the controller when timeout occurs
> 
> Note:
> 
>  - leave a space after the ':'
>  - start with a capital letter after the last ':'
> 
> On Mon, Aug 14, 2023 at 07:15:34PM +0800, Tommy Huang wrote:
> > 1.Call i2c controller reset when the i2c transfer timeout occurred.
> > The rest of interrupts and device should be reset avoid unperdicted
> > controller behavior occurred.
> 
> Please remove the '1.' and please rewrite this sentence in order to be
> grammatically correct, something like:
> 
> "Call the i2c controller reset when an i2c transfer timeout occurs. The
> remaining interrupts and the device should be reset to avoid unpredictable
> controller behavior."
> 
> > Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> 
> Is this a fix? If so please add:
> 
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.1+
> 
> Jae Hyun is the author of the line you are changing therefore he needs to be
> Cc'ed
> 
> [...]
> 
> >  		/*
> >  		 * If timed out and bus is still busy in a multi master
> > -		 * environment, attempt recovery at here.
> > +		 * environment, attempt recovery at here. Even the bus is
> > +		 * idle, we still need reset i2c controller avoid rest of
> > +		 * interrupts.
> 
> Please fix the grammar here, as well
> 
>    In a multi-master setup, if a timeout occurs, attempt
>    recovery.  But if the bus is idle, we still need to reset the
>    i2c controller to clear the remaining interrupts.
> 
> We take this chance to improve the previous comment, as well.
> 
> >  		 */
> >  		if (bus->multi_master &&
> >  		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
> >  		     ASPEED_I2CD_BUS_BUSY_STS))
> >  			aspeed_i2c_recover_bus(bus);
> > +		else
> > +			aspeed_i2c_reset(bus);
> 
> I'd like also someone from Jae Hyun, Brendan, Benjamin or Joel to take a look
> here, as well. Thanks!
> 
> Andi
