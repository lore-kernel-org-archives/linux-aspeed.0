From: Potin Lai <potin.lai@quantatw.com>
Date: Wed, 16 Feb 2022 00:31:41 +0800
Subject: [PATCH v3 00/10] update Facebook Bletchley BMC
Message-ID: <20220215163151.32252-1-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series update Facebook Bletchley BMC devicetree base on EVT HW
schematioc design, and rebase SLED numbering to 1-based for OpenBMC
multi-host.

- GPIO:
  - adding more gpio line names
  - include interrupt line in io expander for gpio interrupt monitoring

- SPI flash:
  - adding dual flash BSM module support
  - switch to spi2-gpio on spi2 due to unstable signal issue

- Hwmon Sensors:
  - adding INA230 sensors for monitoring
  - fix ADM1278 shunt-resistor

- MDIO Bus: enable mido3 bus

- RTC: switch to external battery-backed rtc

- OpenBMC: 1-based SLED numbering


LINK: [v2] https://lore.kernel.org/all/20220214042538.12132-1-potin.lai at quantatw.com/
LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai at quantatw.com/


Changes v2 --> v3:
- update patch name prefix
- Disable spi2, and create a new node call spi2_gpio

Changes v1 --> v2:
- update the details of new added gpio line names in commit message
- add battery-backed rtc information in comment and commit message


Potin Lai (10):
  ARM: dts: aspeed: bletchley: switch sled numbering to 1-based
  ARM: dts: aspeed: bletchley: separate leds into multiple groups
  ARM: dts: aspeed: bletchley: update gpio-line-names
  ARM: dts: aspeed: bletchley: update fmc configurations
  ARM: dts: aspeed: bletchley: switch to spi-gpio for spi2
  ARM: dts: aspeed: bletchley: add interrupt support for sled io
    expander
  ARM: dts: aspeed: bletchley: add shunt-resistor for ADM1278
  ARM: dts: aspeed: bletchley: add INA230 sensor on each sled
  ARM: dts: aspeed: bletchley: enable mdio3 bus
  ARM: dts: aspeed: bletchley: cleanup redundant nodes

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 320 +++++++++++-------
 1 file changed, 202 insertions(+), 118 deletions(-)

-- 
2.17.1

