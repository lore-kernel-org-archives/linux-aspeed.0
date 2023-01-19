From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Jan 2023 01:54:22 +0000
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
In-Reply-To: <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com> <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
Message-ID: <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 26 Aug 2022 at 22:48, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Sat, 27 Aug 2022, at 07:26, Linus Walleij wrote:
> > On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> >> When the driver want to disable the signal of the function, it doesn't
> >> need to query the state of the mux function's signal on a pin. The
> >> condition below will miss the disable of the signal:

> > I can't see the verdict for this patch? Will there be a new
> > version, or are we in the middle of a discussion?
> > I'd really like Andrew's ACK on the result before merging.
>
> Apologies, it's been a bit of A Week :)
>
> Given the approach has been discussed with the IP designer and solves a bug I'm okay for it to be merged. If we run into issues it is easy enough to back it out.

As foreseen by Andrew, this caused a regression. On the Romulus
machine the device tree contains a gpio hog for GPIO S7. With the
patch applied:

[    0.384796] aspeed-g5-pinctrl 1e6e2080.pinctrl: request pin 151
(AA20) for 1e780000.gpio:943
[    0.385009] Muxing pin 151 for GPIO
[    0.385081] Disabling signal VPOB9 for VPO
[    0.402291] aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to acquire
regmap for IP block 1
[    0.402521] aspeed-g5-pinctrl 1e6e2080.pinctrl: request() failed for pin 151

The code path is aspeed-gpio -> pinmux-g5 -> regmap -> clk, and the
of_clock code returns an error as it doesn't have a valid struct
clk_hw pointer. The regmap call happens because pinmux wants to check
the GFX node (IP block 1) to query bits there.

For reference, reverting the patch gives us this trace:

[    0.393160] Muxing pin 151 for GPIO
[    0.393267] Disabling signal VPOB9 for VPO
[    0.393383] Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
[    0.393552] Disabling signal VPOB9 for VPOOFF1
[    0.393681] Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
[    0.393835] Disabling signal VPOB9 for VPOOFF2
[    0.393965] Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
[    0.394097] Enabling signal GPIOS7 for GPIOS7
[    0.394217] Muxed pin 151 as GPIOS7
[    0.394411] gpio-943 (seq_cont): hogged as output/low

This can be reproduced in qemu without userspace:

qemu-system-arm -M romulus-bmc -nographic -kernel arch/arm/boot/zImage
-dtb arch/arm/boot/dts/aspeed-bmc-opp-romulus.dtb -no-reboot

Billy, do you have any suggestions?

Cheers,

Joel
