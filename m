From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 19 Aug 2021 16:28:32 +0930
Subject: [PATCH 0/4] ARM: config: aspeed: Defconfig updates
In-Reply-To: <20210819065203.2620911-1-joel@jms.id.au>
References: <20210819065203.2620911-1-joel@jms.id.au>
Message-ID: <fb7380ff-55ed-41aa-a446-28f7235b4d9f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 19 Aug 2021, at 16:21, Joel Stanley wrote:
> Here are some defconfig updates that we've been using in the openbmc
> distro kernel tree for a while now.
> 
> Joel Stanley (4):
>   ARM: config: aspeed: Enable hardened allocator feature
>   ARM: config: aspeed: Enable KCS adapter for raw SerIO
>   ARM: config: aspeed_g4: Enable EDAC and SPGIO
>   ARM: config: aspeed: Regenerate defconfigs
> 
>  arch/arm/configs/aspeed_g4_defconfig | 16 +++++-----------
>  arch/arm/configs/aspeed_g5_defconfig | 25 +++++++++----------------
>  2 files changed, 14 insertions(+), 27 deletions(-)

For the series:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
