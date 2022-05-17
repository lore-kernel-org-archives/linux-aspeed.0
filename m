From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 17 May 2022 14:53:38 +0000
Subject: [PATCH v2 3/3] dt-bindings: usb: add documentation for aspeed udc
In-Reply-To: <414d09f8-328a-4bf4-c20e-f8ce4a6ddfc7@linaro.org>
References: <20220517082558.3534161-1-neal_liu@aspeedtech.com>
 <20220517082558.3534161-4-neal_liu@aspeedtech.com>
 <414d09f8-328a-4bf4-c20e-f8ce4a6ddfc7@linaro.org>
Message-ID: <HK0PR06MB32029E580BA9841DECF68FBD80CE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, May 17, 2022 8:04 PM
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
> Subject: Re: [PATCH v2 3/3] dt-bindings: usb: add documentation for aspeed
> udc
> 
> On 17/05/2022 10:25, Neal Liu wrote:
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/aspeed-clock.h>
> > +    usb: usb at 1e6a2000 {
> > +            compatible = "aspeed,ast2600-udc";
> 
> Sorry for not noticing it earlier - slipped through the cracks. You use here
> unusual indentation (not matching the rest of the example - above is 4 spaces,
> here is 7 or 8).
> 
> Just keep 4 spaces for DTS example.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
Got it. I'll revise it for next patch.
Thanks for your review.

> Best regards,
> Krzysztof
