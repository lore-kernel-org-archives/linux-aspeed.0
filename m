From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 14 Feb 2022 12:27:59 -0600
Subject: [PATCH v2 00/10] update Facebook Bletchley BMC
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Message-ID: <Ygqe6lwWUdgv+8ss@patrickw3-mbp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 14, 2022 at 12:25:28PM +0800, Potin Lai wrote:
> This patch series update Facebook Bletchley BMC devicetree base on EVT HW
> schematioc design, and rebase SLED numbering to 1-based for OpenBMC
> multi-host.
> 
> - GPIO:
>   - adding more gpio line names
>   - include interrupt line in io expander for gpio interrupt monitoring
> 
> - SPI flash:
>   - adding dual flash BSM module support
>   - switch to spi2-gpio on spi2 due to unstable signal issue
> 
> - Hwmon Sensors:
>   - adding INA230 sensors for monitoring
>   - fix ADM1278 shunt-resistor
> 
> - MDIO Bus: enable mido3 bus
> 
> - RTC: switch to external battery-backed rtc
> 
> - OpenBMC: 1-based SLED numbering
> 
> 
> LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai at quantatw.com/
> 
> 
> Changes v1 --> v2:
> - update the details of new added gpio line names in commit message
> - add battery-backed rtc information in comment and commit message

Thank you for the details there Potin.

> 
> Potin Lai (10):
>   arch: arm: dts: bletchley: switch sled numbering to 1-based
>   arch: arm: dts: bletchley: separate leds into multiple groups
>   arch: arm: dts: bletchley: update gpio-line-names
>   arch: arm: dts: bletchley: update fmc configurations
>   arch: arm: dts: bletchley: switch to spi-gpio for spi2
>   arch: arm: dts: bletchley: add interrupt support for sled io expander
>   arch: arm: dts: bletchley: add shunt-resistor for ADM1278
>   arch: arm: dts: bletchley: add INA230 sensor on each sled
>   arch: arm: dts: bletchley: enable mdio3 bus
>   arch: arm: dts: bletchley: cleanup redundant nodes
> 
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
>  1 file changed, 194 insertions(+), 109 deletions(-)
> 
> -- 
> 2.17.1
> 

Entire series is

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

-- 
Patrick Williams
