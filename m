From: Christoph Hellwig <hch@lst.de>
Date: Fri, 26 Mar 2021 13:05:26 +0100
Subject: [PATCH] usb: gadget: aspeed: set port_dev dma mask
In-Reply-To: <10920f34-289c-feac-79b6-71bff2aea67d@arm.com>
References: <20210326070214.6719-1-rentao.bupt@gmail.com>
 <10920f34-289c-feac-79b6-71bff2aea67d@arm.com>
Message-ID: <20210326120526.GA14169@lst.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 26, 2021 at 12:03:03PM +0000, Robin Murphy wrote:
> This might happen to work out, but is far from correct. Just wait until you 
> try it on a platform where the USB controller is behind an IOMMU...
>
> It looks like something is more fundamentally wrong here - the device 
> passed to DMA API calls must be the actual hardware device performing the 
> DMA, which in USB-land I believe means the controller's sysdev.

The shiny new usb_intf_get_dma_device API provides the device to use.
