From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 11 Dec 2023 11:09:08 +0700
Subject: [PATCH v3 1/2] i2c: aspeed: Handle the coalesced stop conditions
 with the start conditions.
In-Reply-To: <20231209202810.r7kkz2hlaonyibha@zenone.zhora.eu>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
 <20231208033142.1673232-2-quan@os.amperecomputing.com>
 <20231209202810.r7kkz2hlaonyibha@zenone.zhora.eu>
Message-ID: <ffcacd0f-85a3-4c9f-9d0d-50425fec4775@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/12/2023 03:28, Andi Shyti wrote:
> Hi Quan,
> 
> On Fri, Dec 08, 2023 at 10:31:41AM +0700, Quan Nguyen wrote:
>> Some masters may drive the transfers with low enough latency between
>> the nak/stop phase of the current command and the start/address phase
>> of the following command that the interrupts are coalesced by the
>> time we process them.
>> Handle the stop conditions before processing SLAVE_MATCH to fix the
>> complaints that sometimes occur below.
>>
>> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
>> 0x00000086, but was 0x00000084"
>>
>> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> 

Thanks Andi,
I'll add your Reviewed-by in v4

Thanks,
- Quan
