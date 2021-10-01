From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 1 Oct 2021 10:06:47 -0700
Subject: [PATCH v4 0/4] i2c: aspeed: Add buffer and DMA modes support
In-Reply-To: <20210930024448.GU17315@packtop>
References: <20210224191720.7724-1-jae.hyun.yoo@linux.intel.com>
 <20210930024448.GU17315@packtop>
Message-ID: <95dd9359-7dc0-00ce-2867-b35c3b4ebb2f@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Zev,

On 9/29/2021 7:44 PM, Zev Weiss wrote:
> On Wed, Feb 24, 2021 at 11:17:16AM PST, Jae Hyun Yoo wrote:
>> This patch series adds buffer mode and DMA mode transfer support for the
>> Aspeed I2C driver. With this change, buffer mode and DMA mode can be
>> selectively used depend on platform configuration.
>>
> 
> Any updates on these patches?  They provide a welcome performance
> improvement for some stuff I've been doing -- for the v4 series:
> 
> Tested-by: Zev Weiss <zweiss@equinix.com>

Thanks for sharing your test result.

I'm bringing this patch set back to discussion.

Thanks,
Jae
