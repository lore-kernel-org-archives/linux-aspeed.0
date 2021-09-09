From: Lei Yu <yulei.sh@bytedance.com>
Date: Thu, 9 Sep 2021 14:52:17 +0800
Subject: [External] [PATCH v2 0/3] arm: aspeed: Add UART routing support
In-Reply-To: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
Message-ID: <CAGm54UERFkOLXtG3wwL9x1-HAXjmRoaG4ZRbZZOLjP1bLZ=LSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patches are tested on meta-g220a build and it works fine with some
changes in the sysfs path[1].

Tested-by: Lei YU <yulei.sh@bytedance.com>

[1]: https://github.com/openbmc/meta-bytedance/blob/master/meta-g220a/recipes-phosphor/console/obmc-console/obmc-console%40.service#L7-L10

On Thu, Sep 2, 2021 at 10:20 AM Chia-Wei Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> Add UART routing driver and the device tree nodes.
>
> v2:
>  - Add dt-bindings
>  - Add ABI documents for the exported sysfs interface
>  - Revise driver implementation suggested by Joel
>
> Chia-Wei Wang (3):
>   dt-bindings: aspeed-lpc: Add UART routing compatible string
>   soc: aspeed: Add UART routing support
>   ARM: dts: aspeed: Add uart routing to device tree
>
>  .../testing/sysfs-driver-aspeed-uart-routing  |  15 +
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    |  22 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
>  arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
>  drivers/soc/aspeed/Kconfig                    |  10 +
>  drivers/soc/aspeed/Makefile                   |   9 +-
>  drivers/soc/aspeed/aspeed-uart-routing.c      | 601 ++++++++++++++++++
>  7 files changed, 665 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
>  create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c
>
> --
> 2.17.1
>


-- 
BRs,
Lei YU
