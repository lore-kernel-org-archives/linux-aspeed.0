From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Jul 2019 23:36:18 +0200
Subject: [PATCH -next] pinctrl: aspeed: Make aspeed_pinmux_ips static
In-Reply-To: <20190711142457.37028-1-yuehaibing@huawei.com>
References: <20190711142457.37028-1-yuehaibing@huawei.com>
Message-ID: <CACRpkdbBWPN8px=5gxeXWifDz5gCdbqWvgk6ZPdXS6Pa_hKO0g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 11, 2019 at 4:25 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Fix sparse warning:
>
> drivers/pinctrl/aspeed/pinmux-aspeed.c:8:12: warning:
>  symbol 'aspeed_pinmux_ips' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Andrew's ACK.

Yours,
Linus Walleij
