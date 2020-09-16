From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 17 Sep 2020 08:48:45 +0930
Subject: [PATCH] soc: aspeed: Improve kconfig
In-Reply-To: <20200916125731.784527-1-joel@jms.id.au>
References: <20200916125731.784527-1-joel@jms.id.au>
Message-ID: <2a1617a0-5106-4b23-92fd-870b319e7598@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 16 Sep 2020, at 22:27, Joel Stanley wrote:
> Reword the kconfig text to be consistent and reflect that most drivers
> are available for all supported ASPEED chips (2400, 2500 and 2600).
> 
> Rearrange the symbols the SoC drivers depend on so the menu doesn't
> appear unless you are building for ASPEED for compile testing.
> 
> The SYSCON_MFD and REGMAP options are usually selected by drivers that
> need them, so do this.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
