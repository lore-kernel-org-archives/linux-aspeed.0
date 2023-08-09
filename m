From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 9 Aug 2023 03:05:34 +0000
Subject: [PATCH 0/3] Add Aspeed AST2600 I3C support
In-Reply-To: <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
 <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
Message-ID: <TYZPR06MB65674B8AA26D959254101A749C12A@TYZPR06MB6567.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

> -----Original Message-----
> From: Jeremy Kerr [mailto:jk at codeconstruct.com.au]
> Sent: Wednesday, August 9, 2023 8:08 AM
> To: Dylan Hung <dylan_hung@aspeedtech.com>;
> alexandre.belloni at bootlin.com; robh+dt at kernel.org;
> krzysztof.kozlowski+dt at linaro.org; conor+dt at kernel.org; joel at jms.id.au;
> andrew at aj.id.au; p.zabel at pengutronix.de; linux-i3c at lists.infradead.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; kobedylan at gmail.com
> Subject: Re: [PATCH 0/3] Add Aspeed AST2600 I3C support
>
> Hi Dylan,
>
> > This patch series introduces the necessary changes to enable I3C
> > support for the Aspeed AST2600 I3C controller. Specifically, it
> > addresses the missing pinctrl configuration and reset control for the
> > I3C functionality.
>
> +1 for the pinctrl changes for the I3C1 and I3C2 controllers (I'll
> review and ack separately). I have been testing on I3C3 and up, but just not
> with the HVI3C on 1 & 2, hence no pinctrl definition there.

Thank you for your review. I3C1 and I3C2 can only operate in low voltage (1.0V/1.2V), which is why there are no HVI3C1 and HVI3C2 pinctrl definitions.

>
> However, I don't think the other two are needed.
>
> For 2/3 and 3/3, you're adding a reset control for the global register block
> within the per-controller driver, but we can already do that on a global basis
> with the existing syscon device. Hence this earlier change:
>

I followed your recommendation and verified that it worked on my end.
Should I resend the pinctrl patch as a stand-alone submission?

>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/dri
> vers/mfd/syscon.c?id=7d1e3bd94828ad9fc86f55253cd6fec8edd65394
>
> For this, I have:
>
>     &i3c {
>         i3c_global: i3c-global {
>             compatible = "aspeed,ast2600-i3c-global", "simple-mfd",
> "syscon";
>             resets = <&syscon ASPEED_RESET_I3C_DMA>;
>             reg = <0x0 0x1000>;
>         };
>
>         i3c2: i3c-master at 4000 {
>             compatible = "aspeed,ast2600-i3c";
>             reg = <0x4000 0x1000>;
>             clocks = <&syscon ASPEED_CLK_GATE_I3C2CLK>;
>             pinctrl-names = "default";
>             pinctrl-0 = <&pinctrl_i3c3_default>;
>             interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
>             aspeed,global-regs = <&i3c_global 2>;
>             status = "disabled";
>         };
>
>         /* ... */
>     };
>
> - with no changes needed to any bindings. I haven't needed any other resets;
> are there per-controller resets specified in the HW docs you have?
>
> Does that work for you? If you'd like to test, feel free to use my sample dts at:
>
>
> https://github.com/CodeConstruct/linux/commit/05cac24705fa62d2176ecbb
> bf15d955cfe86e753
>
> Cheers,
>
>
> Jeremy
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230809/b6f205ac/attachment-0001.htm>
