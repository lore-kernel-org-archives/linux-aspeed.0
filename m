From: Patrick Venture <venture@google.com>
Date: Tue, 18 Jan 2022 08:32:53 -0800
Subject: [PATCH] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
In-Reply-To: <20220114064357.18562-1-linmq006@gmail.com>
References: <20220114064357.18562-1-linmq006@gmail.com>
Message-ID: <CAO=notwdkeJRyc0qQROV=Jsmgj2UrPGQkKii9Hu8bYv7oQLSpQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 13, 2022 at 10:44 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>

Signed-off-by: Patrick Venture <venture@google.com>


> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index eceeaf8dfbeb..c4a03b3a5cf8 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -167,8 +167,8 @@ static int aspeed_lpc_snoop_config_irq(struct
> aspeed_lpc_snoop *lpc_snoop,
>         int rc;
>
>         lpc_snoop->irq = platform_get_irq(pdev, 0);
> -       if (!lpc_snoop->irq)
> -               return -ENODEV;
> +       if (lpc_snoop->irq < 0)
> +               return lpc_snoop->irq;
>
>         rc = devm_request_irq(dev, lpc_snoop->irq,
>                               aspeed_lpc_snoop_irq, IRQF_SHARED,
> --
> 2.17.1
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220118/9f65135f/attachment-0001.htm>
