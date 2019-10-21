From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 21 Oct 2019 11:27:23 -0700
Subject: AST2600 i2c irq issue
In-Reply-To: <20191021121629.GE1145@ninjato>
References: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
 <f9fecc04-2a9a-4cbd-a1ff-ffb680b0fec2@linux.vnet.ibm.com>
 <dbb8635e-a95a-3951-cd65-3428adc461ec@linux.intel.com>
 <8c62b118777c44d1bf8e1a3c32175644@TWMBX02.aspeed.com>
 <20191021121629.GE1145@ninjato>
Message-ID: <cdc01cea-57a3-3b54-e3a1-44088c9120ed@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/21/2019 5:16 AM, Wolfram Sang wrote:
> 
>>           spin_lock(&bus->lock);
>>           irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>> +       if (!irq_received)
>> +               return IRQ_NONE;
>> +
>>           /* Ack all interrupts except for Rx done */
>>           writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
>>                  bus->base + ASPEED_I2C_INTR_STS_REG);
>>
>>
>> I think it's a right fix for the issue. At least, we need to prevent
>> any driver state corruption. The state machine would run correctly if
>> we filtering the garbage interrupt out.
> 
> Just unlock the spinlock before you return...

Thanks Wolfram!

Peter also pointed it out, and Eddie made a patch which includes the
spin_unlock.

Hi Eddie,
Can you please submit your patch into 'i2c-next' upstream?

Thanks,

Jae
