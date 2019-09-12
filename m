From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 12 Sep 2019 10:06:12 -0700
Subject: [PATCH -next 2/2] media: aspeed: set hsync and vsync polarities
 to normal before starting mode detection
In-Reply-To: <5c5538e7-4b7a-4d13-b4ac-584be4090d48@www.fastmail.com>
References: <20190910190756.31432-1-jae.hyun.yoo@linux.intel.com>
 <20190910190756.31432-3-jae.hyun.yoo@linux.intel.com>
 <5c5538e7-4b7a-4d13-b4ac-584be4090d48@www.fastmail.com>
Message-ID: <490bc4d9-e471-3b0f-49c9-39e99af95d62@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/11/2019 10:39 PM, Andrew Jeffery wrote:
> 
> 
> On Wed, 11 Sep 2019, at 04:37, Jae Hyun Yoo wrote:
>> Sometimes it detects a weird resolution such as 1024x287 when the
>> actual resolution is 1024x768. To resolve such an issue, this
>> commit adds clearing for hsync and vsync polarity register bits
>> at the beginning of the first mode detection. This is recommended
>> in the datasheet.
> 
> I guess this answers my question on the previous patch's commit
> message. Maybe it should be in both?

I think the previous patch is a bug fix and this one is an enhancement
patch. Better splitting them.

Thanks,
Jae
