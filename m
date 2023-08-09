From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Aug 2023 08:12:45 +0000
Subject: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite 4 BMC
In-Reply-To: <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com> <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
Message-ID: <CACPK8XfwcsnrrF9YJ7y-sLRx1OWfrvhNi2G3Tbhww_dXfSOUXw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 at 08:05, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 8 Aug 2023 at 08:43, Delphine CC Chiu
> <Delphine_CC_Chiu@wiwynn.com> wrote:
> >
> > Add linux device tree entry related to
> > Yosemite 4 specific devices connected to BMC SoC.

There were also some of these annoying warnings. Please try to fix
them up in your next version:

../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:460.4-14:
Warning (reg_format):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 0:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:510.4-14:
Warning (reg_format):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 1:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:567.4-14:
Warning (reg_format):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 73/i2c at 0:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:578.4-14:
Warning (reg_format):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 73/i2c at 1:reg: property has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: Warning
(spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:457.9-505.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 0: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:457.9-505.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 0: Relying on default
#size-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:507.9-555.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 1: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:507.9-555.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 71/i2c at 1: Relying on default
#size-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:564.9-573.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 73/i2c at 0: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:564.9-573.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 73/i2c at 0: Relying on default
#size-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:575.9-584.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 73/i2c at 1: Relying on default
#address-cells value
../arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:575.9-584.5:
Warning (avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 780/i2c-mux at 73/i2c at 1: Relying on default
#size-cells value
