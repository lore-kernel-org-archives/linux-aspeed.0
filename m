From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Aug 2024 11:36:54 -0600
Subject: [PATCH v1 0/1] ARM: dts: aspeed: system1: IBM System1 BMC update
In-Reply-To: <4d5b8958-2d33-42df-ac97-82bb63fdff38@linux.ibm.com>
References: <20240731214737.986010-1-ninad@linux.ibm.com> <172252600790.120672.12772438670145461296.robh@kernel.org>
 <4d5b8958-2d33-42df-ac97-82bb63fdff38@linux.ibm.com>
Message-ID: <CAL_JsqLd8Xcj7gD=WKrt8ygYHb3jNpvxof5yFAPPydiRCPv0eQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 1, 2024 at 10:25?AM Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> Hi Rob,
>
> On 8/1/24 10:29, Rob Herring (Arm) wrote:
> > On Wed, 31 Jul 2024 16:47:28 -0500, Ninad Palsule wrote:
> >> Hello,
> >>
> >> This patch only applies to openbmc/linux. The max31785 pmbus driver
> >> changes are not available in the upstream yet. I will try to send those
> >> changes upstream.
> >>
> >> Ninad Palsule (1):
> >>    ARM: dts: aspeed: system1: IBM System1 BMC update
> >>
> >>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 96 +++++++++++++++++++
> >>   1 file changed, 96 insertions(+)
> >>
> >> --
> >> 2.43.0
> >>
> >>
> >>
> >
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> >
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> >
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >
> >    pip3 install dtschema --upgrade
> >
> >
> > New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20240731214737.986010-1-ninad at linux.ibm.com:
> >
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 0: failed to match any schema with compatible: ['pmbus-fan']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 1: failed to match any schema with compatible: ['pmbus-fan']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 2: failed to match any schema with compatible: ['pmbus-fan']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 3: failed to match any schema with compatible: ['pmbus-fan']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 4: failed to match any schema with compatible: ['pmbus-fan']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 54/fan at 0: failed to match any schema with compatible: ['pmbus-fan']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 54/fan at 1: failed to match any schema with compatible: ['pmbus-fan']
> >
> I have seen these warning. I am not sure how to fix them as it is
> already documented in the following file.
>
> Documentation/devicetree/bindings/hwmon/pmbus/max31785.txt

$ git log -- Documentation/devicetree/bindings/hwmon/pmbus/max31785.txt
(END)

Did you mean Documentation/devicetree/bindings/hwmon/max31785.txt? If
so, there is no 'pmbus-fan' in it or anywhere else except aspeed dts
files.

The state of the aspeed dts files is really quite sad. This is a count
of warnings. The first number is total warnings. The second number is
unique warnings (stripping the dtb name so we don't have N warnings
for N boards). The 2nd list is undocumented (by schema) compatibles.

The number of warnings vs. Linus's tree is higher already and we just
started the cycle. That's the wrong direction and in general I see
very little if any effort reducing the warnings for aspeed.

This is all run daily here: https://gitlab.com/robherring/linux-dt/-/jobs

arch/arm/boot/dts/aspeed:3682:635
    184  sbefifo at 2400: '#address-cells', '#size-cells' do not match
any of the regexes: 'pinctrl-[0-9]+'
    160  i2cr at 20: #address-cells: 1 was expected
     88  eeprom at 0: 'size' is a required property
     88  eeprom at 0: 'pagesize' is a required property
     88  eeprom at 0: 'address-width' is a required property
     70  lpc at 1e789000: reg-io-width: 4 is not of type 'object'
     62  kcs at 2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
     62  kcs at 28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
     62  kcs at 24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
     62  kcs at 114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
     45  sram at 1e720000: 'ranges' is a required property
     45  sram at 1e720000: '#size-cells' is a required property
     45  sram at 1e720000: '#address-cells' is a required property
     45  lpc at 1e789000: lpc-snoop at 90: 'clocks' does not match any of
the regexes: 'pinctrl-[0-9]+'
     25  timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
     25  syscon at 1e6e2000: 'smp-memram at 180' does not match any of the
regexes: '^interrupt-controller@[0-9a-f]+$',
'^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$',
'^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
     25  lpc at 1e789000: lpc-snoop at 80: 'clocks' does not match any of
the regexes: 'pinctrl-[0-9]+'
     25  ftgmac at 1e690000: $nodename:0: 'ftgmac at 1e690000' does not
