From: Joel Stanley <joel@jms.id.au>
Date: Thu, 1 Apr 2021 04:15:44 +0000
Subject: [PATCH v2 2/3] drivers/tty/serial/8250: add DT property for
 aspeed vuart sirq polarity
In-Reply-To: <20210401005702.28271-3-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-3-zev@bewilderbeest.net>
Message-ID: <CACPK8XdPVf1WMmo8C8RJtd-1cH5qV9odEDhDUHWRiMOk=dQNtg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 1 Apr 2021 at 00:57, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This provides a simple boolean to use instead of the deprecated
> aspeed,sirq-polarity-sense property.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index c33e02cbde93..e5ef9f957f9a 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -482,6 +482,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>                 of_node_put(sirq_polarity_sense_args.np);
>         }
>
> +       if (of_property_read_bool(np, "aspeed,sirq-active-high"))
> +               aspeed_vuart_set_sirq_polarity(vuart, 1);

This assumes the default is always low, so we don't need a property to
set it to that state?

Would it make more sense to have the property describe if it's high or
low? (I'm happy for the answer to be "no", as we've gotten by for the
past few years without it).

This brings up another point. We already have the sysfs file for
setting the lpc address, from userspace. In OpenBMC land this can be
set with obmc-console-client (/etc/obmc-console.conf). Should we add
support to that application for setting the irq polarity too, and do
away with device tree descriptions?

> +
>         aspeed_vuart_set_enabled(vuart, true);
>         aspeed_vuart_set_host_tx_discard(vuart, true);
>         platform_set_drvdata(pdev, vuart);
> --
> 2.31.1
>
