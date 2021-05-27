From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 27 May 2021 11:09:33 +0930
Subject: [PATCH] ARM: dts: aspeed: Set earlycon boot argument
In-Reply-To: <20210526051220.136432-1-joel@jms.id.au>
References: <20210526051220.136432-1-joel@jms.id.au>
Message-ID: <2176d536-c7c0-482a-84eb-b1d02da1b067@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 26 May 2021, at 14:42, Joel Stanley wrote:
> 
> Most of the aspeed boards have copied the 'earlyprink' string in
> the bootargs. However, there's no earlyprink driver configured in the
> defconfigs, so this does nothing.
> 
> A combination of setting stdout in the chosen node and adding earlycon
> to bootargs causes early serial output to appear early. This changes all
> boards to use this option.
> 
> The console=ttyS4,115200 option is still required, as this is used by
> the run time uart driver.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
