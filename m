From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 15 Jan 2019 15:32:33 -0800
Subject: [PATCH i2c-next v9 0/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
In-Reply-To: <20190115224713.duoha332mjlrmwji@ninjato>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20190115224713.duoha332mjlrmwji@ninjato>
Message-ID: <ae348673-f6d5-36ac-a1f2-872d0bab06b1@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/15/2019 2:47 PM, Wolfram Sang wrote:
> On Tue, Oct 30, 2018 at 02:09:11PM -0700, Jae Hyun Yoo wrote:
>> In multi-master environment, this driver's master cannot know
>> exactly when a peer master sends data to this driver's slave so a
>> case can be happened that this master tries to send data through
>> the master_xfer function but slave data from peer master is still
>> being processed by this driver. To prevent state corruption in the
>> case, this patch adds checking code if any slave operation is
>> ongoing and it waits up to the bus timeout duration before starting
>> a master_xfer operation.
>>
>> To support this change, it introduces changes on i2c-core-base to
>> make that able to read the bus timeout and master transfer retries
>> count values from device tree properties.
>>
>> Please review this patch set.
> 
> Marking this as "Changes requested". I think if the mutex approach
> works, these patches become obsolete then.
> 

Hi Wolfram,

Thanks for your touching base. I made and tested a new patch in my
local. Actually, I couldn't use a mutex because it should provide
locking between driver context and interrupt context. Instead, after
taking lots of experiments, I checked that idle waiting can be supported
by this H/W so I didn't need to use any locking method in the driver
code for multi-master handling. I'll submit a new patch tomorrow using a
different thread. Please drop this patch set.

Thanks,
Jae
