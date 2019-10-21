From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 21 Oct 2019 14:57:43 -0700
Subject: [PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: add hardware
 timeout support
In-Reply-To: <0a629f7b-b829-c332-27d8-dc825205ff72@axentia.se>
References: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
 <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
 <0a629f7b-b829-c332-27d8-dc825205ff72@axentia.se>
Message-ID: <7abf933b-cb18-10af-9c1b-163ec65ffae5@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

On 10/21/2019 2:05 PM, Peter Rosin wrote:
> On 2019-10-21 22:24, Jae Hyun Yoo wrote:
>> Append a binding to support hardware timeout feature.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>> index b47f6ccb196a..133bfedf4cdd 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>> @@ -17,6 +17,8 @@ Optional Properties:
>>   - bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
>>   		  specified
>>   - multi-master	: states that there is another master active on this bus.
>> +- aspeed,hw-timeout-ms	: Hardware timeout in milliseconds. If it's not
>> +			  specified, the H/W timeout feature will be disabled.
>>   
>>   Example:
>>   
>>
> 
> Some SMBus clients support a smbus-timeout-disable binding for disabling
> timeouts like this, for cases where the I2C adapter in question on occasion
> is unable to keep the pace. Adding that property thus avoids undesired
> timeouts when the client is SMBus conformant without it. Your new binding
> is the reverse situation, where you want to add a timeout where one is
> otherwise missing.
> 
> Anyway, since I2C does not have a specified lowest possible frequency, this
> feels like something that is more in the SMBus arena. Should the property
> perhaps be a generic property named smbus-timeout-ms, or something like
> that?

Well, I tried upstreaming of the generic timeout property a year ago but
I agreed that the generic bus timeout property can be set by an ioctl
command so it didn't need to be added into device tree at that time. Not
sure if any need has come recently but I haven't heard that. This driver
still uses the generic timeout property which is provided by i2c core
for handling command timeouts, and it's out of scope from this patch
series.

> If the above is not wanted or appropriate, then I would personally prefer
> aspeed,bus-timeout-ms over aspeed,hw-timeout-ms. To me, hw-timeout-ms sounds
> like a (more serious) timeout between the CPU and the I2C peripheral unit
> or something like that. But I don't care deeply...

Changes I submitted in this patch set is for a different purpose which
is very Aspeed H/W specific, and actually it's a more serious timeout
setting indeed. If this H/W is used in multi-master environment, it
could meet a H/W hang that freezes itself in slave mode and it can't
escape from the state. To resolve the specific case, this H/W provides
self-recovery feature which monitors abnormal state of SDA, SCL and its
H/W state machine using the timeout setting to determine the escape
condition.

Generally, this H/W timeout value is smaller than the generic bus
timeout value (I'm using 300ms for the H/W timeout while I'm using 1
second for the generic bus timeout) so I think it should be
distinguished from the generic bus timeout.

Thanks,

Jae
