From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 19 Dec 2023 09:32:45 +1030
Subject: [PATCH v4 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
In-Reply-To: <7dfc99e5-4c76-413b-aabc-81b26e26249e@os.amperecomputing.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
	 <20231211102217.2436294-3-quan@os.amperecomputing.com>
	 <2eab42cde34723a195e7a0287db08b25f8388a3b.camel@codeconstruct.com.au>
	 <54cba87a0df233b8762e43b742afe8e44a77a60c.camel@codeconstruct.com.au>
	 <7dfc99e5-4c76-413b-aabc-81b26e26249e@os.amperecomputing.com>
Message-ID: <477f1e8fbed91cc1160086af1f20030e7a6d853b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2023-12-18 at 15:45 +0700, Quan Nguyen wrote:
> 
> On 15/12/2023 05:21, Andrew Jeffery wrote:
> > 
> > ```
> > $ qemu-system-arm \
> > 	-M ast2600-evb \
> > 	-kernel build.aspeed_g5/arch/arm/boot/zImage \
> > 	-dtb build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb \
> > 	-initrd ~/src/buildroot.org/buildroot/output/images/rootfs.cpio.xz \
> > 	-nographic 2>&1 \
> > 	| ts -s
> > ...
> > 00:00:03 [    1.089187] Freeing initrd memory: 3308K
> > 00:00:05 smbus: error: Unexpected send start condition in state 1
> > 00:00:05 smbus: error: Unexpected write in state -1
> > 00:00:06 [    3.685731] aspeed-i2c-bus 1e78a400.i2c-bus: i2c bus 7 registered, irq 48
> > 00:00:06 [    3.688918] aspeed-i2c-bus 1e78a480.i2c-bus: i2c bus 8 registered, irq 49
> > 00:00:06 [    3.692326] aspeed-i2c-bus 1e78a500.i2c-bus: i2c bus 9 registered, irq 50
> > 00:00:06 [    3.693757] aspeed-i2c-bus 1e78a680.i2c-bus: i2c bus 12 registered, irq 51
> > 00:00:06 [    3.695070] aspeed-i2c-bus 1e78a700.i2c-bus: i2c bus 13 registered, irq 52
> > 00:00:06 [    3.696184] aspeed-i2c-bus 1e78a780.i2c-bus: i2c bus 14 registered, irq 53
> > 00:00:06 [    3.697144] aspeed-i2c-bus 1e78a800.i2c-bus: i2c bus 15 registered, irq 54
> > 00:00:06 [    3.699061] aspeed-video 1e700000.video: irq 55
> > 00:00:06 [    3.699254] aspeed-video 1e700000.video: assigned reserved memory node video
> > 00:00:06 [    3.702755] aspeed-video 1e700000.video: alloc mem size(24576) at 0xbc000000 for jpeg header
> > 00:00:06 [    3.706139] Driver for 1-wire Dallas network protocol.
> > 00:00:07 smbus: error: Unexpected send start condition in state -1
> > 00:00:07 smbus: error: Unexpected write in state -1
> > 00:00:10 smbus: error: Unexpected send start condition in state -1
> > 00:00:10 smbus: error: Unexpected write in state -1
> > 00:00:12 smbus: error: Unexpected send start condition in state -1
> > 00:00:12 smbus: error: Unexpected write in state -1
> > 00:00:14 smbus: error: Unexpected send start condition in state -1
> > 00:00:14 smbus: error: Unexpected write in state -1
> > 00:00:17 smbus: error: Unexpected send start condition in state -1
> > 00:00:17 smbus: error: Unexpected write in state -1
> > 00:00:18 [   14.080141] adt7475 7-002e: Error configuring attenuator bypass
> > 00:00:19 smbus: error: Unexpected send start condition in state -1
> > 00:00:19 smbus: error: Unexpected write in state -1
> > 00:00:21 smbus: error: Unexpected send start condition in state -1
> > 00:00:21 smbus: error: Unexpected write in state -1
> > 00:00:24 smbus: error: Unexpected send start condition in state -1
> > 00:00:24 smbus: error: Unexpected write in state -1
> > ```
> > 
> > The smbus errors do not occur if I revert this patch.
> > 
> > Can you look into qemu to see if it's a bug in the aspeed i2c
> > controller model's state machine?
> > 
> 
> Thanks, Andrew, for testing these patches on qemu.
> 
> I'll try to look into it to see if anything can be improved, but I have 
> to admit that I'm not so familiar with it. This is my first time trying 
> it on qemu. Just did these tests on real HW with waveform captured 
> sometimes.
> 
> So far I could be able to reproduce the issue and start playing around 
> trying to understand the model.
> 

So `$ git grep -lF 'Unexpected write in state'` leads us to
hw/i2c/smbus_slave.c:193. From the switch statement there and the log
output above dev->mode must be SMBUS_CONFUSED:


https://gitlab.com/qemu-project/qemu/-/blob/039afc5ef7367fbc8fb475580c291c2655e856cb/hw/i2c/smbus_slave.c#L35-L41

The prior log message was:

```
00:00:05 smbus: error: Unexpected send start condition in state 1
```

So we entered SMBUS_CONFUSED from SMBUS_WRITE_DATA. Given the log
output above it suggests the master model is failing to send an
I2C_FINISH prior to I2C_START_SEND, as that log message is emitted from
`dev->mode != SMBUS_IDLE` when the slave sees an `I2C_START_SEND`.

Perhaps the M_STOP_CMD handling needs to go above the M_START_CMD
handling in aspeed_i2c_bus_handle_cmd()?

https://gitlab.com/qemu-project/qemu/-/blob/039afc5ef7367fbc8fb475580c291c2655e856cb/hw/i2c/aspeed_i2c.c#L450

Andrew
