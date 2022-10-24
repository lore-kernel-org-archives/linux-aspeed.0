From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 25 Oct 2022 08:59:17 +1100
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <20221024094853.2877441-1-yulei.sh@bytedance.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
Message-ID: <661b43881b7f8764919847f29c0daf1866441090.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2022-10-24 at 09:48 +0000, Lei YU wrote:
> From: Henry Tian <tianxiaofeng@bytedance.com>

I wrote that driver, please CC me on further patches to it (thanks Joel
for the heads up).

> In ast_vhub_epn_handle_ack() when the received data length exceeds the
> buffer, it does not check the case and just copies to req.buf and cause
> a buffer overflow, kernel oops on this case.

 .../...

Thanks ! Seems like a legit bug, however:

> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index b5252880b389..56e55472daa1 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -84,6 +84,7 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
> ?{
> ????????struct ast_vhub_req *req;
> ????????unsigned int len;
> +???????int status = 0;
> ????????u32 stat;
> ?
> ????????/* Read EP status */
> @@ -119,9 +120,15 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
> ????????len = VHUB_EP_DMA_TX_SIZE(stat);
> ?
> ????????/* If not using DMA, copy data out if needed */
> -???????if (!req->req.dma && !ep->epn.is_in && len)
> -???????????????memcpy(req->req.buf + req->req.actual, ep->buf, len);
> -
> +???????if (!req->req.dma && !ep->epn.is_in && len) {
> +???????????????if (req->req.actual + len > req->req.length) {
> +???????????????????????req->last_desc = 1;
> +???????????????????????status = -EOVERFLOW;
> +???????????????????????goto done;

Should we stall as well ? Should we continue receiving and just dropping the data until we have
a small packet ? Otherwise the EP could get out of sync for subsequent ones...

Additionally, I'm curious, why in this specific case is the device sending more data than
the buffer can hold ? The MTU change should have resulted in buffers being re-allocated no ?
Or did you change the MTU on the remote and not on the local device ?

Cheers,
Ben.
