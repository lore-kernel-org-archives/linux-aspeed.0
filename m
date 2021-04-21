From: 种嘉鹏 <jiapeng.chong@linux.alibaba.com>
Date: Wed, 21 Apr 2021 10:06:43 +0800
Subject: [PATCH] usb: gadget: aspeed: Remove unnecessary version.h includes
In-Reply-To: <YGvxAmHIgnRMcyuq@kroah.com>
References: <1617681598-28165-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <YGvxAmHIgnRMcyuq@kroah.com>
Message-ID: <971ce789-9633-1799-6c55-50b79f2f179e@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021/4/6 13:26, Greg KH wrote:
> On Tue, Apr 06, 2021 at 11:59:58AM +0800, Jiapeng Chong wrote:
>> "make versioncheck" shows:
>>
>> ./drivers/usb/gadget/udc/aspeed-vhub/hub.c: 33 linux/version.h not
>> needed.
> 
> Then you need to fix the tool, and always test-build patches before you
> send them out, as this is obviously wrong :(
> 
Sorry for the noise. We'll do more test-build towards patches next time.

