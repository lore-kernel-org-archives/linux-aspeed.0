From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Sep 2021 07:36:34 +0000
Subject: [PATCH 1/2] soc: aspeed: Add LPC UART routing support
In-Reply-To: <20210901062216.32675-2-chiawei_wang@aspeedtech.com>
References: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
 <20210901062216.32675-2-chiawei_wang@aspeedtech.com>
Message-ID: <CACPK8XerokBaLMZ3J=9rcRLD5eFqmNOSsXYGgf_Ze01=X6NwPA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 1 Sept 2021 at 06:22, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Add driver support for the LPC UART routing control. Users can perform

As we discussed, remove the "LPC" part of the name.

> runtime configuration of the RX muxes among the UART controllers and the
> UART TXD/RXD IO pins. This is achieved through the exported sysfs interface.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>

It would be good to have some example of how to use it, and the output
from sysfs.

You should also add a patch to document the sysfs files in Documentation/ABI.

> +++ b/drivers/soc/aspeed/aspeed-lpc-uart-routing.c
> @@ -0,0 +1,621 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2018 Google LLC
> + * Copyright (c) 2021 Aspeed Technology Inc.
> + */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>

You can drop this one.

> +#include <linux/of_platform.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +
> +/* register offsets */
> +#define HICR9  0x98
> +#define HICRA  0x9c
> +
> +/* attributes options */
> +#define UART_ROUTING_IO1       "io1"
> +#define UART_ROUTING_IO2       "io2"
> +#define UART_ROUTING_IO3       "io3"
> +#define UART_ROUTING_IO4       "io4"
> +#define UART_ROUTING_IO5       "io5"
> +#define UART_ROUTING_IO6       "io6"
> +#define UART_ROUTING_IO10      "io10"
> +#define UART_ROUTING_UART1     "uart1"
> +#define UART_ROUTING_UART2     "uart2"
> +#define UART_ROUTING_UART3     "uart3"
> +#define UART_ROUTING_UART4     "uart4"
> +#define UART_ROUTING_UART5     "uart5"
> +#define UART_ROUTING_UART6     "uart6"
> +#define UART_ROUTING_UART10    "uart10"
> +#define UART_ROUTING_RES       "reserved"
> +
> +struct aspeed_uart_routing {
> +       struct regmap *map;
> +       spinlock_t lock;
> +       struct attribute_group const *attr_grp;
> +};
> +
> +struct aspeed_uart_routing_selector {
> +       struct device_attribute dev_attr;
> +       uint32_t reg;
> +       uint32_t mask;
> +       uint32_t shift;

These can be u8.

> +static ssize_t aspeed_uart_routing_show(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
> +       struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
> +       int val, pos, len;
> +
> +       regmap_read(uart_routing->map, sel->reg, &val);
> +       val = (val >> sel->shift) & sel->mask;
> +
> +       len = 0;
> +       for (pos = 0; sel->options[pos] != NULL; ++pos) {
> +               if (pos == val) {
> +                       len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> +                                       "[%s] ", sel->options[pos]);
> +               } else {
> +                       len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> +                                       "%s ", sel->options[pos]);

The kernel prefers sysfs_emit and sysfs_emit_at insteading of using
snprintf directly.

> +               }
> +       }
> +
> +       if (val >= pos) {
> +               len += snprintf(buf + len, PAGE_SIZE - 1 - len,
> +                               "[unknown(%d)]", val);
> +       }
> +
> +       len += snprintf(buf + len, PAGE_SIZE - 1 - len, "\n");
> +
> +       return len;
> +}
> +
> +static ssize_t aspeed_uart_routing_store(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        const char *buf, size_t count)
> +{
> +       unsigned long flags;
> +       struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
> +       struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
> +       int val;
> +
> +       val = match_string(sel->options, -1, buf);
> +       if (val < 0) {
> +               dev_err(dev, "invalid value \"%s\"\n", buf);
> +               return -EINVAL;
> +       }
> +
> +       spin_lock_irqsave(&uart_routing->lock, flags);

I can't see why you would need a spinlock here. The regmap has it's
own locking so it will protect against concurrent updates to the
registers.

> +
> +       regmap_update_bits(uart_routing->map, sel->reg,
> +                       (sel->mask << sel->shift),
> +                       (val & sel->mask) << sel->shift);
> +
> +       spin_unlock_irqrestore(&uart_routing->lock, flags);
> +
> +       return count;
> +}
> +
> +static int aspeed_uart_routing_probe(struct platform_device *pdev)
> +{
> +       int rc;
> +       struct device *dev = &pdev->dev;
> +       struct aspeed_uart_routing *uart_routing;
> +
> +       uart_routing = devm_kzalloc(&pdev->dev,
> +                                   sizeof(*uart_routing),
> +                                   GFP_KERNEL);

You can reformat this file to have longer lines; the kernel is ok with
up to 100 columsn these days.

> +       if (!uart_routing) {
> +               dev_err(dev, "cannot allocate memory\n");

I'd drop this error message.

> +               return -ENOMEM;
> +       }
> +
> +       uart_routing->map = syscon_node_to_regmap(dev->parent->of_node);
> +       if (IS_ERR(uart_routing->map)) {
> +               dev_err(dev, "cannot get regmap\n");
> +               return PTR_ERR(uart_routing->map);
> +       }
> +
> +       uart_routing->attr_grp = of_device_get_match_data(dev);
> +
> +       spin_lock_init(&uart_routing->lock);

I don't think you need the lock at all.

Cheers,

Joel
