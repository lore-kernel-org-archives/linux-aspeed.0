From: Joel Stanley <joel@jms.id.au>
Date: Mon, 11 Jan 2021 02:24:27 +0000
Subject: [PATCH 1/1] usb: gadget: aspeed: fix stop dma register setting.
In-Reply-To: <20210108081238.10199-2-ryan_chen@aspeedtech.com>
References: <20210108081238.10199-1-ryan_chen@aspeedtech.com>
 <20210108081238.10199-2-ryan_chen@aspeedtech.com>
Message-ID: <CACPK8XdWKY4QmuojaZ13tmKR3MVEzU8MOV=bmqyTiotScaGfRA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 8 Jan 2021 at 08:13, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> The vhub engine has two dma mode, one is descriptor list, another
> is single stage DMA. Each mode has different stop register setting.
> Descriptor list operation (bit2) : 0 disable reset, 1: enable reset
> Single mode operation (bit0) : 0 : disable, 1: enable
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 0bd6b20435b8..02d8bfae58fb 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -420,7 +420,10 @@ static void ast_vhub_stop_active_req(struct ast_vhub_ep *ep,
>         u32 state, reg, loops;
>
>         /* Stop DMA activity */
> -       writel(0, ep->epn.regs + AST_VHUB_EP_DMA_CTLSTAT);
> +       if (ep->epn.desc_mode)
> +               writel(VHUB_EP_DMA_CTRL_RESET, ep->epn.regs + AST_VHUB_EP_DMA_CTLSTAT);
> +       else
> +               writel(0, ep->epn.regs + AST_VHUB_EP_DMA_CTLSTAT);

This looks correct, as whenever the driver re-enables DMA it uses
ep->epn.dma_conf for the value of this register. So we're not losing
any configuration by setting it to 0.

Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")

I've cc'd Ben for his ack too.

Cheers,

Joel

>
>         /* Wait for it to complete */
>         for (loops = 0; loops < 1000; loops++) {
> --
> 2.17.1
>
