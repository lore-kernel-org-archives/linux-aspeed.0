From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 24 Feb 2020 10:36:47 +1030
Subject: [PATCH] drm: aspeed: Fix GENMASK misuse
In-Reply-To: <20200222235152.242816-1-megous@megous.com>
References: <20200222235152.242816-1-megous@megous.com>
Message-ID: <020e9eb5-4fdc-44d0-b00e-42b6e6435110@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sun, 23 Feb 2020, at 10:21, Ondrej Jirman wrote:
> Arguments to GENMASK should be msb >= lsb.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
> I just grepped the whole kernel tree for GENMASK argument order issues,
> and this is one of the three that popped up. No testing was done.

I think someone's sent a patch previously, and last time it turned into a
discussion about how the macros aren't actually used and could be
removed.

Regardless:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
