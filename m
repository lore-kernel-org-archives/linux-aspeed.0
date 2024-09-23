From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 23 Sep 2024 02:50:16 +0000
Subject: [PATCH v3 3/4] reset: aspeed: register AST2700 reset auxiliary
 bus device
In-Reply-To: <8412982c-17c0-4596-a9eb-cd28ad747048@wanadoo.fr>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-4-ryan_chen@aspeedtech.com>
 <8412982c-17c0-4596-a9eb-cd28ad747048@wanadoo.fr>
Message-ID: <OS8PR06MB75417331711B3918C89F6B74F26F2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v3 3/4] reset: aspeed: register AST2700 reset auxiliary bus
> device
> 
> Le 16/09/2024 ? 11:10, Ryan Chen a ?crit?:
> > The AST2700 reset driver is registered as an auxiliary device due to
> > reset and clock controller share the same register region.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> Hi,
> 
> ...
> 
> > +static const struct ast2700_reset_signal ast2700_reset0_signals[] = {
> > +	[SCU0_RESET_SDRAM] = { true, SCU0_RESET_CTRL1, BIT(0) },
> > +	[SCU0_RESET_DDRPHY] = { true, SCU0_RESET_CTRL1, BIT(1) },
> > +	[SCU0_RESET_RSA]     = { true, SCU0_RESET_CTRL1, BIT(2) },
> > +	[SCU0_RESET_SHA3]	= { true, SCU0_RESET_CTRL1, BIT(3) },
> > +	[SCU0_RESET_HACE]	= { true, SCU0_RESET_CTRL1, BIT(4) },
> > +	[SCU0_RESET_SOC]	= { true, SCU0_RESET_CTRL1, BIT(5) },
> > +	[SCU0_RESET_VIDEO]	= { true, SCU0_RESET_CTRL1, BIT(6) },
> > +	[SCU0_RESET_2D]	= { true, SCU0_RESET_CTRL1, BIT(7) },
> > +	[SCU0_RESET_PCIS]	= { true, SCU0_RESET_CTRL1, BIT(8) },
> > +	[SCU0_RESET_RVAS0]		= { true, SCU0_RESET_CTRL1, BIT(9) },
> > +	[SCU0_RESET_RVAS1]		= { true, SCU0_RESET_CTRL1, BIT(10) },
> > +	[SCU0_RESET_SM3]		= { true, SCU0_RESET_CTRL1, BIT(11) },
> > +	[SCU0_RESET_SM4]		= { true, SCU0_RESET_CTRL1, BIT(12) },
> > +	[SCU0_RESET_CRT0]	= { true, SCU0_RESET_CTRL1, BIT(13) },
> > +	[SCU0_RESET_ECC]	= { true, SCU0_RESET_CTRL1, BIT(14) },
> > +	[SCU0_RESET_DP_PCI]	= { true, SCU0_RESET_CTRL1, BIT(15) },
> > +	[SCU0_RESET_UFS]	= { true, SCU0_RESET_CTRL1, BIT(16) },
> > +	[SCU0_RESET_EMMC]	= { true, SCU0_RESET_CTRL1, BIT(17) },
> > +	[SCU0_RESET_PCIE1RST]	= { true, SCU0_RESET_CTRL1, BIT(18) },
> > +	[SCU0_RESET_PCIE1RSTOE]	= { true, SCU0_RESET_CTRL1, BIT(19) },
> > +	[SCU0_RESET_PCIE0RST]		= { true, SCU0_RESET_CTRL1, BIT(20) },
> > +	[SCU0_RESET_PCIE0RSTOE]	= { true, SCU0_RESET_CTRL1, BIT(21) },
> > +	[SCU0_RESET_JTAG]	= { true, SCU0_RESET_CTRL1, BIT(22) },
> > +	[SCU0_RESET_MCTP0] = { true, SCU0_RESET_CTRL1, BIT(23) },
> > +	[SCU0_RESET_MCTP1]		= { true, SCU0_RESET_CTRL1, BIT(24) },
> > +	[SCU0_RESET_XDMA0]	= { true, SCU0_RESET_CTRL1, BIT(25) },
> > +	[SCU0_RESET_XDMA1]	= { true, SCU0_RESET_CTRL1, BIT(26) },
> > +	[SCU0_RESET_H2X1]	= { true, SCU0_RESET_CTRL1, BIT(27) },
> > +	[SCU0_RESET_DP]	= { true, SCU0_RESET_CTRL1, BIT(28) },
> > +	[SCU0_RESET_DP_MCU]	= { true, SCU0_RESET_CTRL1, BIT(29) },
> > +	[SCU0_RESET_SSP]	= { true, SCU0_RESET_CTRL1, BIT(30) },
> > +	[SCU0_RESET_H2X0]	= { true, SCU0_RESET_CTRL1, BIT(31) },
> > +	[SCU0_RESET_PORTA_VHUB]	= { true, SCU0_RESET_CTRL2, BIT(0) },
> > +	[SCU0_RESET_PORTA_PHY3]	= { true, SCU0_RESET_CTRL2, BIT(1) },
> > +	[SCU0_RESET_PORTA_XHCI]	= { true, SCU0_RESET_CTRL2, BIT(2) },
> > +	[SCU0_RESET_PORTB_VHUB]	= { true, SCU0_RESET_CTRL2, BIT(3) },
> > +	[SCU0_RESET_PORTB_PHY3]	= { true, SCU0_RESET_CTRL2, BIT(4) },
> > +	[SCU0_RESET_PORTB_XHCI]	= { true, SCU0_RESET_CTRL2, BIT(5) },
> > +	[SCU0_RESET_PORTA_VHUB_EHCI]	= { true, SCU0_RESET_CTRL2,
> BIT(6) },
> > +	[SCU0_RESET_PORTB_VHUB_EHCI]	= { true, SCU0_RESET_CTRL2,
> BIT(7) },
> > +	[SCU0_RESET_UHCI]	= { true, SCU0_RESET_CTRL2, BIT(8) },
> > +	[SCU0_RESET_TSP]	= { true, SCU0_RESET_CTRL2, BIT(9) },
> > +	[SCU0_RESET_E2M0]	= { true, SCU0_RESET_CTRL2, BIT(10) },
> > +	[SCU0_RESET_E2M1]	= { true, SCU0_RESET_CTRL2, BIT(11) },
> > +	[SCU0_RESET_VLINK]	= { true, SCU0_RESET_CTRL2, BIT(12) },
> > +};
> 
> The sapces and tabs in both tables look not consistent.
Will update.

