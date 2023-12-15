From: Andi Shyti <andi.shyti@kernel.org>
Date: Fri, 15 Dec 2023 02:42:48 +0100
Subject: [PATCH v4 1/2] i2c: aspeed: Handle the coalesced stop conditions
 with the start conditions.
In-Reply-To: <20231211102217.2436294-2-quan@os.amperecomputing.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
 <20231211102217.2436294-2-quan@os.amperecomputing.com>
Message-ID: <20231215014248.6f7sqh6n4kmhe4js@zenone.zhora.eu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

On Mon, Dec 11, 2023 at 05:22:16PM +0700, Quan Nguyen wrote:
> Some masters may drive the transfers with low enough latency between
> the nak/stop phase of the current command and the start/address phase
> of the following command that the interrupts are coalesced by the
> time we process them.
> Handle the stop conditions before processing SLAVE_MATCH to fix the
> complaints that sometimes occur below.
> 
> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
> 0x00000086, but was 0x00000084"
> 
> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> ---
> v4:
>   + Add an extra empty line before the comment                        [Andrew]
> 
> Note: I'd like to keep adding Reviewed-by Andrew and Andi for this patch
> eventhough there is an extra empty line added before the comment as mentioned
> above. Thanks for the review.

that's OK and you should. You would remove the r-b/a-b only if
you do some major changes. Besides, this change was asked both by
me and Andrew.

Thanks,
Andi
