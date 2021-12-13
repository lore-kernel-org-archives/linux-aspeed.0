From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 13 Dec 2021 15:01:33 +0100
Subject: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
In-Reply-To: <20211208100545.1441397-3-neal_liu@aspeedtech.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <20211208100545.1441397-3-neal_liu@aspeedtech.com>
Message-ID: <YbdSPWX2pnp5pT9G@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 08, 2021 at 06:05:43PM +0800, Neal Liu wrote:
> Signaling remote wakeup if an emulated USB device has any activity
> if the device is allowed by host.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 +++++
>  1 file changed, 5 insertions(+)

What commit does this fix?

Does it need to go to stable kernels?

Should it be independent of this patch series that adds new features?

thanks,

greg k-h
