From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Aug 2021 15:30:13 +0200
Subject: [PATCH] pinctrl: aspeed: placate kernel-doc warnings
In-Reply-To: <20210723034840.8752-1-rdunlap@infradead.org>
References: <20210723034840.8752-1-rdunlap@infradead.org>
Message-ID: <CACRpkdaXWhKNdmWSsoYZnZi_umfvSv7mZvg1JgkG=-k0JGoUTw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 23, 2021 at 5:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> Eliminate kernel-doc warnings in drivers/pinctrl/aspeed by using
> proper kernel-doc notation.
>
> Fixes these kernel-doc warnings:
>
> drivers/pinctrl/aspeed/pinmux-aspeed.c:61: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Query the enabled or disabled state for a mux function's signal on a pin
> drivers/pinctrl/aspeed/pinctrl-aspeed.c:135: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Search for the signal expression needed to enable the pin's signal for the
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: linux-aspeed at lists.ozlabs.org
> Cc: openbmc at lists.ozlabs.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio at vger.kernel.org

Patch applied.

Yours,
Linus Walleij
