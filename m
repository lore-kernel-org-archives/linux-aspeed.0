From: Tao Ren <taoren@fb.com>
Date: Thu, 10 Oct 2019 23:24:45 +0000
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <69296b93-8fc6-c056-ab9b-ae190dc5eea1@linux.intel.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <3ea1c0d5-47f1-bf8c-6b2d-2ea8d3f93471@fb.com>
 <637d4b8b-5113-b07b-f99f-ce66dbe6948c@linux.intel.com>
 <5ce20a28-21ed-ff0c-9e31-bcac3cd7a5fb@fb.com>
 <69296b93-8fc6-c056-ab9b-ae190dc5eea1@linux.intel.com>
Message-ID: <dd0c44f7-4e90-998b-e8c7-d272c593f55c@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/10/19 4:16 PM, Jae Hyun Yoo wrote:
> On 10/10/2019 4:11 PM, Tao Ren wrote:
>> On 10/10/19 3:04 PM, Jae Hyun Yoo wrote:
>>> On 10/10/2019 2:20 PM, Tao Ren wrote:
>>>> On 10/9/19 2:20 PM, Jae Hyun Yoo wrote:
>>> [...]
>>>>> ?????????? /*
>>>>> ??????????? * If a peer master starts a xfer immediately after it queues a
>>>>> -???????? * master command, change its state to 'pending' then H/W will
>>>>> -???????? * continue the queued master xfer just after completing the
>>>>> -???????? * slave mode session.
>>>>> +???????? * master command, clear the queued master command and change
>>>>> +???????? * its state to 'pending'. To simplify handling of pending
>>>>> +???????? * cases, it uses S/W solution instead of H/W command queue
>>>>> +???????? * handling.
>>>>> ??????????? */
>>>>> ?????????? if (unlikely(irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)) {
>>>>> +??????????? writel(readl(bus->base + ASPEED_I2C_CMD_REG) &
>>>>> +??????????????? ~ASPEED_I2CD_MASTER_CMDS_MASK,
>>>>> +?????????????????? bus->base + ASPEED_I2C_CMD_REG);
>>>>
>>>> Sorry for the late comments (just noticed this line while testing the patch):
>>>>
>>>> I assume this line is aimed at stopping the running master commands, but as per
>>>> AST2500 datasheet, it's NOP to write 0 to MASTER_STOP/MASTER_RX/MASTER_TX bits.
>>>> Maybe all we need is writing 1 to MASTER_STOP field?
>>>
>>> There could be two pending cases:
>>> 1. Master goes to pending before it triggers a command if a slave
>>> ??? operation is already initiated.
>>> 2. Master goes to pending after it triggered a command if a peer
>>> ??? master immediately sends something just after the master command
>>> ??? triggering.
>>>
>>> Above code is for the latter case. H/W handles the case priority based
>>> so the slave event will be handled first, and then the master command
>>> will be handled when the slave operation is completed. Problem is,
>>> this H/W shares the same buffer for master and slave operations so
>>> it's unreliable. Above code just removes the master command from the
>>> command register to prevent this H/W command handling of pending events.
>>> Instead, it restarts the master command using a call of aspeed_i2c_do_start when the slave operation is completed.
>>
>> Thanks for the clarify, Jae. I mean clearing these bits has no effect to
>> hardware according to aspeed datasheet; in other word, master command cannot
>> be removed from command register by this statement.
>>
>> For example, below is the description for MASTER_STOP_CMD(I2CD14, bit 5):
>>
>> ?? 0: NOP
>> ?? 1: Issue Master Stop Command
>> ?? This register will be automatically cleared by H/W when Stop Command has
>> ?? been issues.
> 
> It's removing before H/W fetches the the command so the pending command
> isn't cleared by H/W at the timing. If we send a stop command at here, the bus will be messed up.

I see. I didn't know we could clear the bits before hardware fetches them.


Cheers,

Tao
