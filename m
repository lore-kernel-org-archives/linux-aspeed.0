From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 02 Dec 2019 13:30:04 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v3_2/6]_gpio:_make_gpiod=5Fto=5Foffset()_available_?=
 =?UTF-8?Q?for_other_users?=
In-Reply-To: <20191129172537.31410-3-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-3-m.felsch@pengutronix.de>
Message-ID: <23d79dff-6577-4fba-b7e6-d494ec7b8a93@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 30 Nov 2019, at 03:55, Marco Felsch wrote:
> Currently gpiod_to_offset() is a gpio-subsystem private function which
> is used by the gpiolib itself and by the aspeed gpio driver. The time
> has shown that there are other drivers as well which need this
> information in some special cases e.g. MFD drivers. The patch makes the
> function public but you need to explicit add the <linux/gpio/private.h>
> include. See discussion [1] for more information.
> 
> [1] https://lkml.org/lkml/2019/11/27/357
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v3:
> - former patch description was "gpio: add support to get local gpio number"
> - adapt commit message and description to reflect new state
> - don't add wrapper instead use the already existing gpiod_to_offset
> - move gpiod_to_offset from gpiolib.h into gpiolib.c
> - move declaration into linux/gpio/private.h
> ---
>  drivers/gpio/gpio-aspeed.c   | 11 +++++------

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
