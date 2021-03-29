From: Christoph Hellwig <hch@lst.de>
Date: Mon, 29 Mar 2021 08:17:35 +0200
Subject: [PATCH] usb: gadget: aspeed: set port_dev dma mask
In-Reply-To: <20210327221759.GA2997@taoren-ubuntu-R90MNF91>
References: <20210326070214.6719-1-rentao.bupt@gmail.com>
 <10920f34-289c-feac-79b6-71bff2aea67d@arm.com>
 <20210326120526.GA14169@lst.de>
 <20210327221759.GA2997@taoren-ubuntu-R90MNF91>
Message-ID: <20210329061735.GA27510@lst.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Mar 27, 2021 at 03:17:59PM -0700, Tao Ren wrote:
> On Fri, Mar 26, 2021 at 01:05:26PM +0100, Christoph Hellwig wrote:
> > On Fri, Mar 26, 2021 at 12:03:03PM +0000, Robin Murphy wrote:
> > > This might happen to work out, but is far from correct. Just wait until you 
> > > try it on a platform where the USB controller is behind an IOMMU...
> > >
> > > It looks like something is more fundamentally wrong here - the device 
> > > passed to DMA API calls must be the actual hardware device performing the 
> > > DMA, which in USB-land I believe means the controller's sysdev.
> > 
> > The shiny new usb_intf_get_dma_device API provides the device to use.
> 
> Thanks Robin and Christoph for the feedback.
> 
> If I understand correctly, usb_intf_get_dma_device API is mainly for usb
> host drivers? I just found usb_gadget_map_request_by_dev API: does it
> make sense to replace usb_gadget_map_request with
> usb_gadget_map_request_by_dev so we can pass the actual DMA-capable
> hardware device (aspeed-vhub platform device) to the API?

Oh, right you're dealing with a gadget side driver.  Not sure about
the API there, I'll let the relevant maintainers chime in.
