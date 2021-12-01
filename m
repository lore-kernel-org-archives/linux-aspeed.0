From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 1 Dec 2021 07:18:12 +0100
Subject: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
 <YaYOvgCaO4FJ8r+z@kroah.com>
 <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <YacTpI7k5gTDQ4Ki@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 01, 2021 at 05:43:16AM +0000, Neal Liu wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Tuesday, November 30, 2021 7:45 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>
> > Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> > Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> > <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel test
> > robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> > linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; BMC-SW
> > <BMC-SW@aspeedtech.com>
> > Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
> > 
> > On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> > > Support qualifier descriptor to pass USB30CV compliance test.
> > 
> > Please provide more information here in this description.  This does not
> > explain what is happening here very well.
> > 
> > Also, what is "USB30CV"?
> > 
> 
> USB 3 Command Verifier (USB3CV) is the official tool for USB 3 Hub and Device Framework testing.
> The USB3CV tool includes the xHCI Compliance Drivers for use with the USB3CV.

Please put that information in the changelog text.

> We would like to pass USB3CV - Chapter 9 Test [USB 2 devices] - Device Qualifier Tests.
> A high-speed capable device that has different device information for full-speed and high-speed
> must have a Device Qualifier Descriptor.
> This patch is to support device qualifier, and the host will retrieve it through Get Descriptor request.

Again, this type of information needs to go into the changelog text.

thanks,

greg k-h
