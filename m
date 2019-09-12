From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 12 Sep 2019 15:03:00 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_-next_1/2]_media:_aspeed:_refine_hsync/vsync_polari?=
 =?UTF-8?Q?ty_setting_logic?=
In-Reply-To: <20190910190756.31432-2-jae.hyun.yoo@linux.intel.com>
References: <20190910190756.31432-1-jae.hyun.yoo@linux.intel.com>
 <20190910190756.31432-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <a11026fa-f2bb-47a2-b792-6009c2bbe63d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 11 Sep 2019, at 04:37, Jae Hyun Yoo wrote:
> This commit refines hsync/vsync polarity setting logic by making
> also clearing register bits possible based on probed sync state
> accordingly.

That was tough to parse, but I think I understand. Trying to rephrase:

Enable clearing of hsync/vsync plarity bits based on probed sync state.

What was the issue that drove the change? Do you know why it was done
the way it was prior to this patch?

Andrew
