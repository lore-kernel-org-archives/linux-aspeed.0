From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 10 Jul 2020 10:43:59 +0930
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Fix clock divider calculation
In-Reply-To: <20200709195706.12741-3-eajames@linux.ibm.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com>
 <20200709195706.12741-3-eajames@linux.ibm.com>
Message-ID: <4acad452-33c7-4fb2-ba90-19a824558b94@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 10 Jul 2020, at 05:27, Eddie James wrote:
> When calculating the clock divider, start dividing at 2 instead of 1.
> The divider is divided by two at the end of the calculation, so starting
> at 1 may result in a divider of 0, which shouldn't happen.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
