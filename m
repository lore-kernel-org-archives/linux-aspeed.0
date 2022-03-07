From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Mar 2022 10:29:33 +1030
Subject: [PATCH] ARM: dts: aspeed: Fix AST2600 quad spi group
In-Reply-To: <20220304011010.974863-1-joel@jms.id.au>
References: <20220304011010.974863-1-joel@jms.id.au>
Message-ID: <22db3bbf-9796-43ac-84a4-081977827ac5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 4 Mar 2022, at 11:40, Joel Stanley wrote:
> Requesting quad mode for the FMC resulted in an error:
>
>   &fmc {
>          status = "okay";
>  +       pinctrl-names = "default";
>  +       pinctrl-0 = <&pinctrl_fwqspi_default>'
>
> [    0.742963] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: invalid 
> function FWQSPID in map table
> ?
>
> This is because the quad mode pins are a group of pins, not a function.
>
> After applying this patch we can request the pins and the QSPI data
> lines are muxed:
>
>  # cat 
> /sys/kernel/debug/pinctrl/1e6e2000.syscon\:pinctrl-aspeed-g6-pinctrl/pinmux-pins 
> |grep 1e620000.spi
>  pin 196 (AE12): device 1e620000.spi function FWSPID group FWQSPID
>  pin 197 (AF12): device 1e620000.spi function FWSPID group FWQSPID
>  pin 240 (Y1): device 1e620000.spi function FWSPID group FWQSPID
>  pin 241 (Y2): device 1e620000.spi function FWSPID group FWQSPID
>  pin 242 (Y3): device 1e620000.spi function FWSPID group FWQSPID
>  pin 243 (Y4): device 1e620000.spi function FWSPID group FWQSPID
>
> Fixes: f510f04c8c83 ("ARM: dts: aspeed: Add AST2600 pinmux nodes")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Looks good to me.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
