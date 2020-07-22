From: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Date: Wed, 22 Jul 2020 15:50:50 -0500
Subject: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD EthanolX
In-Reply-To: <CACPK8XfBPb85uXyYiphD9uEUG6a+acAzEMAsfaenT3t0jqUWNw@mail.gmail.com>
References: <20200720160147.22339-1-supreeth.venkatesh@amd.com>
 <CACPK8XfBPb85uXyYiphD9uEUG6a+acAzEMAsfaenT3t0jqUWNw@mail.gmail.com>
Message-ID: <1671be30-83b3-9468-418f-1dda7881b032@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

On 7/22/20 12:57 AM, Joel Stanley wrote:
> [CAUTION: External Email]
> 
> On Mon, 20 Jul 2020 at 16:02, Supreeth Venkatesh
> <supreeth.venkatesh@amd.com> wrote:
>>
>> Initial introduction of AMD EthanolX platform equipped with an
>> Aspeed ast2500 BMC manufactured by AMD.
>>
>> AMD EthanolX platform is an AMD customer reference board with an
>> Aspeed ast2500 BMC manufactured by AMD.
>> This adds AMD EthanolX device tree file including the flash layout
>> used by EthanolX BMC machines.
>>
>> This also adds an entry of AMD EthanolX device tree file in Makefile.
>>
>> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
Thanks for reviewing it.

> 
> Looks good. One question about the licence.
> 
> 
>> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: Apache-2.0
>> +// Copyright (c) 2020 AMD Inc.
> 
> Can you have a read of the licence rules and add a preferred licence.
> The rules are here:
> 
>  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Flicense-rules.html&amp;data=02%7C01%7Csupreeth.venkatesh%40amd.com%7C24e9c801e7e84cb2dd9008d82e042e60%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637309942787036878&amp;sdata=yHUh9uKH%2BYLpLI%2BPFVTJO%2FdXfQpRtSa2t3Hg5r3MGrI%3D&amp;reserved=0
> 
> This very hacky one liner will give you an idea of common licences
> used by device trees:
> 
> $ git grep -h SPDX -- arch/arm/boot/dts/ | cut -c3- |sort -b | uniq -c
> | sort -hr
>     579  SPDX-License-Identifier: GPL-2.0
>     305  SPDX-License-Identifier: GPL-2.0-only
>     222  SPDX-License-Identifier: GPL-2.0-or-later
>     188  SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>      91  SPDX-License-Identifier: GPL-2.0+
>      72  SPDX-License-Identifier: (GPL-2.0 OR MIT)
>      57  SPDX-License-Identifier: GPL-2.0+ OR MIT
>      46  SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>      38  SPDX-License-Identifier: GPL-2.0 OR X11
>      29  SPDX-License-Identifier: GPL-2.0 OR MIT
>      19  SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>      16  SPDX-License-Identifier: GPL-2.0-only */
>       6  SPDX-License-Identifier: ISC
>       5  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>       4  SPDX-License-Identifier: (GPL-2.0+ OR X11)
>       4  SPDX-License-Identifier: (GPL-2.0 or MIT)
>       4  SPDX-License-Identifier: GPL-2.0 */
>       3  SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>       2  SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */
>       2  SPDX-License-Identifier: GPL-2.0-or-later */
>       2  SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>       2  SPDX-License-Identifier: (GPL-2.0+)
>       2  SPDX-License-Identifier: (GPL-2.0)
>       2 SPDX-License-Identifier: GPL-2.0
>       1  SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>       1  SPDX-License-Identifier:  GPL-2.0+
>       1 SPDX-License-Identifier: GPL-2.0+
>       1   SPDX-License-Identifier: BSD-3-Clause
> 
I will modify in v2 of the patch and send it out.

