From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 11 Feb 2019 10:09:53 -0800
Subject: [PATCH] i2c: aspeed: Add multi-master use case support
In-Reply-To: <20190208214849.GH12451@kunai>
References: <20190116193958.6049-1-jae.hyun.yoo@linux.intel.com>
 <20190208214849.GH12451@kunai>
Message-ID: <d26a95ac-41ab-91eb-bbae-e4143235e531@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Hmmm, the #ifdeffery quite increases with this patch. Maybe it is easier
> to select I2C_SLAVE in Kconfig? I'll let you decide.
> 
> My code checkers found this:
> 
>      CPPCHECK
> drivers/i2c/busses/i2c-aspeed.c:694:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
> 

Hi Wolfram,

Yes, cppcheck pointed it out correctly. The assignment on the variable
'ret' is not needed at there. Actually, the code should not be wrapped
using I2C_SLAVE because a bus can also be in multi-master environment
even when slave is not enabled. So the warning can be removed by below
fix.

---
diff --git a/drivers/i2c/busses/i2c-aspeed.c 
b/drivers/i2c/busses/i2c-aspeed.c
index 9253ebccb008..882c4ab1d18a 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -655,7 +655,6 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter 
*adap,
  {
         struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
         unsigned long time_left, flags;
-       int ret;

         spin_lock_irqsave(&bus->lock, flags);
         bus->cmd_err = 0;
@@ -664,6 +663,8 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter 
*adap,
         if (!bus->multi_master &&
             (readl(bus->base + ASPEED_I2C_CMD_REG) &
              ASPEED_I2CD_BUS_BUSY_STS)) {
+               int ret;
+
                 spin_unlock_irqrestore(&bus->lock, flags);
                 ret = aspeed_i2c_recover_bus(bus);
                 if (ret)
@@ -691,7 +692,7 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter 
*adap,
                 if (bus->multi_master &&
                     (readl(bus->base + ASPEED_I2C_CMD_REG) &
                      ASPEED_I2CD_BUS_BUSY_STS))
-                       ret = aspeed_i2c_recover_bus(bus);
+                       aspeed_i2c_recover_bus(bus);

                 return -ETIMEDOUT;
---

The reason of adding changes at line 658 and 667 is to remove below
cppcheck warning when the change at 694 is applied.

[drivers/i2c/busses/i2c-aspeed.c:670]: (style) The scope of the variable 
'ret' can be reduced.

Can you please apply above changes on top of this patch? Or I can submit
v2 with it.

Thanks,
Jae
