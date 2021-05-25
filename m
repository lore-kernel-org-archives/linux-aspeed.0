From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Tue, 25 May 2021 10:08:18 +0800
Subject: [PATCH 1/3] i2c: aspeed: avoid new registers definition of AST2600
In-Reply-To: <YKwXnPH0XyYLRtfa@packtop>
References: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
 <20210519080436.18975-2-jamin_lin@aspeedtech.com>
 <YKVg2Kfbex3DYbNI@packtop> <20210524020846.GB2591@aspeedtech.com>
 <YKwXnPH0XyYLRtfa@packtop>
Message-ID: <20210525020817.GB2489@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/24/2021 21:16, Zev Weiss wrote:
> On Sun, May 23, 2021 at 09:08:47PM CDT, Jamin Lin wrote:
> >The 05/19/2021 19:02, Zev Weiss wrote:
> >> On Wed, May 19, 2021 at 03:04:27AM CDT, Jamin Lin wrote:
> >> >The register definition between AST2600 A2 and A3 is different.
> >> >This patch avoid new registers definition of AST2600 to use
> >> >this driver. We will submit the path for the new registers
> >> >definition of AST2600.
> >> >
> >> >Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> >> >---
> >> > drivers/i2c/busses/i2c-aspeed.c | 22 ++++++++++++++++++++++
> >> > 1 file changed, 22 insertions(+)
> >> >
> >> >diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> >> >index 724bf30600d6..007309077d9f 100644
> >> >--- a/drivers/i2c/busses/i2c-aspeed.c
> >> >+++ b/drivers/i2c/busses/i2c-aspeed.c
> >> >@@ -19,14 +19,20 @@
> >> > #include <linux/irqchip/chained_irq.h>
> >> > #include <linux/irqdomain.h>
> >> > #include <linux/kernel.h>
> >> >+#include <linux/mfd/syscon.h>
> >> > #include <linux/module.h>
> >> > #include <linux/of_address.h>
> >> > #include <linux/of_irq.h>
> >> > #include <linux/of_platform.h>
> >> > #include <linux/platform_device.h>
> >> >+#include <linux/regmap.h>
> >> > #include <linux/reset.h>
> >> > #include <linux/slab.h>
> >> >
> >> >+/* I2C Global Registers */
> >> >+/* 0x0c : I2CG Global Control Register (AST2500)  */
> >> >+#define ASPEED_I2CG_GLOBAL_CTRL_REG			0x0c
> >> >+
> >> > /* I2C Register */
> >> > #define ASPEED_I2C_FUN_CTRL_REG				0x00
> >> > #define ASPEED_I2C_AC_TIMING_REG1			0x04
> >> >@@ -973,6 +979,22 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
> >> > 	struct resource *res;
> >> > 	int irq, ret;
> >> >
> >> >+	if (of_device_is_compatible(pdev->dev.of_node,
> >> >+				    "aspeed,ast2600-i2c-bus")) {
> >> >+		u32 global_ctrl;
> >> >+		struct regmap *gr_regmap;
> >> >+
> >> >+		gr_regmap = syscon_regmap_lookup_by_compatible("aspeed,ast2600-i2c-global");
> >> >+
> >> >+		if (IS_ERR(gr_regmap)) {
> >> >+			ret = PTR_ERR(gr_regmap);
> >> >+		} else {
> >> >+			regmap_read(gr_regmap, ASPEED_I2CG_GLOBAL_CTRL_REG, &global_ctrl);
> >> >+			if (global_ctrl & BIT(2))
> >> >+				return -EIO;
> >>
> >> A macro definition might be a bit nicer than a raw BIT(2) here I'd
> >> think.
> >Will modify
> >>
> >> Also, it seems a bit unfortunate to just bail on the device entirely if
> >> we find this bit set (seems like a good way for a bootloader to
> >> inadvertently DoS the kernel), though I guess poking global syscon bits
> >> in the bus probe function might not be ideal.  Could/should we consider
> >> some module-level init code to ensure that bit is cleared?
> >>
> >>
> >We use syscon API to get the global register of i2c not the specific i2c
> >bus.
> >Can you describe it more detail?
> 
> Sure -- I just meant that if for whatever reason the kernel is booting
> on a system that's had that syscon bit set to enable the new register
> access mode (e.g. by a newer bootloader or something), it seems like
> we'd just give up entirely on enabling any i2c busses, when as far as I
> know there shouldn't be anything stopping us from resetting the bit back
> to be in the state this driver needs it to be in (old register mode) and
> then continuing along normally.
> 
> 
> Zev

Thanks for your suggestion. I will submit the new i2c driver for
AST2600.
Jamin
