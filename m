From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 19 May 2022 17:56:18 +0200
Subject: [PATCH v3 1/3] usb: gadget: add Aspeed ast2600 udc driver
In-Reply-To: <20220518062043.1075360-2-neal_liu@aspeedtech.com>
References: <20220518062043.1075360-1-neal_liu@aspeedtech.com>
 <20220518062043.1075360-2-neal_liu@aspeedtech.com>
Message-ID: <YoZoouI4EbnNYE6h@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 18, 2022 at 02:20:41PM +0800, Neal Liu wrote:
> Aspeed udc is compliant with USB2.0, supports USB High Speed
> and Full Speed, backward compatible with USB1.1.
> 
> Supports independent DMA channel for each generic endpoint.
> Supports 32/256 stages descriptor mode for all generic endpoints.
> 
> This driver supports full functionality including single/multiple
> stages descriptor mode, and exposes 1 UDC gadget driver.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot did not report that you needed to add a new driver :(

