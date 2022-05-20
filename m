From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 20 May 2022 07:44:13 +0200
Subject: [PATCH v3 1/3] usb: gadget: add Aspeed ast2600 udc driver
In-Reply-To: <HK0PR06MB32020AEF88CFFD4296762B2880D39@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220518062043.1075360-1-neal_liu@aspeedtech.com>
 <20220518062043.1075360-2-neal_liu@aspeedtech.com>
 <YoZoouI4EbnNYE6h@kroah.com>
 <HK0PR06MB32020AEF88CFFD4296762B2880D39@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <YocqrTHm29g9qU69@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 20, 2022 at 02:29:36AM +0000, Neal Liu wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, May 19, 2022 11:56 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> > Jeffery <andrew@aj.id.au>; Felipe Balbi <balbi@kernel.org>; Sumit Semwal
> > <sumit.semwal@linaro.org>; Christian K?nig <christian.koenig@amd.com>;
> > Geert Uytterhoeven <geert@linux-m68k.org>; Li Yang <leoyang.li@nxp.com>;
> > linux-aspeed at lists.ozlabs.org; linux-usb at vger.kernel.org;
> > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-kernel at vger.kernel.org; linux-media at vger.kernel.org;
> > dri-devel at lists.freedesktop.org; linaro-mm-sig at lists.linaro.org; kernel test
> > robot <lkp@intel.com>
> > Subject: Re: [PATCH v3 1/3] usb: gadget: add Aspeed ast2600 udc driver
> > 
> > On Wed, May 18, 2022 at 02:20:41PM +0800, Neal Liu wrote:
> > > Aspeed udc is compliant with USB2.0, supports USB High Speed and Full
> > > Speed, backward compatible with USB1.1.
> > >
> > > Supports independent DMA channel for each generic endpoint.
> > > Supports 32/256 stages descriptor mode for all generic endpoints.
> > >
> > > This driver supports full functionality including single/multiple
> > > stages descriptor mode, and exposes 1 UDC gadget driver.
> > >
> > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > The kernel test robot did not report that you needed to add a new driver :(
> 
> I had received auto build test WARNING on usb/usb-testing reported from kernel test robot.
> It still mentioned that if the issue is fixed, I can kindly add this tag.
> Would you prefer not to add this tag for the first coming driver?

Please do not add tags that do not make sense to.

thanks,

greg k-h
