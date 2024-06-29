From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Sat, 29 Jun 2024 02:01:33 +0000
Subject: [PATCH v2] i2c: aspeed: Update the stop sw state when the bus
 recovery occurs
In-Reply-To: <pbsrfzbd237k5inof3wy6qabdmolmweozkn5kq7jlvstj2nkvo@nzp2sbrxpn44>
References: <20240608043653.4086647-1-tommy_huang@aspeedtech.com>
 <pbsrfzbd237k5inof3wy6qabdmolmweozkn5kq7jlvstj2nkvo@nzp2sbrxpn44>
Message-ID: <TYZPR06MB619173FE3D74760214A03636E1D12@TYZPR06MB6191.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andi,

	I have sent back the mail on 6/11.
	But I don't receive your feedback, I post it again in this mail.

"	There is a problem to move aspeed_i2c_do_stop() on top.
	This function is like with aspeed_i2c_reset function needs the aspeed_i2c_bus structure definition."

	BR,

	By Tommy

> -----Original Message-----
> From: Andi Shyti <andi.shyti@kernel.org>
> Sent: Thursday, June 27, 2024 11:26 PM
> To: Tommy Huang <tommy_huang@aspeedtech.com>
> Cc: brendan.higgins at linux.dev; benh at kernel.crashing.org; joel at jms.id.au;
> andrew at codeconstruct.com.au; wsa at kernel.org; linux-i2c at vger.kernel.org;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> stable at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2] i2c: aspeed: Update the stop sw state when the bus
> recovery occurs
> 
> Hi Tommy,
> 
> any update on this patch?
> 
> Andi
> 
> On Sat, Jun 08, 2024 at 12:36:53PM GMT, Tommy Huang wrote:
> > When the i2c bus recovery occurs, driver will send i2c stop command in
> > the scl low condition. In this case the sw state will still keep
> > original situation. Under multi-master usage, i2c bus recovery will be
> > called when i2c transfer timeout occurs. Update the stop command
> > calling with aspeed_i2c_do_stop function to update master_state.
> >
> > Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")
> >
> > Cc: <stable@vger.kernel.org> # v4.13+
> > Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> > ---
> >  drivers/i2c/busses/i2c-aspeed.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-aspeed.c
> > b/drivers/i2c/busses/i2c-aspeed.c index ce8c4846b7fa..be64e419adf0
> > 100644
> > --- a/drivers/i2c/busses/i2c-aspeed.c
> > +++ b/drivers/i2c/busses/i2c-aspeed.c
> > @@ -25,6 +25,8 @@
> >  #include <linux/reset.h>
> >  #include <linux/slab.h>
> >
> > +static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
> > +
> >  /* I2C Register */
> >  #define ASPEED_I2C_FUN_CTRL_REG				0x00
> >  #define ASPEED_I2C_AC_TIMING_REG1			0x04
> > @@ -187,7 +189,7 @@ static int aspeed_i2c_recover_bus(struct
> aspeed_i2c_bus *bus)
> >  			command);
> >
> >  		reinit_completion(&bus->cmd_complete);
> > -		writel(ASPEED_I2CD_M_STOP_CMD, bus->base +
> ASPEED_I2C_CMD_REG);
> > +		aspeed_i2c_do_stop(bus);
> >  		spin_unlock_irqrestore(&bus->lock, flags);
> >
> >  		time_left = wait_for_completion_timeout(
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
