From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 6 Oct 2022 13:44:18 +0700
Subject: [PATCH v10 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <Yz3VmWCqdolKg5sm@shikoro>
References: <20221004093106.1653317-1-quan@os.amperecomputing.com>
 <20221004093106.1653317-4-quan@os.amperecomputing.com>
 <Yz3VmWCqdolKg5sm@shikoro>
Message-ID: <c8c774c5-b274-a6f9-303b-e84c50800b5c@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Wolfram,

Thank you for your patience with me through many versions.

Best regards,
- Quan


On 06/10/2022 02:06, Wolfram Sang wrote:
> On Tue, Oct 04, 2022 at 04:31:06PM +0700, Quan Nguyen wrote:
>> On I2C_SLAVE_WRITE_REQUESTED event, Slave already ACK'ed on the address
>> phase. But as the backend driver is busy and unable to process any
>> request from Master, issue RxCmdLast for Slave to auto send NACK on
>> next incoming byte.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Applied to for-current, thanks!
> 
