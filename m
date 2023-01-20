From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Jan 2023 13:05:02 +1030
Subject: [PATCH] pinctrl: aspeed-g5: Bypass clock check when fetching regmap
In-Reply-To: <20230119235501.53294-1-joel@jms.id.au>
References: <20230119235501.53294-1-joel@jms.id.au>
Message-ID: <b565b254-45aa-4f7a-b158-99fb4c66167f@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 20 Jan 2023, at 10:25, Joel Stanley wrote:
> A recent commit cf517fef601b ("pinctrl: aspeed: Force to disable the
> function's signal") exposed a problem with fetching the regmap for
> reading the GFX register.
>
> The Romulus machine the device tree contains a gpio hog for GPIO S7.
> With the patch applied:
>
>   Muxing pin 151 for GPIO
>   Disabling signal VPOB9 for VPO
>   aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to acquire regmap for IP block 1
>   aspeed-g5-pinctrl 1e6e2080.pinctrl: request() failed for pin 151
>
> The code path is aspeed-gpio -> pinmux-g5 -> regmap -> clk, and the
> of_clock code returns an error as it doesn't have a valid struct clk_hw
> pointer. The regmap call happens because pinmux wants to check the GFX
> node (IP block 1) to query bits there.
>
> For reference, before the offending patch:
>
>   Muxing pin 151 for GPIO
>   Disabling signal VPOB9 for VPO
>   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>   Disabling signal VPOB9 for VPOOFF1
>   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>   Disabling signal VPOB9 for VPOOFF2
>   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>   Enabling signal GPIOS7 for GPIOS7
>   Muxed pin 151 as GPIOS7
>   gpio-943 (seq_cont): hogged as output/low
>
> As a workaround, skip the clock check to allow pinmux to proceed.

We'd want the clock on and and the device out of reset before this 
makes sense though. We're just assuming the IP is in an operational 
state? Was this just accidentally working because reading the register 
in a bad state is producing 0 instead of other undefined garbage?

Andrew
