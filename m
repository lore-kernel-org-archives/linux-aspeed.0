From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 6 Jul 2022 11:21:28 +0700
Subject: [PATCH v1 0/5] Enable second flash, update gpios pin and merge
 adc channels
In-Reply-To: <CACPK8XfCskh7KPhXJqOR9ZLnoBdd64SL9D1z5HoDC+_VVs4LCg@mail.gmail.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
 <CACPK8XfCskh7KPhXJqOR9ZLnoBdd64SL9D1z5HoDC+_VVs4LCg@mail.gmail.com>
Message-ID: <01bcd315-4d28-6854-3c6e-0a755b37824a@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Joel,

Thanks for applying this patchset for v5.18.

Would it be also possible to apply them to OpenBMC kernel dev-5.15 
branch as well?

Thanks,
- Quan

On 28/02/2022 11:21, Joel Stanley wrote:
> On Mon, 28 Feb 2022 at 00:03, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>>
>> This patchset adds the second flash support, merge all ADC channels to
>> single iio-hwmon node and update various gpios pin name.
>>
>> Link:https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>>
>> Quan Nguyen (5):
>>    ARM: dts: aspeed: mtjade: Enable secondary flash
>>    ARM: dts: aspeed: mtjade: Update rtc-battery-voltage-read-enable pin
>>    ARM: dts: aspeed: mtjade: Update host0-ready pin
>>    ARM: dts: aspeed: mtjade: Rename GPIO hog nodes to match schema.
>>    ARM: dts: aspeed: mtjade: Move all adc sensors into iio-hwmon node
> 
> These look good.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I'll apply them for v5.18.
> 
>>
>>   .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 26 +++++++++----------
>>   1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> --
>> 2.28.0
>>
