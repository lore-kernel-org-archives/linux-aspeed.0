From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 13 Sep 2019 09:48:56 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_-next_2/2]_media:_aspeed:_set_hsync_and_vsync_polar?=
 =?UTF-8?Q?ities_to_normal_before_starting_mode_detection?=
In-Reply-To: <490bc4d9-e471-3b0f-49c9-39e99af95d62@linux.intel.com>
References: <20190910190756.31432-1-jae.hyun.yoo@linux.intel.com>
 <20190910190756.31432-3-jae.hyun.yoo@linux.intel.com>
 <5c5538e7-4b7a-4d13-b4ac-584be4090d48@www.fastmail.com>
 <490bc4d9-e471-3b0f-49c9-39e99af95d62@linux.intel.com>
Message-ID: <2c24c8a9-b357-4948-8744-3900ed28012c@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 13 Sep 2019, at 02:36, Jae Hyun Yoo wrote:
> On 9/11/2019 10:39 PM, Andrew Jeffery wrote:
> > 
> > 
> > On Wed, 11 Sep 2019, at 04:37, Jae Hyun Yoo wrote:
> >> Sometimes it detects a weird resolution such as 1024x287 when the
> >> actual resolution is 1024x768. To resolve such an issue, this
> >> commit adds clearing for hsync and vsync polarity register bits
> >> at the beginning of the first mode detection. This is recommended
> >> in the datasheet.
> > 
> > I guess this answers my question on the previous patch's commit
> > message. Maybe it should be in both?
> 
> I think the previous patch is a bug fix and this one is an enhancement
> patch. Better splitting them.

I wasn't suggesting squashing the patches, I was suggesting updating
the commit message of the first patch to better justify/explain the
change.

Andrew
