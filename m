From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Oct 2019 06:48:15 +0000
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8XfKCSNsQJa2J2jKZJ7LGZh3zXAOfBYnp5X0w=TH4JfSpQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2019 at 21:20, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> In case of master pending state, it should not trigger a master
> command, otherwise data could be corrupted because this H/W shares
> the same data buffer for slave and master operations. It also means
> that H/W command queue handling is unreliable because of the buffer
> sharing issue. To fix this issue, it clears command queue if a
> master command is queued in pending state to use S/W solution
> instead of H/W command queue handling. Also, it refines restarting
> mechanism of the pending master command.
>
> Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Acked-by: Joel Stanley <joel@jms.id.au>

While reviewing I was concerned about the locking in
aspeed_i2c_master_xfer. It's a bit hairy, and I am not convinced it is
without bugs.
