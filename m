From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 09 Jun 2021 09:13:26 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_dts:_aspeed:_Drop_wrong_and_inconsistent_"sdh?=
 =?UTF-8?Q?ci"_compatible?=
In-Reply-To: <20210608220247.2237139-1-sudeep.holla@arm.com>
References: <20210608220247.2237139-1-sudeep.holla@arm.com>
Message-ID: <88e0e13a-1497-49b9-8518-f3f94a92ba71@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 9 Jun 2021, at 07:32, Sudeep Holla wrote:
> As per mmc/aspeed,sdhci.yaml, "sdhci" is not a valid compatible. In fact,
> it is not documented at all(including old txt bindings). Also it is
> pretty inconsistent within the same dtsi. Once instance of controller
> refers to it while the other doesn't.
> 
> Fix it by dropping the wrong "sdhci" compatible.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

No idea what happened there. Thanks for the cleanup.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
