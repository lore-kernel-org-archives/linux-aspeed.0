From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Oct 2017 09:29:27 +0200
Subject: [RFC PATCH 4/5] gpio: gpiolib: Add sysfs support for maintaining
 GPIO values on reset
In-Reply-To: <20171020033727.21557-5-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
 <20171020033727.21557-5-andrew@aj.id.au>
Message-ID: <CACRpkdZ9HpXXuauRtVjA9n1dwF3sUQ4gJL-FOUMcMBDCL9oxYw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 20, 2017 at 5:37 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> Expose a new 'maintain' sysfs attribute to control both suspend and
> reset tolerance.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

NAK. You will find the actual ABI documentation in
Documentation/ABI/obsolete/sysfs-gpio
that's why. This is being phased out and should not be extended.
Everyone should use the character device, especially for new
functionality.

Yours,
Linus Walleij
