From: Peter Rosin <peda@axentia.se>
Date: Fri, 18 Oct 2019 04:28:51 +0000
Subject: AST2600 i2c irq issue
In-Reply-To: <dbb8635e-a95a-3951-cd65-3428adc461ec@linux.intel.com>
References: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
 <f9fecc04-2a9a-4cbd-a1ff-ffb680b0fec2@linux.vnet.ibm.com>
 <dbb8635e-a95a-3951-cd65-3428adc461ec@linux.intel.com>
Message-ID: <b2149b86-56c7-dee7-2ea7-49f8837534b0@axentia.se>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019-10-18 00:29, Jae Hyun Yoo wrote:
> On 10/17/2019 1:31 PM, Eddie James wrote:
>> I was also able to "fix" this by simple returning IRQ_NONE if irq_status 
>> == 0 in the interrupt handler. But probably not a good solution.
> 
> A fix like below, right?
> 
> @@ -603,6 +603,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void 
> *dev_id)
> 
>          spin_lock(&bus->lock);
>          irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +       if (!irq_received)
> +               return IRQ_NONE;
> +

Don't forget spin_unlock(&bus->lock);

Cheers,
Peter
