From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Wed, 15 Nov 2023 12:03:27 -0600
Subject: [PATCH v2][next] hwmon: (aspeed-pwm-tacho) Fix
 -Wstringop-overflow warning in aspeed_create_fan_tach_channel()
In-Reply-To: <9ed5116f-cf36-49f6-833e-75eeab4570b4@roeck-us.net>
References: <ZVPQJIP26dIzRAr6@work>
 <9ed5116f-cf36-49f6-833e-75eeab4570b4@roeck-us.net>
Message-ID: <f8f106ee-bccf-4ae3-b9c2-684f6bd938f5@embeddedor.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 11/15/23 07:12, Guenter Roeck wrote:
> On Tue, Nov 14, 2023 at 01:53:08PM -0600, Gustavo A. R. Silva wrote:
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
> Still messes the point. This isn't about "the compiler doesn't know that",
> it is a real bug which may result in out-of-bounds accesses.

Oh, I mentioned that in anticipation of people saying something in the tone of
'that's never going to happen.' :p

However, if this is a real bug, it should probably be tagged for -stable.

> 
> Oh, never mind, I'll just apply it.

Thank you!

--
Gustavo

