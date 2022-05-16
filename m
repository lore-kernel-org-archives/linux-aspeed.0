From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 16 May 2022 06:00:28 +0000
Subject: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed udc
In-Reply-To: <3499cca2-1d7b-12f5-adbe-0c9b279cc51a@linaro.org>
References: <20220513065728.857722-1-neal_liu@aspeedtech.com>
 <20220513065728.857722-4-neal_liu@aspeedtech.com>
 <da78aaf6-c9ae-d591-fdc4-723f097ace2c@linaro.org>
 <HK0PR06MB3202679A7FABAF7D0D045F0880CA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <567d135b-3d40-9958-e000-1357020b5650@linaro.org>
 <HK0PR06MB32020539063F8A7C5D56E0B980CF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <3499cca2-1d7b-12f5-adbe-0c9b279cc51a@linaro.org>
Message-ID: <HK0PR06MB32029ED5503C616E0AF5899280CF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, May 16, 2022 1:54 PM
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
> Subject: Re: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed udc
> 
> On 16/05/2022 03:59, Neal Liu wrote:
> >>> Okay, I could rename it for next patch if you preferred.
> >>> But there are lots of yaml files which are not named as first compatible.
> >>
> >> Yes, I know, I quite likely I also produced such bindings, but a
> >> specific name is rather preferred. Otherwise you will have a
> >> difficult naming choice when your next Aspeed UDC requires new
> >> bindings file because of some differences (not yet known now).
> >>
> > We can rename the bindings if next Aspeed UDC needs, don't you think?
> > Currently, Aspeed has no requirement.
> 
> So just use proper name from the beginning....
>
Okay, I'll rename it for next patch.
Thanks for the review.

> 
> Best regards,
> Krzysztof
