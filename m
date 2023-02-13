From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 13 Feb 2023 01:46:17 +0000
Subject: [PATCH 4/4] ARM: dts: aspeed-g6: Add UDMA node
In-Reply-To: <db065c0a-6c0e-ebf1-1867-6271b0cb5e8a@linaro.org>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-5-chiawei_wang@aspeedtech.com>
 <db065c0a-6c0e-ebf1-1867-6271b0cb5e8a@linaro.org>
Message-ID: <KL1PR0601MB37811723965A68AB07016AF191DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, February 10, 2023 5:14 PM
> 
> On 10/02/2023 08:26, Chia-Wei Wang wrote:
> > Add the device tree node for UART DMA controller.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index cc2f8b785917..3f4e9da8f6c7 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -850,6 +850,13 @@ fsim1: fsi at 1e79b100 {
> >  				clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
> >  				status = "disabled";
> >  			};
> > +
> > +			udma: uart-dma at 1e79e000 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-
> basics.html#generic-names-recommendation
> 
> > +				compatible = "aspeed,ast2600-udma";
> 
> Please run scripts/checkpatch.pl and fix reported warnings.

Thanks for reminding. Will add the dt-bindings for UDMA as well.

Regards,
Chiawei
