From: Felipe Balbi <balbi@kernel.org>
Date: Wed, 30 May 2018 15:29:31 +0300
Subject: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
In-Reply-To: <20180525160729.92026-1-arnd@arndb.de>
References: <20180525160729.92026-1-arnd@arndb.de>
Message-ID: <87o9gxcono.fsf@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> Without that option, we run into a link failure:
>
> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
>
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180530/7fc655b2/attachment.sig>
