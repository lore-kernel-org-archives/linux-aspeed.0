From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 02 Dec 2019 13:29:07 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v3_1/6]_gpio:_treewide_rename_gpio=5Fchip=5Fhwgpio_?=
 =?UTF-8?Q?to_gpiod=5Fto=5Foffset?=
In-Reply-To: <20191129172537.31410-2-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-2-m.felsch@pengutronix.de>
Message-ID: <0ab227da-869a-4533-a361-a825a7e20813@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 30 Nov 2019, at 03:55, Marco Felsch wrote:
> During discussion [1] we decided to rename the gpio subsystem local
> helper so the name is more meaningful for users outside the gpio
> subsystem. Making the helper public is done by a 2nd patch. The
> current users are the gpiolib itself and the aspeed gpio driver.
> The renaming is done by the following command:
> 
>     find ./drivers/gpio -type f -exec sed -i 
> 's/gpio_chip_hwgpio/gpiod_to_offset/g' {} \;
> 
> [1] https://lkml.org/lkml/2019/11/27/357
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> v3:
> - new patch
> 
>  drivers/gpio/gpio-aspeed.c   |  6 ++---

For the aspeed portion:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
