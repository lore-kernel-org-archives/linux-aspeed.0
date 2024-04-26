From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Apr 2024 08:32:19 -0500
Subject: [PATCH v2] ARM: dts: aspeed: Add IBM P11 BMC boards
In-Reply-To: <6357235a4a42e889a2b6d7d7ad5511ded4cc29d8.camel@codeconstruct.com.au>
References: <20240415154931.10775-1-eajames@linux.ibm.com>
 <48ad6bcccae315e68bc0aa10669eed645c495139.camel@codeconstruct.com.au>
 <7dd9ba1b-6477-4c09-a571-57002cbfa8b7@linux.ibm.com>
 <6357235a4a42e889a2b6d7d7ad5511ded4cc29d8.camel@codeconstruct.com.au>
Message-ID: <da7bd5a5-6795-4ac9-8529-7dc3596061f9@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/25/24 19:03, Andrew Jeffery wrote:
> On Thu, 2024-04-25 at 16:41 -0500, Eddie James wrote:
>> On 4/15/24 19:02, Andrew Jeffery wrote:
>>> On Mon, 2024-04-15 at 10:49 -0500, Eddie James wrote:
>>>> Add the Blueridge and Fuji BMC systems.
>>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> ---
>>>> Changes since v1:
>>>>    - Change "ody" to "odyssey"
>>>>
>>>>    arch/arm/boot/dts/aspeed/Makefile             |    2 +
>>>>    .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1752 +++++++
>>>>    .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 4016 +++++++++++++++++
>>>>    .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1704 +++++++
>>>>    4 files changed, 7474 insertions(+)
>>> A few points:
>>>
>>> - Altogether this patch is pretty large. Can we do one for each of the
>>> FSI topology and the platforms?
>>>
>>> - The only list to which you've sent the patch is linux-aspeed, which
>>> doesn't appear to be archived on lore. Can you please add at least one
>>> that is? There are a few that should probably be included regardless.
>>>
>>> - I don't plan to merge the patch until it has had review from ideally
>>> more than one other IBMer
>>>
>>> On the review front:
>>>
>>> It looks like you still need to update
>>> Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml with the new
>>> platform compatible strings.
>>>
>>> Also, can you please run
>>>
>>> ```
>>> make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-{blueridge,fuji}.dtb
>>> ```
>>>
>>> and address the warnings? This is best done by first applying the patch
>>> on top of my tree below. It goes some way to eliminating many of the
>>> warnings currently produced for the Aspeed BMC SoCs:
>>>
>>> https://github.com/amboar/linux/tree/dt-warnings/all
>>
>> Thanks, I've sent v3. One patch has turned into 14 to address the
>> warnings...
>>
> Super work, thanks for that.
>
>>   There were still many but they're almost all from
>> aspeed-g6.dtsi.
>>
> This is based on top of my WIP series fixing a bunch of warnings, or on
> top of an upstream tag for submission? Admittedly I didn't fix them all
> but I did clean up a decent chunk of what was there.


For submission I rebased on next, but when checking warnings I used your 
tree. Here's my output:


DTC_CHK arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
 ?? ?from schema $id: 
http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
sdram at 1e6e0000: compatible: ['aspeed,ast2600-sdram-edac', 'syscon'] is 
too long
 ?? ?from schema $id: 
http://devicetree.org/schemas/edac/aspeed,ast2400-sdram-edac.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
ahb: apb: { ... } should not be valid under {'type': 'object'}
 ?? ?from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
bus at 1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
 ?? ?from schema $id: 
http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
ethernet at 1e670000: Unevaluated properties are not allowed 
('#address-cells', '#size-cells' were unexpected)
 ?? ?from schema $id: 
http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
ethernet at 1e690000: Unevaluated properties are not allowed 
('#address-cells', '#size-cells' were unexpected)
 ?? ?from schema $id: 
http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
syscon at 1e6e2000: 'smp-memram at 180' does not match any of the regexes: 
'^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', 
'^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
 ?? ?from schema $id: 
http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/syscon at 1e6e2000/smp-memram at 180: failed to match any schema with 
compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/display at 1e6e6000: failed to match any schema with compatible: 
['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/xdma at 1e6e7000: failed to match any schema with compatible: 
['aspeed,ast2600-xdma']
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
adc at 1e6e9000: 'interrupts' does not match any of the regexes: 
'pinctrl-[0-9]+'
 ?? ?from schema $id: 
http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
adc at 1e6e9100: 'interrupts' does not match any of the regexes: 
'pinctrl-[0-9]+'
 ?? ?from schema $id: 
http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
crypto at 1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 
'pinctrl-[0-9]+'
 ?? ?from schema $id: 
http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
gpio at 1e780000: 'i2c3_mux_oe_n-hog', 'usb_power-hog' do not match any of 
the regexes: 'pinctrl-[0-9]+'
 ?? ?from schema $id: 
http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/lpc at 1e789000/lhc at a0: failed to match any schema with 
compatible: ['aspeed,ast2600-lhc']
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
sdc at 1e750000: sdhci at 1e750100: Unevaluated properties are not allowed 
('compatible' was unexpected)
 ?? ?from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
sdc at 1e750000: sdhci at 1e750100:compatible: ['aspeed,ast2600-sdhci'] is too 
short
 ?? ?from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 200/pca9552 at 61: failed to match any schema 
with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 280/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to 
match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to 
match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 300/i2c-mux at 70/i2c at 1/pca9551 at 61: failed to 
match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 30: failed to match any schema 
with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 31: failed to match any schema 
with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 32: failed to match any schema 
with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 33: failed to match any schema 
with compatible: ['ibm,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/max31785 at 52: failed to match any 
schema with compatible: ['maxim,max31785a']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9551 at 60: failed to match any schema 
with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 400/pca9552 at 61: failed to match any schema 
with compatible: ['nxp,pca9552']
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
dps310 at 76: '#io-channel-cells' does not match any of the regexes: 
'pinctrl-[0-9]+'
 ?? ?from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 480/pca9552 at 60: failed to match any schema 
with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 480/pca9552 at 61: failed to match any schema 
with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 600/i2c-mux at 70/i2c at 0/pca9551 at 60: failed to 
match any schema with compatible: ['nxp,pca9551']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 700/pca9552 at 60: failed to match any schema 
with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 780/pca9552 at 60: failed to match any schema 
with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/bus at 1e78a000/i2c-bus at 800/pca9552 at 60: failed to match any schema 
with compatible: ['nxp,pca9552']
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
fsi at 1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is 
too long
 ?? ?from schema $id: 
http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
fsi at 1e79b000: Unevaluated properties are not allowed ('compatible' was 
unexpected)
 ?? ?from schema $id: 
http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/fsi at 1e79b000: failed to match any schema with compatible: 
['aspeed,ast2600-fsi-master', 'fsi-master']
/home/eajames/devel/linux-2/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
fsi at 1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is 
too long
 ?? ?from schema $id: 
http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/fsi at 1e79b100: failed to match any schema with compatible: 
['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: 
/ahb/apb/dma-controller at 1e79e000: failed to match any schema with 
compatible: ['aspeed,ast2600-udma']


>
>>   The only remaining ones from Blueridge/Fuji that I saw
>> were for undocumented compatibles for max31785 and pca955x.
>>
> Fantastic.
>
>> Those
>> bindings exist but are not in yaml format so the tool doesn't pick them
>> up. I'm sure those can be addressed at another time...
> Yep, sounds good.
>
> Thanks for your efforts.
>
> Andrew
>
