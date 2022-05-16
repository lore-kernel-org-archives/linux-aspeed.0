From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 16 May 2022 09:32:08 +0700
Subject: [PATCH v7 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <Yn+9QBoPdH8fMm/m@shikoro>
References: <20220422040803.2524940-1-quan@os.amperecomputing.com>
 <20220422040803.2524940-4-quan@os.amperecomputing.com>
 <Yn+9QBoPdH8fMm/m@shikoro>
Message-ID: <fc422a06-c035-f6e5-231b-74ea6afe8467@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/05/2022 21:31, Wolfram Sang wrote:
> On Fri, Apr 22, 2022 at 11:08:03AM +0700, Quan Nguyen wrote:
>> When processing I2C_SLAVE_WRITE_REQUESTED event, if slave returns
>> -EBUSY, i2c controller should issue RxCmdLast command to assert NAK
>> on the bus.
> 
> That should be I2C_SLAVE_WRITE_RECEIVED and it should be NAKed on all
> errnos. Have you tested it?
> 

Dear Wolfram,

Thanks for the comment.

Yes, we have tested this patch with ast2500 and see it works well 
without the need of the ugly slave_enable/disable() as before.

When tested with ast2500, it is observed that there's always a 
I2C_SLAVE_WRITE_REQUESTED comes first then other 
I2C_SLAVE_WRITE_RECEIVED's follow for all transactions.

In case slave is busy, the NAK will be asserted on the first occurrence 
of I2C_SLAVE_WRITE_REQUESTED make host to stop the current transaction 
(host later will retry with other transaction) until slave ready.

This behavior is expected as we want host to drop all transactions while 
slave is busy on working on the response. That is why we choose to 
assert NAK on the first I2C_SLAVE_WRITE_REQUESTED of the transaction 
instead of I2C_SLAVE_WRITE_RECEIVED.

As we are interested in this specific case, ie: to assert NAK only when 
slave busy, we dont want to force the current aspeed's slave to assert 
NAK in all errno's. That is why we choose to NAK only when there is an 
explicitly -EBUSY return from slave.

Thank you for the review and hope to see further comments.
Thanks,
- Quan

