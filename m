From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Oct 2019 06:14:12 +0000
Subject: AST2600 i2c irq issue
Message-ID: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have been doing bringup of the ast2600. It contains i2c buses that
are register compatible with the ast2500, and I am running them
without buffer or DMA mode. This is with v5.3.6, with no patches other
than adding the compatible string:

--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -938,6 +938,10 @@ static const struct of_device_id
aspeed_i2c_bus_of_table[] = {
                .compatible = "aspeed,ast2500-i2c-bus",
                .data = aspeed_i2c_25xx_get_clk_reg_val,
        },
+       {
+               .compatible = "aspeed,ast2600-i2c-bus",
+               .data = aspeed_i2c_25xx_get_clk_reg_val,
+       },
        { },
 };


I see this behavior:

[   20.981417] aspeed-i2c-bus 1e78a280.i2c-bus: master failed to RX
[   20.988259] aspeed-i2c-bus 1e78a280.i2c-bus: irq handled != irq.
expected 0x00000014, but was 0x00000010
[   22.451265] aspeed-i2c-bus 1e78a200.i2c-bus: master failed to STOP.
irq_status:0x0
[   22.459909] aspeed-i2c-bus 1e78a200.i2c-bus: irq handled != irq.
expected 0x00000010, but was 0x00000000
[   22.470604] aspeed-i2c-bus 1e78a200.i2c-bus: irq handled != irq.
expected 0x00000011, but was 0x00000000
[   29.156951] aspeed-i2c-bus 1e78a280.i2c-bus: master failed to STOP.
irq_status:0x0
[   29.165601] aspeed-i2c-bus 1e78a280.i2c-bus: irq handled != irq.
expected 0x00000010, but was 0x00000000

It happens on boot, and can also be triggered by placing load on the
system. In particular, if I copy a large amount of data to the flash.

The IRQs are being served on one of the CPUs:

 29:          0          0     GIC-0 142 Level     1e78a080.i2c-bus
 30:          0          0     GIC-0 143 Level     1e78a100.i2c-bus
 31:          0          0     GIC-0 144 Level     1e78a180.i2c-bus
 32:     302596          0     GIC-0 145 Level     1e78a200.i2c-bus
 33:     197340          0     GIC-0 146 Level     1e78a280.i2c-bus
 34:     196900          0     GIC-0 147 Level     1e78a300.i2c-bus
 35:          0          0     GIC-0 149 Level     1e78a400.i2c-bus
 36:       2199          0     GIC-0 151 Level     1e78a500.i2c-bus
 37:          0          0     GIC-0 152 Level     1e78a580.i2c-bus
 38:       3407          0     GIC-0 153 Level     1e78a600.i2c-bus
 39:          0          0     GIC-0 154 Level     1e78a680.i2c-bus
 40:          0          0     GIC-0 155 Level     1e78a700.i2c-bus

Following a hunch, I booted the system with SMP disabled (it's a dual
core part). The issue did not reproduce.

This suggests the driver is lacking locking. I am yet to do any
detailed debugging.

Have you seen any behavior like this?
