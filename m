From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2017 09:18:26 +0200
Subject: [RFC PATCH 2/5] gpio: gpiolib: Add OF support for maintaining
 GPIO values on reset
In-Reply-To: <20171020033727.21557-3-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-3-andrew@aj.id.au>
Message-ID: <CACRpkdbxOen3ohwmDc8ZNWkirn3mNHaGiZq1O-6VnOjhvFcw+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> @@ -32,6 +32,7 @@ enum of_gpio_flags {
>         OF_GPIO_SINGLE_ENDED = 0x2,
>         OF_GPIO_OPEN_DRAIN = 0x4,
>         OF_GPIO_SLEEP_MAY_LOSE_VALUE = 0x8,
> +       OF_GPIO_RESET_TOLERANT = 0x16,

Now you're mixing up decimal and hex.

Anyways, I do not think this is necessary.

Yours,
Linus Walleij
