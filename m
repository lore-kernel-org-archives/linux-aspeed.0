From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 12 Sep 2019 15:09:19 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_-next_2/2]_media:_aspeed:_set_hsync_and_vsync_polar?=
 =?UTF-8?Q?ities_to_normal_before_starting_mode_detection?=
In-Reply-To: <20190910190756.31432-3-jae.hyun.yoo@linux.intel.com>
References: <20190910190756.31432-1-jae.hyun.yoo@linux.intel.com>
 <20190910190756.31432-3-jae.hyun.yoo@linux.intel.com>
Message-ID: <5c5538e7-4b7a-4d13-b4ac-584be4090d48@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 11 Sep 2019, at 04:37, Jae Hyun Yoo wrote:
> Sometimes it detects a weird resolution such as 1024x287 when the
> actual resolution is 1024x768. To resolve such an issue, this
> commit adds clearing for hsync and vsync polarity register bits
> at the beginning of the first mode detection. This is recommended
> in the datasheet.

I guess this answers my question on the previous patch's commit
message. Maybe it should be in both?

Andrew
