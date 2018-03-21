From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 21 Mar 2018 11:32:27 +0800
Subject: [PATCH 5/5] serial/aspeed-vuart: Implement quick throttle
 mechanism
In-Reply-To: <CACPK8Xc+BhX+8o3-z1tVWCc81rCnf5EBaFA8VqU64ywvJg6aZw@mail.gmail.com>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-6-jk@ozlabs.org>
 <CACPK8Xc+BhX+8o3-z1tVWCc81rCnf5EBaFA8VqU64ywvJg6aZw@mail.gmail.com>
Message-ID: <acd1382f-b2fe-3476-b3a8-d4777b856f4c@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> The diff is a bit confusing, considering you just added these
> functions. Can you explain why you did it that way?

Sure. The initial versions were the standard callbacks for struct
uart_ops, which all need to take the port lock.

Patch 5/5 needs a lockless version of these for calling from the irq
handler, which already has the lock held. So, we introduce the
__-versions there.

I could add the lockless version in the earlier 4.5 patch, but it looks
a bit redundant there. Happy to go either way. Or, I can elaborate why
in the commit log (I'll need a v2 anyway for the setup_timer change...).

Cheers,


Jeremy
