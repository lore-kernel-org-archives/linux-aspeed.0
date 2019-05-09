From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 9 May 2019 16:51:44 -0700
Subject: [PATCH 1/7] media: aspeed: fix a kernel warning on clk control
In-Reply-To: <9b9f9e0d8fdeef0749fa5fcef1647216e9a74f8c.camel@kernel.crashing.org>
References: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
 <20190502191317.29698-2-jae.hyun.yoo@linux.intel.com>
 <1ec7397cb164b40877839bbc90f79b5942675fdb.camel@kernel.crashing.org>
 <6e93467e-1556-3cfd-b15c-c12b6907f526@linux.intel.com>
 <3b4269d829467870f0b6adac18089b93114fcd3c.camel@kernel.crashing.org>
 <3786afed-c34d-e3f0-4cd5-620185807091@linux.intel.com>
 <b682cc6a480f2b8a5e14c5c001fa1927467d4e18.camel@kernel.crashing.org>
 <bd909078-323e-93a6-143f-0bb0f0d2229c@linux.intel.com>
 <9b9f9e0d8fdeef0749fa5fcef1647216e9a74f8c.camel@kernel.crashing.org>
Message-ID: <2f21bac3-7095-a535-e964-ae24ae6e021d@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/9/2019 4:19 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2019-05-09 at 10:19 -0700, Jae Hyun Yoo wrote:
>>
>> Okay. Probably I need to add one another patch in this series to address
>> what you pointed out.
>>
>> I have one question. I reviewed again all bitops in this driver and
>> checked that some bitops are protected by a spinlock and some others
>> are not. In this case, can I mix use atomic and non-atomic bitops
>> depend on each bitop's protection state by the spinlock? Or, would it be
>> better to change all of them to bool in this case?
> 
> No, if some aren't protected by a lock and some are, then they need to
> remain atomic.
> 
> The question then becomes whether the unprotected ones are actually
> correct or just exposing more races.

Got it. Not sure yet but I think the protected bitops could be moved out
from the spinlock scope then all bitops could be kept as atomic. I'll
look at and test this driver code more deeply again, and will submit v2
soon.

Again, thanks a lot for your review.

Regards,
Jae
