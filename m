From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 1 Nov 2021 16:25:38 +0700
Subject: [PATCH v2 1/3] ARM: dts: aspeed: mtjade: Add some gpios
In-Reply-To: <87d82a93-cdc2-d95a-4ab9-085ff31c4387@os.amperecomputing.com>
References: <20211019060155.945-1-quan@os.amperecomputing.com>
 <20211019060155.945-2-quan@os.amperecomputing.com>
 <CACPK8Xcp0ruL-7p3AA+yvba3Drrwm-=-hMnMpd=a1aHwQHnE1A@mail.gmail.com>
 <87d82a93-cdc2-d95a-4ab9-085ff31c4387@os.amperecomputing.com>
Message-ID: <4eb31178-cf05-24cd-6a75-6628689cef25@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Joel,

I found this patch appears in linux-next tree as in [1], can we expect 
the remain two patches in this patchset ([2] and [3]) will be merged soon?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20211029&id=0b32c1b4071c482f2cf98b717cfc7380423ec619

[2] https://www.spinics.net/lists/kernel/msg4115571.html
[3] https://www.spinics.net/lists/kernel/msg4115572.html

Thanks,
- Quan

On 25/10/2021 11:44, Quan Nguyen wrote:
> On 19/10/2021 13:46, Joel Stanley wrote:
>> On Tue, 19 Oct 2021 at 06:02, Quan Nguyen 
>> <quan@os.amperecomputing.com> wrote:
>>>
>>> Add S0_SCP_AUTH_FAIL, S1_SCP_AUTH_FAIL gpios to indicates firmware
>>> authentication fail on each socket.
>>
>> These use the gpio-keys API to expose the GPIOs. I think OpenBMC is
>> moving away from this abstraction, and instead reading the GPIOs with
>> the gpio chardev interface.
>>
> Thanks Joel for the review,
> Yes, will switch to use gpio chardev interface and will remove these 
> gpio-keys defined in next version
> 
>>>
>>> Add gpio RTC_BAT_SEN_EN to enable RTC battery adc sensor.
>>>
>>> Add BMC_I2C4_O_EN gpio to go high at boot to enable access to I2C4 bus.
>>
>> OpenBMC has started a process to document GPIOs that are exposed to
>> userspace, initially so a common userspace can be used across
>> machines. I like doing it for the additional reason that it provides
>> consistency in the naming.
>>
>> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md 
>>
>>
>> If you could take a look at that document and add your GPIOs where
>> possible, and then update the device tree.
>>
> 
> There is on-going discussion about naming of the RTC voltage sensing 
> enable gpio pin in [1], So I'd like to address this change later in 
> separate patch when this is settled. Hence, I will remove this changes 
> in next version.
> 
> [1] https://gerrit.openbmc-project.xyz/c/openbmc/docs/+/48018
> 
> About the BMC_I2C4_O_EN, this is needed as gpio-hog to make the i2c bus 
> accessible at boot time so I will keep this in next version.
> In fact, I'm still a bit of confuse if this pin needs a common name as 
> it is just to enable the bus access and does not serve for any 
> particular common purpose.
> 
> Thanks,
> - Quan
> 
>>>
>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>>> Signed-off-by: Thang Nguyen <thang@os.amperecomputing.com>
>>> ---
>>> v2:
>>> ?? - None
>>>
>>> ? .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 21 ++++++++++++++++++-
>>> ? 1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts 
>>> b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> index 57b0c45a2298..3515d55bd312 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
>>> @@ -86,6 +86,18 @@ S0_cpu_fault {
>>> ???????????????????????? linux,code = <ASPEED_GPIO(J, 1)>;
>>> ???????????????? };
>>>
>>> +?????????????? S0_scp_auth_fail {
>>> +?????????????????????? label = "S0_SCP_AUTH_FAIL";
>>> +?????????????????????? gpios = <&gpio ASPEED_GPIO(J, 2) 
>>> GPIO_ACTIVE_LOW>;
>>> +?????????????????????? linux,code = <ASPEED_GPIO(J, 2)>;
>>> +?????????????? };
>>> +
>>> +?????????????? S1_scp_auth_fail {
>>> +?????????????????????? label = "S1_SCP_AUTH_FAIL";
>>> +?????????????????????? gpios = <&gpio ASPEED_GPIO(Z, 5) 
>>> GPIO_ACTIVE_LOW>;
>>> +?????????????????????? linux,code = <ASPEED_GPIO(Z, 5)>;
>>> +?????????????? };
>>> +
>>> ???????????????? S1_overtemp {
>>> ???????????????????????? label = "S1_OVERTEMP";
>>> ???????????????????????? gpios = <&gpio ASPEED_GPIO(Z, 6) 
>>> GPIO_ACTIVE_LOW>;
>>> @@ -590,7 +602,7 @@ &gpio {
>>> ???????? /*Q0-Q7*/?????? "","","","","","UID_BUTTON","","",
>>> ???????? /*R0-R7*/?????? "","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
>>> ???????????????????????? "OCP_MAIN_PWREN","RESET_BUTTON","","",
>>> -?????? /*S0-S7*/?????? "","","","","","","","",
>>> +?????? /*S0-S7*/?????? "","","","","RTC_BAT_SEN_EN","","","",
>>
>> I suggest you create a proposal to call this one
>> battery-voltage-read-enable. I know that some of the IBM machines
>> intend to have this same GPIO.
>>
>>> ???????? /*T0-T7*/?????? "","","","","","","","",
>>> ???????? /*U0-U7*/?????? "","","","","","","","",
>>> ???????? /*V0-V7*/?????? "","","","","","","","",
>>> @@ -604,4 +616,11 @@ &gpio {
>>> ???????????????????????? "S1_BMC_DDR_ADR","","","","",
>>> ???????? /*AC0-AC7*/     
>>> "SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
>>> ???????????????????????? "BMC_OCP_PG";
>>> +
>>> +?????? i2c4_o_en {
>>> +?????????????? gpio-hog;
>>> +?????????????? gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
>>> +?????????????? output-high;
>>> +?????????????? line-name = "BMC_I2C4_O_EN";
>>> +?????? };
>>> ? };
>>> -- 
>>> 2.28.0
>>>
> 

