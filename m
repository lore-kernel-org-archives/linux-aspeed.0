From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 10 Oct 2019 11:22:36 -0700
Subject: [PATCH] i2c: aspeed: fix master pending state handling
In-Reply-To: <CACPK8XfKCSNsQJa2J2jKZJ7LGZh3zXAOfBYnp5X0w=TH4JfSpQ@mail.gmail.com>
References: <20191009212034.20325-1-jae.hyun.yoo@linux.intel.com>
 <CACPK8XfKCSNsQJa2J2jKZJ7LGZh3zXAOfBYnp5X0w=TH4JfSpQ@mail.gmail.com>
Message-ID: <8586205c-1edc-dfc2-3309-11050afbbaf8@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Acked-by: Joel Stanley <joel@jms.id.au>

Thanks!

> While reviewing I was concerned about the locking in
> aspeed_i2c_master_xfer. It's a bit hairy, and I am not convinced it is
> without bugs.

The locking was already in there in aspeed_i2c_master_xfer but it
unlocks the protection to make a waiting for a completion. This code
is after the waiting so I added the locking to protect
'bus->master_state' variable which can be accessed from driver context
and from interrupt context.

Thanks,

Jae

