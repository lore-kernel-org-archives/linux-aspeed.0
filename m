From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 28 Mar 2022 12:47:46 +0200
Subject: [RFC PATCH 1/1] ARM/arm64: categorize dts in arm dir and fix
 dependency in arm64
In-Reply-To: <20220328000915.15041-2-ansuelsmth@gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <20220328000915.15041-2-ansuelsmth@gmail.com>
Message-ID: <c5eeca79-38b6-eb9f-1d78-1685aa1cca6c@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 28/03/2022 02:09, Ansuel Smith wrote:
> - Categorize every dts in arm directory in subdirectory
> - Fix Makefile to address for the arm subdirectory
> - Fix any arm64 dependency
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
[...]
>   arch/arm/boot/dts/mediatek/Makefile           |   14 +
>   .../boot/dts/{ => mediatek}/mt2701-evb.dts    |    0
>   .../boot/dts/{ => mediatek}/mt2701-pinfunc.h  |    0
>   arch/arm/boot/dts/{ => mediatek}/mt2701.dtsi  |    0
>   arch/arm/boot/dts/{ => mediatek}/mt6323.dtsi  |    0
>   .../boot/dts/{ => mediatek}/mt6580-evbp1.dts  |    0
>   arch/arm/boot/dts/{ => mediatek}/mt6580.dtsi  |    0
>   .../mt6582-prestigio-pmt5008-3g.dts           |    0
>   arch/arm/boot/dts/{ => mediatek}/mt6582.dtsi  |    0
>   .../dts/{ => mediatek}/mt6589-aquaris5.dts    |    0
>   .../{ => mediatek}/mt6589-fairphone-fp1.dts   |    0
>   arch/arm/boot/dts/{ => mediatek}/mt6589.dtsi  |    0
>   .../boot/dts/{ => mediatek}/mt6592-evb.dts    |    0
>   arch/arm/boot/dts/{ => mediatek}/mt6592.dtsi  |    0
>   arch/arm/boot/dts/{ => mediatek}/mt7623.dtsi  |    0
>   .../dts/{ => mediatek}/mt7623a-rfb-emmc.dts   |    0
>   .../dts/{ => mediatek}/mt7623a-rfb-nand.dts   |    0
>   arch/arm/boot/dts/{ => mediatek}/mt7623a.dtsi |    0
>   .../mt7623n-bananapi-bpi-r2.dts               |    0
>   .../dts/{ => mediatek}/mt7623n-rfb-emmc.dts   |    0
>   arch/arm/boot/dts/{ => mediatek}/mt7623n.dtsi |    0
>   .../boot/dts/{ => mediatek}/mt7629-rfb.dts    |    0
>   arch/arm/boot/dts/{ => mediatek}/mt7629.dtsi  |    0
>   .../boot/dts/{ => mediatek}/mt8127-moose.dts  |    0
>   arch/arm/boot/dts/{ => mediatek}/mt8127.dtsi  |    0
>   .../boot/dts/{ => mediatek}/mt8135-evbp1.dts  |    0
>   arch/arm/boot/dts/{ => mediatek}/mt8135.dtsi  |    0

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Would it be possible to also script a fix for the MAINTAINERS file?

$ git grep "arch\/arm\/boot\/dts" MAINTAINERS |wc -l

101


Regards,
Matthias
