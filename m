From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Dec 2020 04:08:12 +0000
Subject: [PATCH] i2c: aspeed: disable additional device addresses on
 ast2[56]xx
In-Reply-To: <20201218213952.refmqjlxdclsquzg@hatter.bewilderbeest.net>
References: <20200915184525.29665-1-zev@bewilderbeest.net>
 <20201218213952.refmqjlxdclsquzg@hatter.bewilderbeest.net>
Message-ID: <CACPK8Xe9uPMHHkNGmUL+xm4MKBvOzNd-3bCLGc7UuZW_QkhUog@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 18 Dec 2020 at 21:40, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Tue, Sep 15, 2020 at 01:45:25PM CDT, Zev Weiss wrote:
> >The ast25xx and ast26xx have, respectively, two and three configurable
> >slave device addresses to the ast24xx's one.  We only support using
> >one at a time, but the others may come up in an indeterminate state
> >depending on hardware/bootloader behavior, so we need to make sure we
> >disable them so as to avoid ending up with phantom devices on the bus.
> >
> >Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> >---
> > drivers/i2c/busses/i2c-aspeed.c | 50 +++++++++++++++++++++++++++------
> > 1 file changed, 41 insertions(+), 9 deletions(-)
> >
> > <snip>
>
> Ping...any thoughts on this patch?

Apologies for the delay, this one slipped through the cracks.

The rework is fine, and lends itself to supporting the other addresses
in the future. However, a simpler fix would be to construct reg 0x18
from zero, so only the functions that are supported are enabled.

static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
{
    u32 addr_reg_val, func_ctrl_reg_val;

    /* Set slave addr. */
    addr_reg_val = slave_addr & ASPEED_I2CD_DEV_ADDR_MASK;
    writel(addr_reg_val, bus->base + ASPEED_I2C_DEV_ADDR_REG);

    /* Turn on slave mode. */
    func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
    func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
    writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
}

You could go further and ensure slave mode is always disabled unless
requested by clearing 0x18 when 0x00 is cleared at aspeed_i2c_init.

Cheers,

Joel

>
>
> Thanks,
> Zev
>
