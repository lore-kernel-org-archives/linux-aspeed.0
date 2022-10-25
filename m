From: Lei Yu <yulei.sh@bytedance.com>
Date: Tue, 25 Oct 2022 14:21:47 +0800
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <661b43881b7f8764919847f29c0daf1866441090.camel@kernel.crashing.org>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com> <661b43881b7f8764919847f29c0daf1866441090.camel@kernel.crashing.org>
Message-ID: <CAGm54UE1oS1N_hn4RKuF8a+OWgfvJ-OCc0-uju4mXbtz-jw8VA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 25, 2022 at 6:00 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Mon, 2022-10-24 at 09:48 +0000, Lei YU wrote:
> > From: Henry Tian <tianxiaofeng@bytedance.com>
>
> I wrote that driver, please CC me on further patches to it (thanks Joel
> for the heads up).
>
> > In ast_vhub_epn_handle_ack() when the received data length exceeds the
> > buffer, it does not check the case and just copies to req.buf and cause
> > a buffer overflow, kernel oops on this case.
>
>  .../...
>
> Thanks ! Seems like a legit bug, however:
>
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > index b5252880b389..56e55472daa1 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > @@ -84,6 +84,7 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
> >  {
> >         struct ast_vhub_req *req;
> >         unsigned int len;
> > +       int status = 0;
> >         u32 stat;
> >
> >         /* Read EP status */
> > @@ -119,9 +120,15 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
> >         len = VHUB_EP_DMA_TX_SIZE(stat);
> >
> >         /* If not using DMA, copy data out if needed */
> > -       if (!req->req.dma && !ep->epn.is_in && len)
> > -               memcpy(req->req.buf + req->req.actual, ep->buf, len);
> > -
> > +       if (!req->req.dma && !ep->epn.is_in && len) {
> > +               if (req->req.actual + len > req->req.length) {
> > +                       req->last_desc = 1;
> > +                       status = -EOVERFLOW;
> > +                       goto done;
>
> Should we stall as well ? Should we continue receiving and just dropping the data until we have
> a small packet ? Otherwise the EP could get out of sync for subsequent ones...
>

This case is treated as an error and we do not care about the following data.
Similarly, if we change the MTU in BMC and let BMC ping the OS, the OS
kernel does not crash and it gets RX errors, and the ping fails.

 # ifconfig usb0
 usb0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         ...
         RX packets 85  bytes 15380 (15.0 KiB)
         RX errors 51  dropped 0  overruns 0  frame 51

With this patch, we get the similar behavior on BMC that the RX errors
are increasing.

> Additionally, I'm curious, why in this specific case is the device sending more data than
> the buffer can hold ? The MTU change should have resulted in buffers being re-allocated no ?

The issue is found in a rare case during BIOS boot, we assume that
BIOS is sending unexpected data to BMC for unknown reasons.

> Or did you change the MTU on the remote and not on the local device ?
>

Yes, the MTU is changed to 2000 in OS and kept 1500 on BMC, then the
issue is reproduced. (see detailed steps in the above email).

The reason we made the above test is because we are trying to
reproduce the behavior as BIOS, and from the logs it looks like it's
sending a packet larger than MTU. Then we tried to adjust the MTU on
the OS side and reproduced the issue.
