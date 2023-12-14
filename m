From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 15 Dec 2023 08:51:03 +1030
Subject: [PATCH v4 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
In-Reply-To: <2eab42cde34723a195e7a0287db08b25f8388a3b.camel@codeconstruct.com.au>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
	 <20231211102217.2436294-3-quan@os.amperecomputing.com>
	 <2eab42cde34723a195e7a0287db08b25f8388a3b.camel@codeconstruct.com.au>
Message-ID: <54cba87a0df233b8762e43b742afe8e44a77a60c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Mon, 2023-12-11 at 17:22 +0700, Quan Nguyen wrote:
> > Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
> > interrupt handler") acknowledges most interrupts early before the slave
> > irq handler is executed, except for the "Receive Done Interrupt status"
> > which is acknowledged late in the interrupt.
> > However, it has been observed that the early acknowledgment of "Transmit
> > Done Interrupt Status" (with ACK or NACK) often causes the interrupt to
> > be raised in READ REQUEST state, that shows the
> > "Unexpected ACK on read request." complaint messages.
> > 
> > Assuming that the "Transmit Done" interrupt should only be acknowledged
> > once it is truly processed, this commit fixes that issue by acknowledging
> > interrupts for both ACK and NACK cases late in the interrupt handler.
> > 
> > Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
> > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

So I just booted this series on v6.7-rc5 under qemu v8.2.0-rc4 and
found this:

```
$ qemu-system-arm \
	-M ast2600-evb \
	-kernel build.aspeed_g5/arch/arm/boot/zImage \
	-dtb build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb \
	-initrd ~/src/buildroot.org/buildroot/output/images/rootfs.cpio.xz \
	-nographic 2>&1 \
	| ts -s
...
00:00:03 [    1.089187] Freeing initrd memory: 3308K
00:00:05 smbus: error: Unexpected send start condition in state 1
00:00:05 smbus: error: Unexpected write in state -1
00:00:06 [    3.685731] aspeed-i2c-bus 1e78a400.i2c-bus: i2c bus 7 registered, irq 48
00:00:06 [    3.688918] aspeed-i2c-bus 1e78a480.i2c-bus: i2c bus 8 registered, irq 49
00:00:06 [    3.692326] aspeed-i2c-bus 1e78a500.i2c-bus: i2c bus 9 registered, irq 50
00:00:06 [    3.693757] aspeed-i2c-bus 1e78a680.i2c-bus: i2c bus 12 registered, irq 51
00:00:06 [    3.695070] aspeed-i2c-bus 1e78a700.i2c-bus: i2c bus 13 registered, irq 52
00:00:06 [    3.696184] aspeed-i2c-bus 1e78a780.i2c-bus: i2c bus 14 registered, irq 53
00:00:06 [    3.697144] aspeed-i2c-bus 1e78a800.i2c-bus: i2c bus 15 registered, irq 54
00:00:06 [    3.699061] aspeed-video 1e700000.video: irq 55
00:00:06 [    3.699254] aspeed-video 1e700000.video: assigned reserved memory node video
00:00:06 [    3.702755] aspeed-video 1e700000.video: alloc mem size(24576) at 0xbc000000 for jpeg header
00:00:06 [    3.706139] Driver for 1-wire Dallas network protocol.
00:00:07 smbus: error: Unexpected send start condition in state -1
00:00:07 smbus: error: Unexpected write in state -1
00:00:10 smbus: error: Unexpected send start condition in state -1
00:00:10 smbus: error: Unexpected write in state -1
00:00:12 smbus: error: Unexpected send start condition in state -1
00:00:12 smbus: error: Unexpected write in state -1
00:00:14 smbus: error: Unexpected send start condition in state -1
00:00:14 smbus: error: Unexpected write in state -1
00:00:17 smbus: error: Unexpected send start condition in state -1
00:00:17 smbus: error: Unexpected write in state -1
00:00:18 [   14.080141] adt7475 7-002e: Error configuring attenuator bypass
00:00:19 smbus: error: Unexpected send start condition in state -1
00:00:19 smbus: error: Unexpected write in state -1
00:00:21 smbus: error: Unexpected send start condition in state -1
00:00:21 smbus: error: Unexpected write in state -1
00:00:24 smbus: error: Unexpected send start condition in state -1
00:00:24 smbus: error: Unexpected write in state -1
```

The smbus errors do not occur if I revert this patch.

Can you look into qemu to see if it's a bug in the aspeed i2c
controller model's state machine?

Cheers,

Andrew
