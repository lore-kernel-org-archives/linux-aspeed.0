From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 8 Oct 2019 11:47:19 -0700
Subject: [PATCH 1/5] dt-bindings: i2c: aspeed: add buffer and DMA mode
 transfer support
In-Reply-To: <20191008181213.GB155928@google.com>
References: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
 <20191007231313.4700-2-jae.hyun.yoo@linux.intel.com>
 <20191008181213.GB155928@google.com>
Message-ID: <c09072c6-13f2-202d-8985-ccf409793784@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Brendan,

On 10/8/2019 11:12 AM, Brendan Higgins wrote:
> On Mon, Oct 07, 2019 at 04:13:09PM -0700, Jae Hyun Yoo wrote:
>> Append bindings to support buffer mode and DMA mode transfer.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   .../devicetree/bindings/i2c/i2c-aspeed.txt    | 67 +++++++++++++++++--
>>   1 file changed, 60 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>> index 8fbd8633a387..e40dcc108307 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>> @@ -3,7 +3,10 @@ Device tree configuration for the I2C busses on the AST24XX and AST25XX SoCs.
>>   Required Properties:
>>   - #address-cells	: should be 1
>>   - #size-cells		: should be 0
>> -- reg			: address offset and range of bus
>> +- reg			: Address offset and range of bus registers.
>> +			  An additional SRAM buffer address offset and range is
>> +			  optional in case of enabling I2C dedicated SRAM for
>> +			  buffer mode transfer support.
> 
> Sorry, I am having trouble parsing this. This seems like the SRAM buffer
> is global to all busses. Can you clarify? I expect I will probably have
> some more questions elsewhere.

Each SoC has a different SRAM structure. In case of AST2400, it has a
SRAM buffer pool which can be shared by all busses. In the other hand,
AST2500/2600 have dedicated SRAM spaces for each bus.

This is what I explained in the cover letter:

* Buffer mode
   AST2400:
     It has 2 KBytes (256 Bytes x 8 pages) of I2C SRAM buffer pool from
     0x1e78a800 to 0x1e78afff that can be used for all busses with
     buffer pool manipulation. To simplify implementation for supporting
     both AST2400 and AST2500, it assigns each 128 Bytes per bus without
     using buffer pool manipulation so total 1792 Bytes of I2C SRAM
     buffer will be used.

   AST2500:
     It has 16 Bytes of individual I2C SRAM buffer per each bus and its
     range is from 0x1e78a200 to 0x1e78a2df, so it doesn't have 'buffer
     page selection' bit field in the Function control register, and
     neither 'base address pointer' bit field in the Pool buffer control
     register it has. To simplify implementation for supporting both
     AST2400 and AST2500, it writes zeros on those register bit fields
     but it's okay because it does nothing in AST2500.

>>   - compatible		: should be "aspeed,ast2400-i2c-bus"
>>   			  or "aspeed,ast2500-i2c-bus"
>>   - clocks		: root clock of bus, should reference the APB
>> @@ -16,6 +19,18 @@ Optional Properties:
>>   - bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
>>   		  specified
>>   - multi-master	: states that there is another master active on this bus.
>> +- aspeed,dma-buf-size	: size of DMA buffer (from 2 to 4095 in case of AST2500
>> +			  or later versions).
>> +			  Only AST2500 and later versions support DMA mode
>> +			  under some limitations:
>> +			  I2C is sharing the DMA H/W with UHCI host controller
>> +			  and MCTP controller. Since those controllers operate
>> +			  with DMA mode only, I2C has to use buffer mode or byte
>> +			  mode instead if one of those controllers is enabled.
>> +			  Also make sure that if SD/eMMC or Port80 snoop uses
>> +			  DMA mode instead of PIO or FIFO respectively, I2C
>> +			  can't use DMA mode. If both DMA and buffer modes are
>> +			  enabled, DMA mode will be selected.
> 
> nit: I think it makes sense to break down the exceptions into a
> bulleted list.

Okay. Will update it using bulleted list.

Thanks,

Jae
