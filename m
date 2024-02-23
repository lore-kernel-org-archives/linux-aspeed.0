From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Fri, 23 Feb 2024 03:49:17 +0000
Subject: [PATCH] i2c: aspeed: Fix the dummy irq expected print
In-Reply-To: <v4nawwb4rwjiy2g7xv2sfyhc545mhk4izb3g22f7jupcevjuzb@nxmqgf2zjyqs>
References: <20240216120455.4138642-1-tommy_huang@aspeedtech.com>
 <nbkkaktcozbhly44hii3zwie7ivsra3qxzdibyzhyhooxrudvb@zik6skmkki2c>
 <TYZPR06MB61911F076C8719C6A7D57B97E1562@TYZPR06MB6191.apcprd06.prod.outlook.com>
 <v4nawwb4rwjiy2g7xv2sfyhc545mhk4izb3g22f7jupcevjuzb@nxmqgf2zjyqs>
Message-ID: <TYZPR06MB61912715EE2869DDB7C3763DE1552@TYZPR06MB6191.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andi,

	Sure~
	Below is my re-word commit and fixes tag.

	When the i2c error condition occurred and master state was not
	idle, the master irq function will goto complete state without any
    other interrupt handling. It would cause dummy irq expected print.
    Under this condition, assign the irq_status into irq_handle.

	For example, when the abnormal start / stop occurred (bit 5) with normal stop
	status (bit 4) at same time. Then the normal stop status would not be handled 
	and it would cause irq expected print in the aspeed_i2c_bus_irq.

	...
	aspeed-i2c-bus xxxxxxxx. i2c-bus: irq handled != irq. Expected 0x00000030, but was 0x00000020
	...
 
	Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
	Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

	Tommy

> -----Original Message-----
> From: Andi Shyti <andi.shyti@kernel.org>
> Sent: Thursday, February 22, 2024 4:58 PM
> To: Tommy Huang <tommy_huang@aspeedtech.com>
> Cc: brendan.higgins at linux.dev; p.zabel at pengutronix.de;
> linux-i2c at vger.kernel.org; openbmc at lists.ozlabs.org;
> benh at kernel.crashing.org; joel at jms.id.au; andrew at aj.id.au;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] i2c: aspeed: Fix the dummy irq expected print
> 
> Hi Tommy,
> 
> On Thu, Feb 22, 2024 at 01:10:39AM +0000, Tommy Huang wrote:
> > > On Fri, Feb 16, 2024 at 08:04:55PM +0800, Tommy Huang wrote:
> > > > When the i2c error condition occurred and master state was not
> > > > idle, the master irq function will goto complete state without any
> > > > other interrupt handling. It would cause dummy irq expected print.
> > > > Under this condition, assign the irq_status into irq_handle.
> > >
> > > I'm sorry, but I don't understand much from your log here.
> > >
> > > Do you mean that irq_handled in aspeed_i2c_master_irq() is left with
> > > some states that is not supposed to have and then you end up printing
> here:
> > >
> > > 	dev_err(bus->dev,
> > > 		"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> > > 		irq_received, irq_handled);
> > >
> > > Can you please explain better?
> > >
> >
> > Yes. If the platform met any irq error condition and the i2c wasn't stated
> under ASPEED_I2C_MASTER_INACTIVE.
> > Then the code flow would goto the end of aspeed_i2c_master_irq.
> >
> > 	ret = aspeed_i2c_is_irq_error(irq_status);
> > 	if (ret) {
> > 		...
> > 		irq_handled |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
> > 		if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> > 			bus->cmd_err = ret;
> > 			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> > 			goto out_complete;
> > 		}
> > 	}
> >
> > Some master interrupt states were not handled under this situation.
> > The fake irq not equaled message would be filled into whole of demsg.
> > It's most like below example.
> >
> > ...
> > aspeed-i2c-bus 1e78a780. i2c-bus: irq handled != irq. expected
> > 0x00000030, but was 0x00000020 aspeed-i2c-bus 1e78a780. i2c-bus: irq
> > handled != irq. expected 0x00000030, but was 0x00000020 aspeed-i2c-bus
> > 1e78a780. i2c-bus: irq handled != irq. expected 0x00000030, but was
> 0x00000020 ...
> >
> > I thought the bus->cmd_err has been filled error reason and it would be
> returned to upper layer.
> > So, I didn't think the print should be existed.
> 
> thanks! Can you please write a commit that explains better the fix you are
> doing?
> 
> > > If that's the case, wouldn't it make more sense to check for
> > > bus->master_state != ASPEED_I2C_MASTER_INACTIVE) earlier?
> >
> > Did you suggest to add "bus->master_state !=
> ASPEED_I2C_MASTER_INACTIVE" judgement before print the irq not equal
> print?
> 
> no, not really, but nevermind, on a second look, what I'm suggesting doesn't
> make much sense.
> 
> If you want, please reword the commit message as reply to this e-mail and I
> will take care of it.
> 
> > > And, still, If that's the case, I believe you might need the Fixes
> > > tag. It's true that you are not really failing, but you are not reporting a
> failure by mistake.
> 
> Please, also consider adding the Fixes tag if you see it necessary; I think you
> should, but it's borderline.
> 
> Andi
