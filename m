From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 04 Oct 2023 16:38:38 +1030
Subject: [PATCH v2] i2c: aspeed: Fix i2c bus hang in slave read
In-Reply-To: <ZRZ/ObZmntMLw2r+@ninjato>
References: <20230927154244.3774670-1-zhangjian.3032@bytedance.com>
	 <ZRZ/ObZmntMLw2r+@ninjato>
Message-ID: <975c69de32eefb124fe668e921e8dbda86962deb.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2023-09-29 at 09:39 +0200, Wolfram Sang wrote:
> On Wed, Sep 27, 2023 at 11:42:43PM +0800, Jian Zhang wrote:
> > When the `CONFIG_I2C_SLAVE` option is enabled and the device operates
> > as a slave, a situation arises where the master sends a START signal
> > without the accompanying STOP signal. This action results in a
> > persistent I2C bus timeout. The core issue stems from the fact that
> > the i2c controller remains in a slave read state without a timeout
> > mechanism. As a consequence, the bus perpetually experiences timeouts.
> > 
> > In this case, the i2c bus will be reset, but the slave_state reset is
> > missing.
> > 
> > Fixes: fee465150b45 ("i2c: aspeed: Reset the i2c controller when timeout occurs")
> > Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
> 
> Somebody wants to add tags here? I think it should go to my pull request
> this week.
> 

I've tested this patch applied on top of fee465150b45 on an AST2600 and
the the system behaviour doesn't seem worse. However, I can still lock 
the bus up and trigger a hung task panic by surprise-unplugging things.
I'll poke around to see if I can get to the bottom of that.

Resetting the slave state makes sense, so with the above observation 
aside:

Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

That said I do wonder whether we should update the slave state in the 
same place we're updating the hardware state. It would cover off the 
gap identified by Jian if it were to ever occur anywhere else.
Something like:

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-
aspeed.c
index 5a416b39b818..28e2a5fc4528 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -749,6 +749,8 @@ static void __aspeed_i2c_reg_slave(struct
aspeed_i2c_bus *bus, u16 slave_addr)
        func_ctrl_reg_val = readl(bus->base + ASPEED_I2C_FUN_CTRL_REG);
        func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
        writel(func_ctrl_reg_val, bus->base + ASPEED_I2C_FUN_CTRL_REG);
+
+       bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
 static int aspeed_i2c_reg_slave(struct i2c_client *client)
@@ -765,7 +767,6 @@ static int aspeed_i2c_reg_slave(struct i2c_client
*client)
        __aspeed_i2c_reg_slave(bus, client->addr);
 
        bus->slave = client;
-       bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
        spin_unlock_irqrestore(&bus->lock, flags);
 
        return 0;


