From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 20 May 2022 02:31:13 +0000
Subject: [PATCH v3 0/3] add Aspeed udc driver for ast2600
In-Reply-To: <YoZosLk5GhTsP841@kroah.com>
References: <20220518062043.1075360-1-neal_liu@aspeedtech.com>
 <YoZosLk5GhTsP841@kroah.com>
Message-ID: <HK0PR06MB320209500E21D25E7A31E4E880D39@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, May 19, 2022 11:57 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Felipe Balbi <balbi@kernel.org>; Sumit Semwal
> <sumit.semwal@linaro.org>; Christian K?nig <christian.koenig@amd.com>;
> Geert Uytterhoeven <geert@linux-m68k.org>; Li Yang <leoyang.li@nxp.com>;
> linux-aspeed at lists.ozlabs.org; linux-usb at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; linux-media at vger.kernel.org;
> dri-devel at lists.freedesktop.org; linaro-mm-sig at lists.linaro.org
> Subject: Re: [PATCH v3 0/3] add Aspeed udc driver for ast2600
> 
> On Wed, May 18, 2022 at 02:20:40PM +0800, Neal Liu wrote:
> > This patch series aim to add Aspeed USB 2.0 Device Controller (udc)
> > driver, including driver itself, device tree node and documentation.
> >
> > Change since v2:
> > - Rename device tree nodes.
> > - Fix unusual indentation.
> >
> > Change since v1:
> > - Fix build test warning reported by kernel test robot.
> > - Rename proper name for dt-bindings document.
> >
> > *** BLURB HERE ***
> 
> No blurb?

The blurb is above over this comment. I'll revise it as you suggested.

