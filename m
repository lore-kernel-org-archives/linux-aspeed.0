From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 26 Apr 2018 14:38:08 -0700
Subject: [PATCH] serial/aspeed-vuart: fix a couple mod_timer() calls
In-Reply-To: <20180426055055.GA9742@mwanda>
References: <20180426055055.GA9742@mwanda>
Message-ID: <5a454ea3-9a5c-349c-f094-0f3eecf9cba2@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

> The "unthrottle_timeout" is HZ/10 but mod_timer() takes a the actual
> jiffie where you want it to timeout, not an offset.

Ah, of course.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
