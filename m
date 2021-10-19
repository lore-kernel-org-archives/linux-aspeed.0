From: Thang Nguyen <thang@amperemail.onmicrosoft.com>
Date: Tue, 19 Oct 2021 17:37:34 +0700
Subject: [PATCH v2 1/3] ARM: dts: aspeed: mtjade: Add some gpios
In-Reply-To: <CACPK8Xcp0ruL-7p3AA+yvba3Drrwm-=-hMnMpd=a1aHwQHnE1A@mail.gmail.com>
References: <20211019060155.945-1-quan@os.amperecomputing.com>
 <20211019060155.945-2-quan@os.amperecomputing.com>
 <CACPK8Xcp0ruL-7p3AA+yvba3Drrwm-=-hMnMpd=a1aHwQHnE1A@mail.gmail.com>
Message-ID: <161db1b2-f52f-2bbb-7121-a4097df8cf48@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 19/10/2021 13:46, Joel Stanley wrote:
> On Tue, 19 Oct 2021 at 06:02, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>>
>> Add S0_SCP_AUTH_FAIL, S1_SCP_AUTH_FAIL gpios to indicates firmware
>> authentication fail on each socket.
> 
> These use the gpio-keys API to expose the GPIOs. I think OpenBMC is
> moving away from this abstraction, and instead reading the GPIOs with
> the gpio chardev interface.
Can you give an example of the suggested change?
> 
>>
>> Add gpio RTC_BAT_SEN_EN to enable RTC battery adc sensor.
>>
>> Add BMC_I2C4_O_EN gpio to go high at boot to enable access to I2C4 bus.
> 
> OpenBMC has started a process to document GPIOs that are exposed to
> userspace, initially so a common userspace can be used across
> machines. I like doing it for the additional reason that it provides
> consistency in the naming.
[Thang] The BMC_I2C4_O_EN GPIO is used in kernel only which enabling 
access to all I2C devices in I2C4 bus, like FRU EEPROM. As it is used as 
gpio-hog, no userspace access is allowed/intended. It can't be 
configured in userspace as FRU EEPROM is probed only in kernel boot.
> 
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
> 
> If you could take a look at that document and add your GPIOs where
> possible, and then update the device tree.
[Thang] I am aware of this GPIO naming convention document. But I think 
it is to define common name for special GPIOs that applications can use.

>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> Signed-off-by: Thang Nguyen <thang@os.amperecomputing.com>
>> ---
>> v2:
>>    - None
>>
>>   .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 21 ++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>> index 57b0c45a2298..3515d55bd312 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>> @@ -86,6 +86,18 @@ S0_cpu_fault {
>>                          linux,code = <ASPEED_GPIO(J, 1)>;
>>                  };
>>
>> +               S0_scp_auth_fail {
>> +                       label = "S0_SCP_AUTH_FAIL";
>> +                       gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
>> +                       linux,code = <ASPEED_GPIO(J, 2)>;
>> +               };
>> +
>> +               S1_scp_auth_fail {
>> +                       label = "S1_SCP_AUTH_FAIL";
>> +                       gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
>> +                       linux,code = <ASPEED_GPIO(Z, 5)>;
>> +               };
>> +
>>                  S1_overtemp {
>>                          label = "S1_OVERTEMP";
>>                          gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
>> @@ -590,7 +602,7 @@ &gpio {
>>          /*Q0-Q7*/       "","","","","","UID_BUTTON","","",
>>          /*R0-R7*/       "","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
>>                          "OCP_MAIN_PWREN","RESET_BUTTON","","",
>> -       /*S0-S7*/       "","","","","","","","",
>> +       /*S0-S7*/       "","","","","RTC_BAT_SEN_EN","","","",
> 
> I suggest you create a proposal to call this one
> battery-voltage-read-enable. I know that some of the IBM machines
> intend to have this same GPIO.
[Thang] is there any application to use this pin name?
> 
>>          /*T0-T7*/       "","","","","","","","",
>>          /*U0-U7*/       "","","","","","","","",
>>          /*V0-V7*/       "","","","","","","","",
>> @@ -604,4 +616,11 @@ &gpio {
>>                          "S1_BMC_DDR_ADR","","","","",
>>          /*AC0-AC7*/     "SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
>>                          "BMC_OCP_PG";
>> +
>> +       i2c4_o_en {
>> +               gpio-hog;
>> +               gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
>> +               output-high;
>> +               line-name = "BMC_I2C4_O_EN";
>> +       };
>>   };
>> --
>> 2.28.0
>>
