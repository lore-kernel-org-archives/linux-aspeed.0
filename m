From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 24 May 2024 09:31:10 +0930
Subject: [PATCH v8 00/23] Add i2c-mux and eeprom devices for Meta
 Yosemite 4
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <6cf99700841ac27c74821e92b5d7d9fe778b9e67.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There's still no response to my comments (either replies or adjustments
to the patches) on v5, and we're now at v8.

Upstreaming the patches won't progress if you don't engage with the
feedback.

Andrew

On Thu, 2024-05-23 at 17:17 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v8
>     - add fan led config
>   - v7
>     - Revise pca9506 i2c address
>   - v6
>     - Revise i2c duty-cycle for meeting 400khz spec
>   - v5
>     - Support medusa board adc sensors
>     - support NIC eeprom
>   - v4
>     - Re-format gpio linename
>     - Revise i2c device node names
>     - Split patches by logic changes
>   - v3
>     - Correct patch for revising gpio name
>   - v2
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
>   - v1
>     - Add gpio and eeprom behind i2c-mux
>     - Remove redundant idle-state setting for i2c-mux
>     - Enable adc 15, wdt2,spi gpio for yosemite4 use
>     - Revise quad mode to dual mode to avoid WP pin influnece the SPI
>     - Revise power sensor adm1281 for yosemite4 schematic change
>     - Add gpio pca9506 I/O expander for yosemite4 use
>     - remove space for adm1272 compatible
>     - enable interrupt setting for pca9555
>     - add eeprom for yosemite4 medusa board/BSM use
>     - remove temperature sensor for yosemite4 schematic change
>     - add power sensor for power module reading
>     - Revise adc128d818 adc mode for yosemite4 schematic change
>     - Revise ina233 for yosemite4 schematic change
>     - Remove idle state setting for yosemite4 NIC connection
>     - Initialize bmc gpio state
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
> 
> Delphine CC Chiu (23):
>   ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
>   ARM: dts: aspeed: yosemite4: Enable adc15
>   ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
>   ARM: dts: aspeed: yosemite4: Enable watchdog2
>   ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
>   ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
>     change
>   ARM: dts: aspeed: yosemite4: Add gpio pca9506
>   ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
>   ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
>   ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
>   ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
>   ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4
>     schematic change
>   ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4
>     schematic change
>   ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4
>     schematic change
>   ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4
>     NIC connection
>   ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
>   ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
>   ARM: dts: aspeed: yosemite4: add mctp config for NIC
>   ARM: dts: aspeed: yosemite4: support mux to cpld
>   ARM: dts: aspeed: yosemite4: support medusa board adc sensors
>   ARM: dts: aspeed: yosemite4: support NIC eeprom
>   ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
>   ARM: dts: aspeed: yosemite4: add fan led config
> 
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1410 +++++++++++++++--
>  1 file changed, 1301 insertions(+), 109 deletions(-)
> 

