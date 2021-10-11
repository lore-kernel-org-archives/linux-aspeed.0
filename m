From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Mon, 11 Oct 2021 16:54:05 -0500
Subject: [PATCH v3] ARM: dts: aspeed: rainier: Add power-config-full-load
 gpio
In-Reply-To: <CACPK8XdnMfDD6FHOuwyxz5S-wzaY1uSBEso6ov6OKQ0r2H7cTg@mail.gmail.com>
References: <20211005192226.213539-1-anoo@linux.ibm.com>
 <CACPK8XdnMfDD6FHOuwyxz5S-wzaY1uSBEso6ov6OKQ0r2H7cTg@mail.gmail.com>
Message-ID: <15085868-FAE6-4FC7-A2BB-C786E7EFBDD4@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On Oct 7, 2021, at 11:22 PM, Joel Stanley <joel@jms.id.au> wrote:
> 
> Hi Adriana,
> 
> On Tue, 5 Oct 2021 at 19:22, Adriana Kobylak <anoo at linux.ibm.com <mailto:anoo@linux.ibm.com>> wrote:
>> 
>> From: Adriana Kobylak <anoo@us.ibm.com>
>> 
>> Add the power-config-full-load described in:
>> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md#power-config-full-load
>> 
>> The power-config-full-load gpio is designed to be used to specify how
>> many power supplies the system should have, in rainier it is 2 or 4.  If
>> enough power supplies fail so that the system no longer has redundancy
>> (no longer n+1), the hardware will signal to the Onboard Chip Controller
>> that the system may be oversubscribed, and performance may need to be
>> reduced so the system can maintain it's powered on state.
>> 
>> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> 
> This looks good. I think the name is much easier to understand now.

Thanks, yeah agree is clearer now.

> 
> I notice you've dropped all of the other names. Do you not need them?

Right, don?t need them. If we ever do, we?ll go through the same process of proposing adequate names for them in the openbmc design doc.

> 
> It would be great if one of the people you cc'd could provide a
> reviewed-by before I merge this.

Sure, seems Eddie just reviewed it.

> 
> Cheers,
> 
> Joel
> 
>> ---
>> 
>> v2: Update commit message.
>> v3: Updated gpio name to power-config-full-load to match design doc.
>> 
>> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> index 33fae8ad1305..10bde77fb847 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> @@ -1998,6 +1998,19 @@ eeprom at 51 {
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
>> +                       "", "", "", "", "", "", "", "",
>> +                       "", "", "", "", "", "", "power-config-full-load", "";
>> +       };
>> +
>>        pca_pres2: pca9552 at 61 {
>>                compatible = "nxp,pca9552";
>>                reg = <0x61>;
>> --
>> 2.25.1

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211011/e21df504/attachment-0001.htm>