match '^ethernet(@.*)?$'
     25  ftgmac at 1e680000: $nodename:0: 'ftgmac at 1e680000' does not
match '^ethernet(@.*)?$'
     25  ftgmac at 1e670000: $nodename:0: 'ftgmac at 1e670000' does not
match '^ethernet(@.*)?$'
     25  ftgmac at 1e660000: $nodename:0: 'ftgmac at 1e660000' does not
match '^ethernet(@.*)?$'
     25  fsi at 1e79b100: compatible: ['aspeed,ast2600-fsi-master',
'fsi-master'] is too long
     25  fsi at 1e79b000: compatible: ['aspeed,ast2600-fsi-master',
'fsi-master'] is too long
     25  crypto at 1e6fa000: 'aspeed,ahbc' does not match any of the
regexes: 'pinctrl-[0-9]+'
     25  bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
     24  sdc at 1e740000: sdhci at 1e740200:compatible:
['aspeed,ast2600-sdhci', 'sdhci'] is too long
     24  sdc at 1e740000: sdhci at 1e740100:compatible:
['aspeed,ast2600-sdhci', 'sdhci'] is too long
     22  spi at 60: 'eeprom at 0' does not match any of the regexes:
'^spi@[0-9a-f]+$', 'pinctrl-[0-9]+'
     22  spi at 40: 'eeprom at 0' does not match any of the regexes:
'^spi@[0-9a-f]+$', 'pinctrl-[0-9]+'
     22  sbefifo at 2400: occ: 'occ-hwmon', 'reg' do not match any of the
regexes: 'pinctrl-[0-9]+'

arch/arm/boot/dts/aspeed:68
['adi, adm1272']
['adm1272']
['adm1275']
['aspeed,ast2400-cf-fsi-master', 'fsi-master']
['aspeed,ast2400-cvic', 'aspeed-cvic']
['aspeed,ast2400-i2c-ic']
['aspeed,ast2400-ibt-bmc']
['aspeed,ast2400-lhc']
['aspeed,ast2400-p2a-ctrl']
['aspeed,ast2400-pwm-tacho']
['aspeed,ast2400-timer']
['aspeed,ast2400-vic']
['aspeed,ast2400-video-engine']
['aspeed,ast2500-cf-fsi-master', 'fsi-master']
['aspeed,ast2500-cvic', 'aspeed-cvic']
['aspeed,ast2500-gfx', 'syscon']
['aspeed,ast2500-i2c-ic']
['aspeed,ast2500-ibt-bmc']
['aspeed,ast2500-lhc']
['aspeed,ast2500-p2a-ctrl']
['aspeed,ast2500-pwm-tacho']
['aspeed,ast2500-scu-ic']
['aspeed,ast2500-sdram-edac']
['aspeed,ast2500-video-engine']
['aspeed,ast2500-xdma']
['aspeed,ast2600-fsi-master', 'fsi-master']
['aspeed,ast2600-gfx', 'syscon']
['aspeed,ast2600-ibt-bmc']
['aspeed,ast2600-lhc']
['aspeed,ast2600-scu-ic0']
['aspeed,ast2600-scu-ic1']
['aspeed,ast2600-sdhci', 'sdhci']
['aspeed,ast2600-sdram-edac', 'syscon']
['aspeed,ast2600-smpmem']
['aspeed,ast2600-timer']
['aspeed,ast2600-udma']
['aspeed,ast2600-video-engine']
['aspeed,ast2600-xdma']
['atmel,at30tse004a']
['dallas,ds3231']
['delta,dps800']
['dps650ab']
['fsi-master-gpio', 'fsi-master']
['fsi-master-hub']
['ibm,bonnell-bmc', 'aspeed,ast2600']
['ibm,fsi-i2c-master']
['ibm,fsi-master-hub']
['ibm,fsi2pib']
['ibm,pca9552']
['infineon,ir35221']
['infineon,pxe1610']
['ipmb-dev']
['isil,isl69260']
['isil,raa229004']
['lm75']
['max31790']
['maxim,max31785a']
['microchip,emc1413']
['mps,mp5023']
['nuvoton,w83795g']
['nvt210']
['nxp,pca9551']
['nxp,pca9552']
['nxp,pca9641']
['pmbus']
['pmbus-fan']
['si,si7021a20']
['ti,ucd90160']
