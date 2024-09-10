From: Rob Herring (Arm) <robh@kernel.org>
Date: Tue, 10 Sep 2024 09:15:08 -0500
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add power module and
 ADC on Medusa Board
In-Reply-To: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172597760852.3917242.15739474117640537130.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Tue, 10 Sep 2024 15:53:56 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Add RTQ6056 as 2nd source ADC sensor on Medusa Board.
> Add power sensors on Medusa board:
> - Add XDP710 as 2nd source HSC to monitor P48V PSU power.
> - Add MP5023 as P12V efuse (Driver exists but un-documented).
> - Add PMBUS sensors as P12V Delta Module.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240910075357.3531211-1-Delphine_CC_Chiu at wiwynn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 600/power-sensor at 40: failed to match any schema with compatible: ['mps,mp5023']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 600/power-sensor at 62: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 600/power-sensor at 64: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 600/power-sensor at 65: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 600/power-sensor at 68: failed to match any schema with compatible: ['pmbus']