> 
>> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>> +/dts-v1/;
>> +
>> +#include "aspeed-g5.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +       model = "AMD EthanolX BMC";
>> +       compatible = "amd,ethanolx-bmc", "aspeed,ast2500";
>> +
>> +       memory at 80000000 {
>> +               reg = <0x80000000 0x20000000>;
>> +       };
>> +       aliases {
>> +               serial0 = &uart1;
>> +               serial4 = &uart5;
>> +       };
>> +       chosen {
>> +               stdout-path = &uart5;
>> +               bootargs = "console=ttyS4,115200 earlyprintk";
>> +       };
>> +       leds {
>> +               compatible = "gpio-leds";
>> +
>> +               fault {
>> +                       gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
>> +               };
>> +
>> +               identify {
>> +                       gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
>> +               };
>> +       };
>> +       iio-hwmon {
>> +               compatible = "iio-hwmon";
>> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>;
>> +       };
>> +};
>> +
>> +&fmc {
>> +       status = "okay";
>> +       flash at 0 {
>> +               status = "okay";
>> +               m25p,fast-read;
>> +               #include "openbmc-flash-layout.dtsi"
>> +       };
>> +};
>> +
>> +
>> +&mac0 {
>> +       status = "okay";
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_rmii1_default>;
>> +       clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
>> +                <&syscon ASPEED_CLK_MAC1RCLK>;
>> +       clock-names = "MACCLK", "RCLK";
>> +};
>> +
>> +&uart1 {
>> +       //Host Console
>> +       status = "okay";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_txd1_default
>> +                    &pinctrl_rxd1_default>;
>> +};
>> +
>> +&uart5 {
>> +       //BMC Console
>> +       status = "okay";
>> +};
>> +
>> +&adc {
>> +       status = "okay";
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_adc0_default
>> +                    &pinctrl_adc1_default
>> +                    &pinctrl_adc2_default
>> +                    &pinctrl_adc3_default
>> +                    &pinctrl_adc4_default>;
>> +};
>> +
>> +// Thermal Sensors
>> +&i2c7 {
>> +       status = "okay";
>> +
>> +       lm75a at 48 {
>> +               compatible = "national,lm75a";
>> +               reg = <0x48>;
>> +       };
>> +
>> +       lm75a at 49 {
>> +               compatible = "national,lm75a";
>> +               reg = <0x49>;
>> +       };
>> +
>> +       lm75a at 4a {
>> +               compatible = "national,lm75a";
>> +               reg = <0x4a>;
>> +       };
>> +
>> +       lm75a at 4b {
>> +               compatible = "national,lm75a";
>> +               reg = <0x4b>;
>> +       };
>> +
>> +       lm75a at 4c {
>> +               compatible = "national,lm75a";
>> +               reg = <0x4c>;
>> +       };
>> +
>> +       lm75a at 4d {
>> +               compatible = "national,lm75a";
>> +               reg = <0x4d>;
>> +       };
>> +
>> +       lm75a at 4e {
>> +               compatible = "national,lm75a";
>> +               reg = <0x4e>;
>> +       };
>> +
>> +       lm75a at 4f {
>> +               compatible = "national,lm75a";
>> +               reg = <0x4f>;
>> +       };
>> +};
>> +
>> +&kcs1 {
>> +       status = "okay";
>> +       kcs_addr = <0x60>;
>> +};
>> +
>> +&kcs2 {
>> +       status = "okay";
>> +       kcs_addr = <0x62>;
>> +};
>> +
>> +&kcs4 {
>> +       status = "okay";
>> +       kcs_addr = <0x97DE>;
>> +};
>> +
>> +&lpc_snoop {
>> +       status = "okay";
>> +       snoop-ports = <0x80>;
>> +};
>> +
>> +&lpc_ctrl {
>> +       //Enable lpc clock
>> +       status = "okay";
>> +};
>> +
>> +&pwm_tacho {
>> +       status = "okay";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_pwm0_default
>> +       &pinctrl_pwm1_default
>> +       &pinctrl_pwm2_default
>> +       &pinctrl_pwm3_default
>> +       &pinctrl_pwm4_default
>> +       &pinctrl_pwm5_default
>> +       &pinctrl_pwm6_default
>> +       &pinctrl_pwm7_default>;
>> +
>> +       fan at 0 {
>> +               reg = <0x00>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
>> +       };
>> +
>> +       fan at 1 {
>> +               reg = <0x01>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
>> +       };
>> +
>> +       fan at 2 {
>> +               reg = <0x02>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
>> +       };
>> +
>> +       fan at 3 {
>> +               reg = <0x03>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x03>;
>> +       };
>> +
>> +       fan at 4 {
>> +               reg = <0x04>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x04>;
>> +       };
>> +
>> +       fan at 5 {
>> +               reg = <0x05>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x05>;
>> +       };
>> +
>> +       fan at 6 {
>> +               reg = <0x06>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x06>;
>> +       };
>> +
>> +       fan at 7 {
>> +               reg = <0x07>;
>> +               aspeed,fan-tach-ch = /bits/ 8 <0x07>;
>> +       };
>> +};
>> +
>> +
>> +
>> --
>> 2.17.1
>>
