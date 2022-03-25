From: Ali El-Haj-Mahmoud <aaelhaj@google.com>
Date: Fri, 25 Mar 2022 10:39:27 -0400
Subject: aspeed2500 SPI1 control at run-time with OpenBMC
Message-ID: <CAFPZpNbNc5Fx1tBtmM1x0n-qEB_qp+wSSrR2+_0bxPrPyh1xMw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm working on an aspeed2500-based system:
https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts.

We would like to be able to update the host BIOS (SPI1) from the BMC.
Something along these lines:

- Upload a BIOS image to the BMC. Validate.
- Power down the host.
- Switch SPI1 control (SCU70[13:12]) to 'master' to connect to BMC.
- Flash the new image.
- Switch SPI1 to 'passthru' to connect back to the host.
- Power on the host.

I'm able to accomplish this in a debug build using devmem to control
SCU70[13:12]. However, it seems this should be doable via pinctrl
instead (https://github.com/torvalds/linux/blob/master/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c#L515-L520),
but I'm not able to get it to work.

To begin with, a patch similar to
https://lists.ozlabs.org/pipermail/openbmc/2016-November/005392.html
is needed to allow modifying SCU70[13:12] via pinctrl.

After that, I'm not sure how to configure SPI1 in the DTS.

With the config below, SPI1 is connected to the BMC, and the host cannot boot:

&spi1 {
status = "okay";
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_spi1_default>;
pinctrl-1 = <&pinctrl_spi1passthru_default>;
...
};

I can still switch it to passthru at run time and boot the host, but
that's not the behavior I'd like:

$ echo SPI1PASSTHRU SPI1PASSTHRU >
/sys/kernel/debug/pinctrl/1e6e2080.pinctrl-aspeed-g5-pinctrl/pinmux-select

If I switch the order of the pinctrls, SPI1 is connected to the host,
and I cannot access it from the BMC, even if I try to explicitly
switch it:

&spi1 {
status = "okay";
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_spi1passthru_default>;
pinctrl-1 = <&pinctrl_spi1_default>;
...
};

And this has no effect:
$ echo SPI1 SPI1 >
/sys/kernel/debug/pinctrl/1e6e2080.pinctrl-aspeed-g5-pinctrl/pinmux-select

Is this use-case supported through pinctrl? Am I missing something here? Thanks!
