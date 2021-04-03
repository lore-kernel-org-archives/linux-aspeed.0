From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Apr 2021 10:40:05 +0300
Subject: [PATCH v4 0/4] aspeed-vuart: generalized DT properties
In-Reply-To: <20210402182724.20848-1-zev@bewilderbeest.net>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
Message-ID: <CAHp75VfbPZ1Xh6_DdRYe=W1KRWg4ZDECDmH-Qeikbymr0hKY2g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Friday, April 2, 2021, Zev Weiss <zev@bewilderbeest.net> wrote:

> This series generalizes the aspeed-vuart driver's device tree
> properties to cover all the attributes it currently exposes via sysfs.
>
> The aspeed,sirq-polarity-sense property was a bit of a design mistake
> in that it ties Aspeed VUART SIRQ polarity to SCU register bits that
> aren't really inherently related to it; the first patch in this series
> deprecates it (though we hope to eventually remove it).
>
> The rest of the series adds two new properties, aspeed,lpc-io-reg and
> aspeed,lpc-interrupts.  The latter allows describing the SIRQ polarity
> (along with the interrupt number) directly, providing a simpler
> replacement for aspeed,sirq-polarity-sense.
>
>
>
Please, use better prefixes in the patches to avoid confusion, I.e.

?serial: 8250_aspeed_vuart: ?

Instead of what you have now.


> Changes since v3 [2]:
>  - renamed properties to match aspeed,ast2400-kcs-bmc
>
> Changes since v2 [0]:
>  - expanded to also handle sirq number and lpc address in addition to
>    sirq polarity
>  - added default settings if DT properties not specified
>  - refactored existing sysfs code slightly, adding range checks
>  - cleaned up 'make dt_binding_check' warnings
>
> Changes since v1 [1]:
>  - deprecate and retain aspeed,sirq-polarity-sense instead of removing it
>  - drop e3c246d4i dts addition from this series
>
>
> [0] https://lore.kernel.org/openbmc/20210401005702.28271-
> 1-zev at bewilderbeest.net/
> [1] https://lore.kernel.org/openbmc/20210330002338.335-1-
> zev at bewilderbeest.net/
> [2] https://lore.kernel.org/openbmc/20210402004716.15961-
> 1-zev at bewilderbeest.net/
>
>
> Zev Weiss (4):
>   dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
>   drivers/tty/serial/8250: refactor sirq and lpc address setting code
>   drivers/tty/serial/8250: add aspeed,lpc-io-reg and
>     aspeed,lpc-interrupts DT properties
>   dt-bindings: serial: 8250: add aspeed,lpc-io-reg and
>     aspeed,lpc-interrupts
>
>  .../devicetree/bindings/serial/8250.yaml      | 28 +++++-
>  drivers/tty/serial/8250/8250_aspeed_vuart.c   | 95 +++++++++++++++----
>  2 files changed, 103 insertions(+), 20 deletions(-)
>
> --
> 2.31.1
>
>

-- 
With Best Regards,
Andy Shevchenko
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210403/3ed43506/attachment.htm>
