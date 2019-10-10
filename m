From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 10 Oct 2019 15:04:00 -0700
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <3ea1c0d5-47f1-bf8c-6b2d-2ea8d3f93471@fb.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <3ea1c0d5-47f1-bf8c-6b2d-2ea8d3f93471@fb.com>
Message-ID: <637d4b8b-5113-b07b-f99f-ce66dbe6948c@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/10/2019 2:20 PM, Tao Ren wrote:
> On 10/9/19 2:20 PM, Jae Hyun Yoo wrote:
[...]
>>   		/*
>>   		 * If a peer master starts a xfer immediately after it queues a
>> -		 * master command, change its state to 'pending' then H/W will
>> -		 * continue the queued master xfer just after completing the
>> -		 * slave mode session.
>> +		 * master command, clear the queued master command and change
>> +		 * its state to 'pending'. To simplify handling of pending
>> +		 * cases, it uses S/W solution instead of H/W command queue
>> +		 * handling.
>>   		 */
>>   		if (unlikely(irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)) {
>> +			writel(readl(bus->base + ASPEED_I2C_CMD_REG) &
>> +				~ASPEED_I2CD_MASTER_CMDS_MASK,
>> +			       bus->base + ASPEED_I2C_CMD_REG);
> 
> Sorry for the late comments (just noticed this line while testing the patch):
> 
> I assume this line is aimed at stopping the running master commands, but as per
> AST2500 datasheet, it's NOP to write 0 to MASTER_STOP/MASTER_RX/MASTER_TX bits.
> Maybe all we need is writing 1 to MASTER_STOP field?

There could be two pending cases:
1. Master goes to pending before it triggers a command if a slave
    operation is already initiated.
2. Master goes to pending after it triggered a command if a peer
    master immediately sends something just after the master command
    triggering.

Above code is for the latter case. H/W handles the case priority based
so the slave event will be handled first, and then the master command
will be handled when the slave operation is completed. Problem is,
this H/W shares the same buffer for master and slave operations so
it's unreliable. Above code just removes the master command from the
command register to prevent this H/W command handling of pending events.
Instead, it restarts the master command using a call of 
aspeed_i2c_do_start when the slave operation is completed.

Thanks,

Jae
