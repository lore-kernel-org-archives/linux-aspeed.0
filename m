From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 27 Mar 2019 10:10:59 -0500
Subject: [PATCH] ARM: dts: Aspeed: Witherspoon: Update BMC partitioning
In-Reply-To: <CACPK8Xer53amWbQ-6dvEaXfHu=grk3ZWsH9NKCa_Xi_JKUnCMg@mail.gmail.com>
References: <1552409402-15881-1-git-send-email-anoo@linux.ibm.com>
 <CACPK8Xer53amWbQ-6dvEaXfHu=grk3ZWsH9NKCa_Xi_JKUnCMg@mail.gmail.com>
Message-ID: <cd769312-732d-fb7a-ca50-e5b29eac235b@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 3/27/19 1:20 AM, Joel Stanley wrote:
> On Tue, 12 Mar 2019 at 16:50, Adriana Kobylak <anoo@linux.ibm.com> wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> Add simplified partitions for BMC and alternate flash. Include these by
>> default in Witherspoon.
>>
>> Signed-off-by: Edward A. James <eajames@us.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   .../boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi  | 18 ++++++++++++++++++
>>   arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi | 18 ++++++++++++++++++
>>   arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts       |  3 ++-
>>   3 files changed, 38 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi b/arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi
>> new file mode 100644
>> index 0000000..9277599
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed-bmc-alt-opp-flash-layout-ubi.dtsi
> As there are no other machines that use this layout, I think you
> should have the layout in the dts file.

I think the idea was we might have more machines that use this layout in 
the future...

>
>> @@ -0,0 +1,18 @@
>> +               label = "alt-bmc";
>> +               partitions {
>> +                               #address-cells = < 1 >;
>> +                               #size-cells = < 1 >;
>> +                               compatible = "fixed-partitions";
>> +                               u-boot at 0 {
>> +                                       reg = < 0 0x60000 >;
>> +                                       label = "alt-u-boot";
>> +                               };
>> +                               u-boot-env at 60000 {
>> +                                       reg = < 0x60000 0x20000 >;
>> +                                       label = "alt-u-boot-env";
>> +                               };
>> +                               obmc-ubi at 80000 {
>> +                                       reg = < 0x80000 0x1F80000 >;
>> +                                       label = "alt-obmc-ubi";
>> +                               };
>> +               };
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi b/arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi
>> new file mode 100644
>> index 0000000..0059ad1
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-flash-layout-ubi.dtsi
>> @@ -0,0 +1,18 @@
>> +               label = "bmc";
>> +               partitions {
>> +                               #address-cells = < 1 >;
>> +                               #size-cells = < 1 >;
>> +                               compatible = "fixed-partitions";
>> +                               u-boot at 0 {
>> +                                       reg = < 0 0x60000 >;
>> +                                       label = "u-boot";
>> +                               };
>> +                               u-boot-env at 60000 {
>> +                                       reg = < 0x60000 0x20000 >;
>> +                                       label = "u-boot-env";
>> +                               };
>> +                               obmc-ubi at 80000 {
>> +                                       reg = < 0x80000 0x1F80000 >;
>> +                                       label = "obmc-ubi";
>> +                               };
>> +               };
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
>> index c51e3e8..058b9b7 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
>> @@ -191,7 +191,7 @@
>>                  label = "bmc";
>>                  m25p,fast-read;
>>                  spi-max-frequency = <50000000>;
>> -#include "openbmc-flash-layout.dtsi"
>> +#include "aspeed-bmc-opp-flash-layout-ubi.dtsi"
>>          };
>>
>>          flash at 1 {
>> @@ -199,6 +199,7 @@
>>                  label = "alt";
>>                  m25p,fast-read;
>>                  spi-max-frequency = <50000000>;
>> +#include "aspeed-bmc-alt-opp-flash-layout-ubi.dtsi"
>>          };
>>   };
>>
>> --
>> 1.8.3.1
>>

