From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Thu, 30 May 2024 08:01:31 +0000
Subject: [PATCH] i2c: aspeed: Update the stop sw state when the bus
 recovry occurs
In-Reply-To: <2774cb4c-4eea-4bf5-8b2b-438adf18448d@molgen.mpg.de>
References: <20240530070656.3841066-1-tommy_huang@aspeedtech.com>
 <2774cb4c-4eea-4bf5-8b2b-438adf18448d@molgen.mpg.de>
Message-ID: <TYZPR06MB6191FAF87E840853959AB98CE1F32@TYZPR06MB6191.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Paul,

	Thanks for your comments.

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Thursday, May 30, 2024 3:48 PM
> To: Tommy Huang <tommy_huang@aspeedtech.com>
> Cc: brendan.higgins at linux.dev; benh at kernel.crashing.org; joel at jms.id.au;
> andi.shyti at kernel.org; andrew at codeconstruct.com.au; wsa at kernel.org;
> BMC-SW <BMC-SW@aspeedtech.com>; linux-aspeed at lists.ozlabs.org;
> openbmc at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-i2c at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] i2c: aspeed: Update the stop sw state when the bus
> recovry occurs
> 
> Dear Tommy,
> 
> 
> Thank you for your patch.
> 
> Am 30.05.24 um 09:06 schrieb Tommy Huang:
> > When the i2c bus recovey occurs, driver will send i2c stop command
> 
> recove*r*y

I will fix this spelling typo on next patch. Thanks.

> 
> > in the scl low condition. In this case the sw state will still keep
> > original situation. Under multi-master usage, i2c bus recovery will
> 
> What is the user visible problem?
> 

In the multi-master case, the i2c transfer timeout will execute the aspeed_i2c_recover_bus.
What we noticed when timeout appears, and kernel panic is observed:
-	xfer goes through aspeed_i2c_recovery_bus 
-	inside recovery we can see ?SCL hung (state ec0b0000), attempting recovery?. 
-	STOP_CMD is performed but time_left = 0 what causes that aspeed_i2c_reset is called (and returns 0)
-	Going out of timeout handling, release memory, irq handler is invoked and rise interrupt causing that released memory is used.

> > be called when i2c transfer timeout occurs. Update the stop command
> > calling with aspeed_i2c_do_stop function to update master_state.
> 
> How can this be tested?

It just updates master_state for usage safety. The original stop command still be triggered.
> 
> > Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")
> >
> 
> The blank line can be removed.
> 
> > Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> > ---
> >   drivers/i2c/busses/i2c-aspeed.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-aspeed.c
> > b/drivers/i2c/busses/i2c-aspeed.c index ce8c4846b7fa..32f8b0c1c174
> > 100644
> > --- a/drivers/i2c/busses/i2c-aspeed.c
> > +++ b/drivers/i2c/busses/i2c-aspeed.c
> > @@ -169,6 +169,7 @@ struct aspeed_i2c_bus {
> >   };
> >
> >   static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
> > +static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
> >
> >   static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
> >   {
> > @@ -187,7 +188,7 @@ static int aspeed_i2c_recover_bus(struct
> aspeed_i2c_bus *bus)
> >   			command);
> >
> >   		reinit_completion(&bus->cmd_complete);
> > -		writel(ASPEED_I2CD_M_STOP_CMD, bus->base +
> ASPEED_I2C_CMD_REG);
> > +		aspeed_i2c_do_stop(bus);
> >   		spin_unlock_irqrestore(&bus->lock, flags);
> >
> >   		time_left = wait_for_completion_timeout(
> 
> 
> Kind regards,
> 
> Paul

BR,

Tommy
