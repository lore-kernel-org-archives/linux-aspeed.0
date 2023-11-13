From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Nov 2023 11:15:31 +0100
Subject: [PATCH 03/52] serial: 8250: Convert to platform remove callback
 returning void
In-Reply-To: <20231110152927.70601-4-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de> <20231110152927.70601-4-u.kleine-koenig@pengutronix.de>
Message-ID: <CAMuHMdU8nCWzTuBeSTPkR=heWqdAYrhAJ9ZgydzWNRqkTuT+xg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 10, 2023 at 4:31?PM Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

>  drivers/tty/serial/8250/8250_dw.c           | 6 ++----
>  drivers/tty/serial/8250/8250_em.c           | 5 ++---

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
