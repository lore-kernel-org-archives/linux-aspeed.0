From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 12 Sep 2019 10:04:16 -0700
Subject: [PATCH -next 1/2] media: aspeed: refine hsync/vsync polarity
 setting logic
In-Reply-To: <a11026fa-f2bb-47a2-b792-6009c2bbe63d@www.fastmail.com>
References: <20190910190756.31432-1-jae.hyun.yoo@linux.intel.com>
 <20190910190756.31432-2-jae.hyun.yoo@linux.intel.com>
 <a11026fa-f2bb-47a2-b792-6009c2bbe63d@www.fastmail.com>
Message-ID: <564501a5-f4db-b1ed-76b5-9e76c29aa7d4@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 9/11/2019 10:33 PM, Andrew Jeffery wrote:
> On Wed, 11 Sep 2019, at 04:37, Jae Hyun Yoo wrote:
>> This commit refines hsync/vsync polarity setting logic by making
>> also clearing register bits possible based on probed sync state
>> accordingly.
> 
> That was tough to parse, but I think I understand. Trying to rephrase:
> 
> Enable clearing of hsync/vsync plarity bits based on probed sync state.

Correct.

> What was the issue that drove the change? Do you know why it was done
> the way it was prior to this patch?

Because this driver detects weird resolutions sometimes. Investigated
that it uses
     aspeed_video_update(video, VE_CTRL, 0, ctrl);
so only setting of polarity bits is available. Means that clearing of
the bits isn't available so it can't set back the polarities to normal.

To fix the issue, this patch makes it use
     aspeed_video_write(video, VE_CTRL, ctrl);
instead of above one with adding bit masking code changes.

Thanks,
Jae
