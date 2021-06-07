From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Jun 2021 09:28:28 +0930
Subject: [PATCH] ARM: config: aspeed: Add DEBUG_FS and EXT4
In-Reply-To: <20210603040906.125109-1-joel@jms.id.au>
References: <20210603040906.125109-1-joel@jms.id.au>
Message-ID: <30d321ed-cb87-4bf9-b931-7b9725e327e7@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 3 Jun 2021, at 13:39, Joel Stanley wrote:
> DEBUG_FS was lost way back in v5.5, and EXT4 is used by ast2600 systems
> that have MMC.
> 
> Fixes: 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS dependency")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
