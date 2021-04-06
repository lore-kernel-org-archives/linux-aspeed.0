From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 6 Apr 2021 07:26:26 +0200
Subject: [PATCH] usb: gadget: aspeed: Remove unnecessary version.h includes
In-Reply-To: <1617681598-28165-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1617681598-28165-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Message-ID: <YGvxAmHIgnRMcyuq@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 06, 2021 at 11:59:58AM +0800, Jiapeng Chong wrote:
> "make versioncheck" shows:
> 
> ./drivers/usb/gadget/udc/aspeed-vhub/hub.c: 33 linux/version.h not
> needed.

Then you need to fix the tool, and always test-build patches before you
send them out, as this is obviously wrong :(

