From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Tue, 14 Sep 2021 15:44:06 -0500
Subject: [PATCH v2] ARM: dts: aspeed: rainier: Add N_MODE_VREF gpio
In-Reply-To: <CACPK8XfjF+aiEMLocscMEOw8ebKoT2MK8djvv4voyFOBjumXRg@mail.gmail.com>
References: <20210910195417.2838841-1-anoo@linux.ibm.com>
 <CACPK8XfjF+aiEMLocscMEOw8ebKoT2MK8djvv4voyFOBjumXRg@mail.gmail.com>
Message-ID: <23EB5226-63A1-45AF-A50E-2A9D6DABFC08@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On Sep 14, 2021, at 3:49 AM, Joel Stanley <joel@jms.id.au> wrote:
> 
> On Fri, 10 Sept 2021 at 19:54, Adriana Kobylak <anoo@linux.ibm.com> wrote:
>> 
>> From: Adriana Kobylak <anoo@us.ibm.com>
>> 
>> The N_MODE_VREF gpio is designed to be used to specify how many power
>> supplies the system should have (2 or 4).  If enough power supplies fail
>> so that the system no longer has redundancy (no longer n+1), the
>> hardware will signal to the Onboard Chip Controller that the system may
>> be oversubscribed, and performance may need to be reduced so the system
>> can maintain it's powered on state. This gpio is on a 9552, populate all
>> the gpios on that chip for completeness.
>> 
>> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
>> ---
>> 
>> v2: Update commit message.
>> 
>> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 103 +++++++++++++++++++
>> 1 file changed, 103 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> index 6fd3ddf97a21..d5eea86dc260 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> @@ -1502,6 +1502,109 @@ eeprom at 51 {
>>                reg = <0x51>;
>>        };
>> 
>> +       pca_pres3: pca9552 at 60 {
>> +               compatible = "nxp,pca9552";
>> +               reg = <0x60>;
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +
>> +               gpio-line-names =
>> +                       "",
>> +                       "APSS_RESET_N",
>> +                       "", "", "", "",
>> +                       "P10_DCM0_PRES",
>> +                       "P10_DCM1_PRES",
>> +                       "", "",
>> +                       "N_MODE_CPU_N",
>> +                       "",
>> +                       "PRESENT_VRM_DCM0_N",
>> +                       "PRESENT_VRM_DCM1_N",
>> +                       "N_MODE_VREF",
> 
> Should any (all?) of these names be documented?
> 
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Not sure. Seems the openbmc doc is documenting the gpios for gpiochip0 only? The gpio names for 9552 in this patch come from the System Workbook, and doesn?t seem the gpios from the existing 9552 that also come from the System Workbook are documented in the openbmc design doc, such as SLOT6_PRSNT_EN_RSVD, SLOT11_EXPANDER_PRSNT_N, etc.

> 
> 
>> +                       "";
>> +
>> +               gpio at 0 {
>> +                       reg = <0>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 1 {
>> +                       reg = <1>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 2 {
>> +                       reg = <2>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 3 {
>> +                       reg = <3>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 4 {
>> +                       reg = <4>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 5 {
>> +                       reg = <5>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 6 {
>> +                       reg = <6>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 7 {
>> +                       reg = <7>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 8 {
>> +                       reg = <8>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 9 {
>> +                       reg = <9>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 10 {
>> +                       reg = <10>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 11 {
>> +                       reg = <11>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 12 {
>> +                       reg = <12>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 13 {
>> +                       reg = <13>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 14 {
>> +                       reg = <14>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +
>> +               gpio at 15 {
>> +                       reg = <15>;
>> +                       type = <PCA955X_TYPE_GPIO>;
>> +               };
>> +       };
>> +
>>        pca_pres2: pca9552 at 61 {
>>                compatible = "nxp,pca9552";
>>                reg = <0x61>;
>> --
>> 2.25.1
>> 

