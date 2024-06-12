From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 12 Jun 2024 13:36:52 +0930
Subject: [PATCH] usb: gadget: aspeed_udc: fix device address
 configuration
In-Reply-To: <20240612-aspeed-udc-v1-1-d277b553aecf@codeconstruct.com.au>
References: <20240612-aspeed-udc-v1-1-d277b553aecf@codeconstruct.com.au>
Message-ID: <de1c329751bfc327901c969eafecb7624aaf6a97.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-06-12 at 10:07 +0800, Jeremy Kerr wrote:
> In the aspeed UDC setup, we configure the UDC hardware with the assigned
> USB device address.
> 
> However, we have an off-by-one in the bitmask, so we're only setting the
> lower 6 bits of the address (USB addresses being 7 bits, and the
> hardware bitmask being bits 0:6).
> 
> This means that device enumeration fails if the assigned address is
> greater than 64:
> 
> [  344.607255] usb 1-1: new high-speed USB device number 63 using ehci-platform
> [  344.808459] usb 1-1: New USB device found, idVendor=cc00, idProduct=cc00, bcdDevice= 6.10
> [  344.817684] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  344.825671] usb 1-1: Product: Test device
> [  344.831075] usb 1-1: Manufacturer: Test vendor
> [  344.836335] usb 1-1: SerialNumber: 00
> [  349.917181] usb 1-1: USB disconnect, device number 63
> [  352.036775] usb 1-1: new high-speed USB device number 64 using ehci-platform
> [  352.249432] usb 1-1: device descriptor read/all, error -71
> [  352.696740] usb 1-1: new high-speed USB device number 65 using ehci-platform
> [  352.909431] usb 1-1: device descriptor read/all, error -71
> 
> Use the correct mask of 0x7f (rather than 0x3f), and generate this
> through the GENMASK macro, so we have numbers that correspond exactly
> to the hardware register definition.
> 
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