> 
> > +
> > +static const struct ast2700_reset_signal ast2700_reset1_signals[] = {
> > +	[SCU1_RESET_LPC0] = { true, SCU1_RESET_CTRL1, BIT(0) },
> > +	[SCU1_RESET_LPC1] = { true, SCU1_RESET_CTRL1, BIT(1) },
> > +	[SCU1_RESET_MII]     = { true, SCU1_RESET_CTRL1, BIT(2) },
> > +	[SCU1_RESET_PECI]	= { true, SCU1_RESET_CTRL1, BIT(3) },
> > +	[SCU1_RESET_PWM]	= { true, SCU1_RESET_CTRL1, BIT(4) },
> > +	[SCU1_RESET_MAC0]	= { true, SCU1_RESET_CTRL1, BIT(5) },
> > +	[SCU1_RESET_MAC1]	= { true, SCU1_RESET_CTRL1, BIT(6) },
> > +	[SCU1_RESET_MAC2]	= { true, SCU1_RESET_CTRL1, BIT(7) },
> > +	[SCU1_RESET_ADC]	= { true, SCU1_RESET_CTRL1, BIT(8) },
> > +	[SCU1_RESET_SD]		= { true, SCU1_RESET_CTRL1, BIT(9) },
> > +	[SCU1_RESET_ESPI0]		= { true, SCU1_RESET_CTRL1, BIT(10) },
> > +	[SCU1_RESET_ESPI1]		= { true, SCU1_RESET_CTRL1, BIT(11) },
> > +	[SCU1_RESET_JTAG1]		= { true, SCU1_RESET_CTRL1, BIT(12) },
> > +	[SCU1_RESET_SPI0]	= { true, SCU1_RESET_CTRL1, BIT(13) },
> > +	[SCU1_RESET_SPI1]	= { true, SCU1_RESET_CTRL1, BIT(14) },
> > +	[SCU1_RESET_SPI2]	= { true, SCU1_RESET_CTRL1, BIT(15) },
> > +	[SCU1_RESET_I3C0]	= { true, SCU1_RESET_CTRL1, BIT(16) },
> > +	[SCU1_RESET_I3C1]	= { true, SCU1_RESET_CTRL1, BIT(17) },
> > +	[SCU1_RESET_I3C2]	= { true, SCU1_RESET_CTRL1, BIT(18) },
> > +	[SCU1_RESET_I3C3]	= { true, SCU1_RESET_CTRL1, BIT(19) },
> > +	[SCU1_RESET_I3C4]		= { true, SCU1_RESET_CTRL1, BIT(20) },
> > +	[SCU1_RESET_I3C5]	= { true, SCU1_RESET_CTRL1, BIT(21) },
> > +	[SCU1_RESET_I3C6]	= { true, SCU1_RESET_CTRL1, BIT(22) },
> > +	[SCU1_RESET_I3C7] = { true, SCU1_RESET_CTRL1, BIT(23) },
> > +	[SCU1_RESET_I3C8]		= { true, SCU1_RESET_CTRL1, BIT(24) },
> > +	[SCU1_RESET_I3C9]	= { true, SCU1_RESET_CTRL1, BIT(25) },
> > +	[SCU1_RESET_I3C10]	= { true, SCU1_RESET_CTRL1, BIT(26) },
> > +	[SCU1_RESET_I3C11]	= { true, SCU1_RESET_CTRL1, BIT(27) },
> > +	[SCU1_RESET_I3C12]	= { true, SCU1_RESET_CTRL1, BIT(28) },
> > +	[SCU1_RESET_I3C13]	= { true, SCU1_RESET_CTRL1, BIT(29) },
> > +	[SCU1_RESET_I3C14]	= { true, SCU1_RESET_CTRL1, BIT(30) },
> > +	[SCU1_RESET_I3C15]	= { true, SCU1_RESET_CTRL1, BIT(31) },
> > +	[SCU1_RESET_MCU0]	= { true, SCU1_RESET_CTRL2, BIT(0) },
> > +	[SCU1_RESET_MCU1]	= { true, SCU1_RESET_CTRL2, BIT(1) },
> > +	[SCU1_RESET_H2A_SPI1]	= { true, SCU1_RESET_CTRL2, BIT(2) },
> > +	[SCU1_RESET_H2A_SPI2]	= { true, SCU1_RESET_CTRL2, BIT(3) },
> > +	[SCU1_RESET_UART0]	= { true, SCU1_RESET_CTRL2, BIT(4) },
> > +	[SCU1_RESET_UART1]	= { true, SCU1_RESET_CTRL2, BIT(5) },
> > +	[SCU1_RESET_UART2]	= { true, SCU1_RESET_CTRL2, BIT(6) },
> > +	[SCU1_RESET_UART3]	= { true, SCU1_RESET_CTRL2, BIT(7) },
> > +	[SCU1_RESET_I2C_FILTER]	= { true, SCU1_RESET_CTRL2, BIT(8) },
> > +	[SCU1_RESET_CALIPTRA]	= { true, SCU1_RESET_CTRL2, BIT(9) },
> > +	[SCU1_RESET_XDMA]	= { true, SCU1_RESET_CTRL2, BIT(10) },
> > +	[SCU1_RESET_FSI]	= { true, SCU1_RESET_CTRL2, BIT(12) },
> > +	[SCU1_RESET_CAN]	= { true, SCU1_RESET_CTRL2, BIT(13) },
> > +	[SCU1_RESET_MCTP]	= { true, SCU1_RESET_CTRL2, BIT(14) },
> > +	[SCU1_RESET_I2C]	= { true, SCU1_RESET_CTRL2, BIT(15) },
> > +	[SCU1_RESET_UART6]	= { true, SCU1_RESET_CTRL2, BIT(16) },
> > +	[SCU1_RESET_UART7]	= { true, SCU1_RESET_CTRL2, BIT(17) },
> > +	[SCU1_RESET_UART8]	= { true, SCU1_RESET_CTRL2, BIT(18) },
> > +	[SCU1_RESET_UART9]	= { true, SCU1_RESET_CTRL2, BIT(19) },
> > +	[SCU1_RESET_LTPI0]	= { true, SCU1_RESET_CTRL2, BIT(20) },
> > +	[SCU1_RESET_VGAL]	= { true, SCU1_RESET_CTRL2, BIT(21) },
> > +	[SCU1_RESET_LTPI1]	= { true, SCU1_RESET_CTRL2, BIT(22) },
> > +	[SCU1_RESET_ACE]	= { true, SCU1_RESET_CTRL2, BIT(23) },
> > +	[SCU1_RESET_E2M]	= { true, SCU1_RESET_CTRL2, BIT(24) },
> > +	[SCU1_RESET_UHCI]	= { true, SCU1_RESET_CTRL2, BIT(25) },
> > +	[SCU1_RESET_PORTC_USB2UART]	= { true, SCU1_RESET_CTRL2,
> BIT(26) },
> > +	[SCU1_RESET_PORTC_VHUB_EHCI]	= { true, SCU1_RESET_CTRL2,
> BIT(27) },
> > +	[SCU1_RESET_PORTD_USB2UART]	= { true, SCU1_RESET_CTRL2,
> BIT(28) },
> > +	[SCU1_RESET_PORTD_VHUB_EHCI]	= { true, SCU1_RESET_CTRL2,
> BIT(29) },
> > +	[SCU1_RESET_H2X]	= { true, SCU1_RESET_CTRL2, BIT(30) },
> > +	[SCU1_RESET_I3CDMA]	= { true, SCU1_RESET_CTRL2, BIT(31) },
> > +	[SCU1_RESET_PCIE2RST]	= { false, SCU1_PCIE3_CTRL, BIT(0) },
> > +};
> 
> ...
> 
> > +static int aspeed_reset_probe(struct auxiliary_device *adev,
> > +			      const struct auxiliary_device_id *id) {
> > +	struct aspeed_reset *reset;
> > +	struct device *dev = &adev->dev;
> > +
> > +	reset = devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
> > +	if (!reset)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&reset->lock);
> > +
> > +	reset->info	= (struct aspeed_reset_info *)(id->driver_data);
> > +	reset->rcdev.owner     = THIS_MODULE;
> > +	reset->rcdev.nr_resets = reset->info->nr_resets;
> > +	reset->rcdev.ops       = &aspeed_reset_ops;
> > +	reset->rcdev.of_node   = dev->parent->of_node;
> > +	reset->rcdev.dev	      = dev;
> > +	reset->rcdev.of_reset_n_cells = 1;
> > +	reset->base            = (void __iomem *)adev->dev.platform_data;
> 
> The spaces and tabs look broken for 'info' and 'rcdev.dev'.
Will update by spaces.
> 
> > +
> > +	if (!reset->base)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(dev, reset);
> 
> Is it needed?
> (there is no dev_get_drvdata())

No need, will remove.
> 
> > +
> > +	return devm_reset_controller_register(dev, &reset->rcdev); }
> 
> ...
> 
> CJ
