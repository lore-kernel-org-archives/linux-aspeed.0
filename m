From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 14 Nov 2023 15:20:45 -0600
Subject: [PATCH][next] hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow
 warning in aspeed_create_fan_tach_channel()
In-Reply-To: <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
References: <ZVJ7JBFoULzY3VGx@work>
 <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
Message-ID: <c353ba94-0712-422b-bfbb-f166c7690cf8@embeddedor.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 11/14/23 08:52, Guenter Roeck wrote:
> On Mon, Nov 13, 2023 at 01:38:12PM -0600, Gustavo A. R. Silva wrote:
>> Based on the documentation below, the maximum number of Fan tach
>> channels is 16:
>>
>> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>>   45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>>   46                 integer value in the range 0 through 15, with 0 indicating
>>   47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>>   48                 At least one Fan tach input channel is required.
>>
>> However, the compiler doesn't know that, and legitimaly warns about a potential
>> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
>> in case `index` takes a value outside the boundaries of the array:
>>
> 
> All that doesn't warrant introducing checkpatch warnings.

Do you mean this?

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#17:
  46                 integer value in the range 0 through 15, with 0 indicating

I honestly didn't consider that relevant, and I didn't want to alter the format of
the Doc text.

However, if you want me to split any offending line, that's not a problem. Just let
me know. :)

> 
>> drivers/hwmon/aspeed-pwm-tacho.c:
>> 179 struct aspeed_pwm_tacho_data {
>> ...
>> 184         bool fan_tach_present[16];
>> ...
>> 193         u8 fan_tach_ch_source[16];
>> ...
>> 196 };
>>
>> In function ?aspeed_create_fan_tach_channel?,
>>      inlined from ?aspeed_create_fan? at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>>      inlined from ?aspeed_pwm_tacho_probe? at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
>> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>>    751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>> drivers/hwmon/aspeed-pwm-tacho.c: In function ?aspeed_pwm_tacho_probe?:
>> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ?fan_tach_ch_source? of size 16
>>    193 |         u8 fan_tach_ch_source[16];
>>        |            ^~~~~~~~~~~~~~~~~~
>>
>> Fix this by sanity checking `index` before using it to index arrays of
>> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, and just for
>> completeness, add a `pr_err()` message to display in the unlikely case
>> `0 > index >= 16`.
>>
>> This is probably the last remaining -Wstringop-overflow issue in the
>> kernel, and this patch helps with the ongoing efforts to enable such
>> compiler option globally.
>>
> 
> I am sorry, but this description almost completely misses the point.
> The real issue is that the values in aspeed,fan-tach-ch are not range
> checked, which can cause real problems if is elements are set to values
> larger than 15. This is a real problem and has nothing to do with string
> overflows.

Yeah, the above paragraph was extra, and I removed it in v2[1]. The rest
of the changelog text describes the issue in the code.

> 
> This should use dev_err() (and, yes, that means dev needs to be passed
> as argument), and the function should return -EINVAL if this is
> encountered. Also, error handling should come first.
> 
> 		if (index >= MAX_ASPEED_FAN_TACH_CHANNELS) {
> 			dev_err(dev, "Invalid Fan Tach input channel %u\n.", index);
> 			return -EINVAL;
> 		}

Done in v2.

Thanks a lot for the feedback.
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/ZVPQJIP26dIzRAr6 at work/
