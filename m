From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Nov 2022 23:55:19 +0000
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
In-Reply-To: <20221108001551.18175-1-zev@bewilderbeest.net>
References: <20221108001551.18175-1-zev@bewilderbeest.net>
Message-ID: <CACPK8XeKA+rFwOGCZam2XZh9v8OndyZeE2sk4-3nb-rKdNeDBA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 8 Nov 2022 at 00:16, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hello,
>
> This series adds a device-tree for the BMCs of the Delta AHE-50DC
> Open19 power shelf.  The first patch adds a compat entry to the Aspeed
> bindings; the second adds the device-tree itself.
>
> Changes since v1 [0]:
>  - rearranged patch 2 with macros to reduce boilerplate
>  - added ack from Krzysztof on patch 1

Looks good to me, I've put it in the aspeed tree for 6.2.

>
> Thanks,
> Zev
>
> [0] https://lore.kernel.org/lkml/20221105013321.2719-1-zev at bewilderbeest.net/T/
>
> Zev Weiss (2):
>   dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
>   ARM: dts: aspeed: Add Delta AHE-50DC BMC
>
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 418 ++++++++++++++++++
>  3 files changed, 420 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
>
> --
> 2.38.1
>
