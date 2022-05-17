From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 17 May 2022 14:50:55 +0000
Subject: [PATCH v2 2/3] ARM: dts: aspeed: Add USB2.0 device controller node
In-Reply-To: <96973d1d-c52c-d190-6989-3f7996dae70b@linaro.org>
References: <20220517082558.3534161-1-neal_liu@aspeedtech.com>
 <20220517082558.3534161-3-neal_liu@aspeedtech.com>
 <96973d1d-c52c-d190-6989-3f7996dae70b@linaro.org>
Message-ID: <HK0PR06MB32027CAC4BEE443F426F587380CE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, May 17, 2022 8:00 PM
> To: Neal Liu <neal_liu@aspeedtech.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; Felipe Balbi <balbi@kernel.org>; Sumit
> Semwal <sumit.semwal@linaro.org>; Christian K?nig
> <christian.koenig@amd.com>; Geert Uytterhoeven <geert@linux-m68k.org>;
> Li Yang <leoyang.li@nxp.com>
> Cc: linux-aspeed at lists.ozlabs.org; linux-usb at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; linux-media at vger.kernel.org;
> dri-devel at lists.freedesktop.org; linaro-mm-sig at lists.linaro.org
> Subject: Re: [PATCH v2 2/3] ARM: dts: aspeed: Add USB2.0 device controller
> node
> 
> On 17/05/2022 10:25, Neal Liu wrote:
> > Add USB2.0 device controller(udc) node to device tree for AST2600.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 3d5ce9da42c3..5517313eb2b5 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -298,6 +298,16 @@ vhub: usb-vhub at 1e6a0000 {
> >  			status = "disabled";
> >  		};
> >
> > +		udc: udc at 1e6a2000 {
> 
> The same as DTS in bindings - generic node name, please.
> 

Is it possible to use "udc: usb-udc at 1e6a2000" to distinguish it between "vhub: usb-vhub at 1e6a0000"?

> 
> Best regards,
> Krzysztof
