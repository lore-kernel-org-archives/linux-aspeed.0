From: Andrew Geissler <geissonator@gmail.com>
Date: Thu, 06 Feb 2020 16:48:31 -0000
Subject: [PATCH linux dev-5.4 v2] ARM: dts: aspeed: witherspoon: Add gpio
 line names
In-Reply-To: <CACPK8XcGJ61mgCL+vZQEzTmcwu+jZ0hpKrnOz7B7K14y79cvFQ@mail.gmail.com>
References: <20200205215511.80333-1-geissonator@gmail.com>
 <CACPK8XcGJ61mgCL+vZQEzTmcwu+jZ0hpKrnOz7B7K14y79cvFQ@mail.gmail.com>
Message-ID: <73471F41-EB8B-4B8B-9BF1-BB56FA666F50@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On Feb 6, 2020, at 12:45 AM, Joel Stanley <joel@jms.id.au> wrote:
> 
> On Wed, 5 Feb 2020 at 21:55, Andrew Geissler <geissonator at gmail.com <mailto:geissonator@gmail.com>> wrote:
>> 
>> From: Andrew Geissler <geissonator at yahoo.com <mailto:geissonator@yahoo.com>>
>> 
>> Name the gpios so libgiod will work with them
> 
> Perhaps: "Name the GPIOs to help userspace work with them."

ack

> 
> You could also mention that the names are describe the functionality
> that the lines provide, and not a net or ball name.

ack

> 
> A heads up: when you send patches upstream to the kernel mailing list,
> we don't include the "linux dev-X.y" stuff in the subject.

thanks, will fix in next patch

> 
>> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
>> ---
>> v2: added upstream to patch
>>    prepended fsi- on fsi related gpios
>>    prepended led- on led related gpios
>>    prepended presence on presence related gpios
>>    dropped pin_gpio_a1 definition
>> ---
>> .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 36 +++++++++++++++++++
>> 1 file changed, 36 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
>> index 515f0f208ee6..2519722928a4 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
>> @@ -193,6 +193,42 @@
>> 
>> };
>> 
>> +&gpio {
>> +    status = "okay";
> 
> The status=okay is harmless but redundant, as this node is already enabled.

ack

> 
>> +       gpio-line-names =
>> +       /*A0-A7*/       "","cfam-reset","","","","","fsi-mux","",
>> +       /*B0-B7*/       "","","","","","air-water","","",
>> +       /*C0-C7*/       "","","","","","","","",
>> +       /*D0-D7*/       "fsi-enable","","","","","","","",
>> +       /*E0-E7*/       "fsi-data","","","","","","","",
>> +       /*F0-F7*/       "","","","","","","","",
>> +       /*G0-G7*/       "","","","","","","","",
>> +       /*H0-H7*/       "","","","","","","","",
>> +       /*I0-I7*/       "","","","","","","","",
>> +       /*J0-J7*/       "","","checkstop","","","","","",
>> +       /*K0-K7*/       "","","","","","","","",
>> +       /*L0-L7*/       "","","","","","","","",
>> +       /*M0-M7*/       "","","","","","","","",
>> +       /*N0-N7*/       "presence-ps1","","led-rear-fault","led-rear-power",
>> +                       "led-rear-id","","","",
>> +       /*O0-O7*/       "","","","","","","","",
>> +       /*P0-P7*/       "","","","","","","","presence-ps0",
>> +       /*Q0-Q7*/       "","","","","","","","",
>> +       /*R0-R7*/       "","","fsi-trans","","","power-button","","",
>> +       /*S0-S7*/       "","","","","","","","",
>> +       /*T0-T7*/       "","","","","","","","",
>> +       /*U0-U7*/       "","","","","","","","",
>> +       /*V0-V7*/       "","","","","","","","",
>> +       /*W0-W7*/       "","","","","","","","",
>> +       /*X0-X7*/       "","","","","","","","",
>> +       /*Y0-Y7*/       "","","","","","","","",
>> +       /*Z0-Z7*/       "","","","","","","","",
>> +       /*AA0-AA7*/     "fsi-clock","","","","","","","",
>> +       /*AB0-AB7*/     "","","","","","","","",
>> +       /*AC0-AC7*/     "","","","","","","","";
>> +
> 
> Cean up the line of whitespace here.

ack

> 
>> +};
>> +
>> &fmc {
>>        status = "okay";
>> 
>> --
>> 2.21.0 (Apple Git-122)

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200206/bccd1fcd/attachment-0001.htm>
