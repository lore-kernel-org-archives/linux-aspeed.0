From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 17 Sep 2018 10:16:59 -0700
Subject: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
In-Reply-To: <20180917163401.GA1082@kunai>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
 <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
 <20180917163401.GA1082@kunai>
Message-ID: <037b4cf8-5dfa-d554-b126-a2462ba9c803@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/17/2018 9:34 AM, Wolfram Sang wrote:
> 
>> Looks good to me. Thanks! :)
>>
>> Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Does that mean I need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle
> master/slave combined irq events properly" in i2c/for-next? And apply
> this to i2c/for-current?
> 
> (and please quote only relevat parts of a message when replying)
> 

No need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle master/slave
combined irq events properly". This patch should be applied on top of
the patch.

(Will reduce message size when replying. Thanks!)

Jae
