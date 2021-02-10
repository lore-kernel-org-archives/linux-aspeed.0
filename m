From: vishwanatha subbanna <vishwa@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2021 16:52:36 +0530
Subject: [PATCH 3/6] ARM: dts: aspeed: rainier: Add leds that are off
 PCA9552
In-Reply-To: <CACPK8XdcUyw4st2Et2W0o95sdGOvGNuyoemgt_dUzrS3dYuRcg@mail.gmail.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
 <1605247168-1028-3-git-send-email-vishwa@linux.vnet.ibm.com>
 <CACPK8XdcUyw4st2Et2W0o95sdGOvGNuyoemgt_dUzrS3dYuRcg@mail.gmail.com>
Message-ID: <6AF74EB2-0010-4BD6-ADB0-D8B9D11C9F7B@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 16-Nov-2020, at 11:44 AM, Joel Stanley <joel@jms.id.au> wrote:
> 
> On Fri, 13 Nov 2020 at 05:59, Vishwanatha Subbanna
> <vishwa@linux.vnet.ibm.com> wrote:
>> 
>> These LEDs are on the fans and are connected via a
>> PCA9552 I2C expander
>> 
>> Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
>> ---
>> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 36 ++++++++++++++++++++++++++++
>> 1 file changed, 36 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> index 1da7389..b7d7246 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> @@ -173,6 +173,42 @@
>>                        default-state = "keep";
>>                        gpios = <&pca_oppanel 3 GPIO_ACTIVE_LOW>;
>>                };
>> +
>> +               fan0 {
>> +                       retain-state-shutdown;
>> +                       default-state = "keep";
>> +                       gpios = <&pca0 0 GPIO_ACTIVE_LOW>;
> 
> Does it make sense to rename the pca0 phandle to something more
> descriptive so it isn't confused with other expanders? If you want to
> do that please send a follow up patch.


pca0 was something that was already existing before I made the change. I just referenced it.


> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> 
>> +               };
>> +
>> +               fan1 {
>> +                       retain-state-shutdown;
>> +                       default-state = "keep";
>> +                       gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
>> +               };
>> +
>> +               fan2 {
>> +                       retain-state-shutdown;
>> +                       default-state = "keep";
>> +                       gpios = <&pca0 2 GPIO_ACTIVE_LOW>;
>> +               };
>> +
>> +               fan3 {
>> +                       retain-state-shutdown;
>> +                       default-state = "keep";
>> +                       gpios = <&pca0 3 GPIO_ACTIVE_LOW>;
>> +               };
>> +
>> +               fan4 {
>> +                       retain-state-shutdown;
>> +                       default-state = "keep";
>> +                       gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
>> +               };
>> +
>> +               fan5 {
>> +                       retain-state-shutdown;
>> +                       default-state = "keep";
>> +                       gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
>> +               };
>>        };
>> };
>> 
>> --
>> 1.8.3.1

