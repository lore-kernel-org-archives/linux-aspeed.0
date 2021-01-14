From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 14 Jan 2021 12:05:26 -0800
Subject: [PATCH v2 1/4] dt-bindings: i2c: aspeed: add buffer and DMA mode
 transfer support
In-Reply-To: <20210114193416.GA3432711@robh.at.kernel.org>
References: <20210112003749.10565-1-jae.hyun.yoo@linux.intel.com>
 <20210112003749.10565-2-jae.hyun.yoo@linux.intel.com>
 <20210114193416.GA3432711@robh.at.kernel.org>
Message-ID: <4f67358e-58e5-65a5-3680-1cd8e9851faa@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 1/14/2021 11:34 AM, Rob Herring wrote:
>> -- reg			: address offset and range of bus
>> +- reg			: Address offset and range of bus registers.
>> +
>> +			  An additional SRAM buffer address offset and range is
>> +			  optional in case of enabling I2C dedicated SRAM for
>> +			  buffer mode transfer support. If the optional range
>> +			  is defined, buffer mode will be enabled.
>> +			  - AST2400
>> +			    &i2c0 { reg = <0x40 0x40>, <0x800 0x80>; };
>> +			    &i2c1 { reg = <0x80 0x40>, <0x880 0x80>; };
>> +			    &i2c2 { reg = <0xc0 0x40>, <0x900 0x80>; };
>> +			    &i2c3 { reg = <0x100 0x40>, <0x980 0x80>; };
>> +			    &i2c4 { reg = <0x140 0x40>, <0xa00 0x80>; };
>> +			    &i2c5 { reg = <0x180 0x40>, <0xa80 0x80>; };
>> +			    &i2c6 { reg = <0x1c0 0x40>, <0xb00 0x80>; };
>> +			    &i2c7 { reg = <0x300 0x40>, <0xb80 0x80>; };
>> +			    &i2c8 { reg = <0x340 0x40>, <0xc00 0x80>; };
>> +			    &i2c9 { reg = <0x380 0x40>, <0xc80 0x80>; };
>> +			    &i2c10 { reg = <0x3c0 0x40>, <0xd00 0x80>; };
>> +			    &i2c11 { reg = <0x400 0x40>, <0xd80 0x80>; };
>> +			    &i2c12 { reg = <0x440 0x40>, <0xe00 0x80>; };
>> +			    &i2c13 { reg = <0x480 0x40>, <0xe80 0x80>; };
> 
> All this information doesn't need to be in the binding.
> 
> It's also an oddly structured dts file if this is what you are doing...

I removed the default buffer mode settings that I added into
'aspeed-g4.dtsi' and 'aspeed-g5.dtsi' in v1 to avoid touching of the
default transfer mode setting, but each bus should use its dedicated
SRAM buffer range for enabling buffer mode so I added this information
at here as overriding examples instead. I thought that binding document
is a right place for providing this information but looks like it's not.
Any recommended place for it? Is it good enough if I add it just into
the commit message?

>> @@ -17,6 +72,25 @@ Optional Properties:
>>   - bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
>>   		  specified
>>   - multi-master	: states that there is another master active on this bus.
>> +- aspeed,dma-buf-size	: size of DMA buffer.
>> +			    AST2400: N/A
>> +			    AST2500: 2 ~ 4095
>> +			    AST2600: 2 ~ 4096
> 
> If based on the SoC, then all this can be implied from the compatible
> string.
> 

Please help me to clarify your comment. Should I remove it from here
with keeping the driver handling code for each SoC compatible string?
Or should I change it like below?
aspeed,ast2400-i2c-bus: N/A
aspeed,ast2500-i2c-bus: 2 ~ 4095
aspeed,ast2600-i2c-bus: 2 ~ 4096

Thanks,
Jae
