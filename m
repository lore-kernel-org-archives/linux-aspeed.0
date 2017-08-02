From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:38:03 +0200
Subject: [PATCH v2 3/4] pinctrl: aspeed: g4: Add USB device and host
 support
In-Reply-To: <20170718052453.14316-4-andrew@aj.id.au>
References: <20170718052453.14316-1-andrew@aj.id.au>
 <20170718052453.14316-4-andrew@aj.id.au>
Message-ID: <CACRpkdZxx3-1XyZhnZoxaRtOvDgZP9_as8ceoz0_M9KvW-AoKg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 18, 2017 at 7:24 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> Implement the AST2400 USB functions as described by the devicetree
> bindings. Three ports are fully documented in the datasheet and exposed
> through the bindings and pinctrl, though there are remnants of
> documentation for a fourth port muxed with GPIO pins GPIOQ6 and GPIOQ7.
> The implementation is updated to reflect this but the function and
> group are not exposed.
>
> Disregarding the mostly undocumented fourth port, the USB functions are
> an outlier with respect to the rest of the muxed functionality on the
> AST2400 as GPIO is not supported on these pins.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied.

Yours,
Linus Walleij
