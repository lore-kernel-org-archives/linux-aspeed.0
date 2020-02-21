From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 20 Feb 2020 16:27:16 -0800
Subject: [PATCH v3 0/5] aspeed-g6: enable usb support
In-Reply-To: <20200218031315.562-1-rentao.bupt@gmail.com>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
Message-ID: <20200221002715.GC7815@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

Could you provide some comments on this patch series while I'm working on
the other patch set (for vhub descriptors and DT binding document)?


Cheers,

Tao

On Mon, Feb 17, 2020 at 07:13:10PM -0800, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series aims at enabling USB Host and Gadget support on AST2600
> platforms.
> 
> Patch #1 replaces hardcoded vhub port/endpoint number with device tree
> properties, so that it's more convenient to add support for ast2600-vhub
> which provides more downstream ports and endpoints.
> 
> Patch #2 enables ast2600 support in aspeed-vhub usb gadget driver.
> 
> Patch #3 adds USB devices and according pin groups in aspeed-g6 dtsi.
> 
> Patch #4 and #5 add vhub port/endpoint properties into aspeed-g4 and
> aspeed-g5 dtsi.
> 
> Tao Ren (5):
>   usb: gadget: aspeed: read vhub properties from device tree
>   usb: gadget: aspeed: add ast2600 vhub support
>   ARM: dts: aspeed-g6: add usb functions
>   ARM: dts: aspeed-g5: add vhub port and endpoint properties
>   ARM: dts: aspeed-g4: add vhub port and endpoint properties
> 
>  arch/arm/boot/dts/aspeed-g4.dtsi           |  2 +
>  arch/arm/boot/dts/aspeed-g5.dtsi           |  2 +
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 25 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi           | 45 ++++++++++++
>  drivers/usb/gadget/udc/aspeed-vhub/Kconfig |  4 +-
>  drivers/usb/gadget/udc/aspeed-vhub/core.c  | 79 +++++++++++++++-------
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c   | 30 +++++---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c   |  4 +-
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c   | 26 ++++---
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h  | 23 +++----
>  10 files changed, 178 insertions(+), 62 deletions(-)
> 
> -- 
> 2.17.1
> 
